class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :secret_code, autosave: true

  attr_accessor :code
  validates_presence_of	:code, on: :create
  validate :secret_code_validation, unless: -> { code.blank? }, on: :create

  private

  # Validate secret code and create association when valid
  def secret_code_validation
    secret_code = SecretCode.where("code = ? AND user_id IS NULL", code).first
    if secret_code.present?
      secret_code.user = self
    else
      errors.add(:base, "Invalid secret code")
    end
  end
end
