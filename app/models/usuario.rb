class Usuario < ApplicationRecord
  validates :nombre, presence: true
  validates :usuario, presence: true
end
