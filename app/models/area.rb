class Area < ApplicationRecord
  has_many :areas_chamba, dependent: :nil
end
