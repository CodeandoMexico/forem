require "rss"
require "rss/itunes"

module Podcasts
  class Feed
    def initialize(podcast)
      @podcast = podcast
    end

    # @note While the limit might look generous, the callers are passing the value (which they
    #       themselves receive elsewhere).  In one case, the :limit is 5
    #
    # @see Podcasts::EnqueueGetEpisodesWorker
    def get_episodes(limit: 100, force_update: false)
      # increased the redirect limit from 5 (default) to 7 to be able to handle such urls
      rss = HTTParty.get(podcast.feed_url, limit: 7).body.to_s
      feed = RSS::Parser.parse(rss, false)

      set_unreachable(status: :unparsable, force_update: force_update) && return unless feed

      get_episode = Podcasts::GetEpisode.new(podcast)
      # NOTE: `sort { |a, b| b.pubDate <=> a.pubDate }` is logically equivalent to
      # `sort_by(&:pubDate).reverse` but only iterates once through the array.
      #
      # The sort ensures that we're fetching the most recently published episodes.  This addresses
      # https://github.com/forem/forem/issues/3580, in which some RSS feeds list their episodes in
      # earliest to latest, whereas others list latest to earliest.  We assume that we're wanting to
      # track the latest.
      feed.items.sort { |a, b| b.pubDate <=> a.pubDate }.first(limit).each do |item|
        get_episode.call(item: item, force_update: force_update)
      end
      podcast.update_columns(reachable: true, status_notice: "")
      feed.items.size
    rescue Net::OpenTimeout, Errno::ECONNREFUSED, SocketError, HTTParty::RedirectionTooDeep
      set_unreachable(status: :unreachable, force_update: force_update)
    rescue OpenSSL::SSL::SSLError
      set_unreachable(status: :ssl_failed, force_update: force_update)
    rescue RSS::NotWellFormedError
      set_unreachable(status: :unparsable, force_update: force_update)
    end

    private

    attr_reader :podcast

    def set_unreachable(status: :unreachable, force_update: false)
      # don't recheck if the podcast was already unreachable or force update is required
      need_refetching = podcast.reachable || force_update
      podcast.update_columns(reachable: false, status_notice: I18n.t(status, scope: "views.podcasts.statuses"))
      refetch_items if need_refetching
      true
    end

    # When setting podcast feed as unreachable, we need to re-check the episodes URLs.
    # If the episodes URLs are still reachable, the podcast will remain on the site.
    # If they are not, the podcast will be hidden.
    def refetch_items
      job_params = podcast.podcast_episodes.pluck(:id, :media_url)
      PodcastEpisodes::UpdateMediaUrlWorker.perform_bulk(job_params)
    end
  end
end
