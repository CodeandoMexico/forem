json.extract! admin_course, :id, :name, :published, :slug, :description, :meta_description, :meta_title, :created_at, :updated_at
json.url admin_course_url(admin_course, format: :json)
