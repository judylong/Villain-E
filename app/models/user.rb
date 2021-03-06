class User < ActiveRecord::Base
  validates :email, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :email, uniqueness: true


  validates :password_confirmation, length: { minimum: 6, allow_blank: true }
  validates :email_confirmation, length: { minimum: 1, allow_blank: true }
  validate :email_and_password_confirmation

  attr_reader :password
  attr_accessor :password_confirmation, :email_confirmation

  after_initialize :ensure_session_token

  has_many :projects,
    class_name: "Project",
    foreign_key: "owner_id"

  has_many :rewardings,
          class_name: "Rewarding",
          foreign_key: :backer_id

  has_many :backed_rewards, through: :rewardings, source: :reward

  has_many :backed_projects, through: :backed_rewards, source: :project


  has_attached_file :avatar, styles: { medium: "220x220>", thumb: "160x160>", default_url: "/images/:style/missing.png"}, default_url: "missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\.*\Z/

  def email_and_password_confirmation
    errors.add(:password, "does not match password confirmation") if password_confirmation && password != password_confirmation
    errors.add(:email, "does not match email confirmation") if email_confirmation && email != email_confirmation
  end

  def self.find_or_create_by_auth_hash(auth_hash)
    user = User.find_by(
            provider: auth_hash[:provider],
            uid: auth_hash[:uid])
    unless user
      user = User.create!(
            provider: auth_hash[:provider],
            uid: auth_hash[:uid],
            name: auth_hash[:info][:name],
            password: SecureRandom::urlsafe_base64,
            email: SecureRandom::urlsafe_base64+"faker@email.com")
    end
    user
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    user.try(:is_password?, password) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
end
