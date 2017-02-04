class User < ApplicationRecord

  has_many :trip_users
  has_many :trips, :through => :trip_users

  attr_accessor :password

  validates :name, presence: true, uniqueness: true, length: { in: 3..20 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, confirmation: true #password_confirmation attr
  validates_length_of :password, in: 6..20, :on => :create



  def save_and_update_password(password)
    self.encrypted_password = encrypt_password(password)
    self.save!
  end

  def authenticate(password)
    if valid_password?(password, self.encrypted_password)
      payload(self)
    else
      {json: {status: 'error', reason: {password: 'is incorrect'}}, status: 200}
    end
  end

  private

  def encrypt_password(password)
    BCrypt::Password.create(password)
  end

  def valid_password?(password, encrypted_password)
    BCrypt::Password.new(encrypted_password) == password
  end

  def payload(user)
    {
    json:
      {status: 'success',
       auth_token: JsonWebToken.encode({user_id: user.id}),
       user: {id: user.id, email: user.email}},
     status: 200
    }
  end
end