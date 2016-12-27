class Empleado < ApplicationRecord
    before_save { self.usuario = usuario.downcase }
    validates :usuario, presence: true, uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true
end
