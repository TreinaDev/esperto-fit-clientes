class Personal < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
       
  validates :name, :cref, :cpf , presence: true
  validate :validate_cpf
  validate :validate_cref

  def validate_cpf
    if cpf.present? and not CPF.valid?(cpf, strict: true)
      errors.add(:cpf, 'inválido')
    end
  end

  def validate_cref
    if cref.present? and cref.size == 11
      cref.split('').each_with_index do |word, i| 
        if i < 6
          errors.add(:cref, 'inválido') if not '0123456789'.include?(word) 
        elsif  cref[6] != '-'
          errors.add(:cref, 'inválido')
        elsif cref[8] != '/'
          errors.add(:cref, 'inválido')
        elsif cref[7] != 'G' and cref[7] != 'P'
          errors.add(:cref, 'inválido')
        elsif i > 8 
          errors.add(:cref, 'inválido') if not 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.include?(word) 
        end 
      end
    else
      errors.add(:cref, 'inválido')
    end
  end
end
