class Chamba < ApplicationRecord
  has_many :requerimientos_chamba, dependent: :destroy
end
