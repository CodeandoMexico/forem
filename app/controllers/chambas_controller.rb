class ChambasController < ApplicationController
  def index
    @filters = %w[Mexico Web-Developer Programación Issues]
    @var_back = params[:filter_active]
  end
end
