class Usuario < ApplicationRecord
  validates :nombre, presence: true
  validates :usuario, presence: true

  def self.GetAll
    results = all.select(:id, :nombre, :apellido, :usuario, :twitter)
  end

  def self.GetById id
    #result = find_by_id(id).select(:id, :nombre, :apellido, :usuario, :twitter) # No funciona
    result = where(id: id).select(:id, :nombre, :apellido, :usuario, :twitter).first
  end
end
