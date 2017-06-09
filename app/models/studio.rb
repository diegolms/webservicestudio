class Studio < ActiveRecord::Base
  belongs_to :arquivo

  validates_presence_of :nome, :message => "Nome do studio inválido"
end
