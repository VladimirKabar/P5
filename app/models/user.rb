class User < ActiveRecord::Base
  has_many :microposts, dependent:  :destroy #tu nie trzeba podac foreign_key bo domyslnie bierze go z klasy user - w tym wypadku user.id
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # bo jak sie niszczy usera to trzeba zniszczyc relacje
  has_many :following, through:  :active_relationships , source: :followed
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

    # attr_accessor :password, password_confimation -> has_secured password to robi juz
  attr_accessor :remember_token, :activation_token, :reset_token #reset token virtual atribute, jest ustawiony kiedy digest jest ustawiony
  before_save :downcase_email
  before_create :create_activation_digest
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, allow_blank: true
  has_secure_password





  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Returns a user in the datebase for use in persistent sessions.
  def remember #instance method tylko przywolana za pomoca User.remember a nie samo remember to w klasie session helper musi byc
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets a user
  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Activates an account.
  def activate
    self.update_attribute(:activated, true)
    self.update_attribute(:activated_at, Time.zone.now)
  end


  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Sets the password reset attributes. oooo ten!
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # Defines a proto-feed.
  # See "follwoing users" for the full implemenation.
  # Return a user's status feed.
  def feed
    # Micropost.where("user_id = ?", id) # unika sql injection
    following_ids_subselect = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids_subselect}) OR user_id = :user_id", user_id: id)
  end

  # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    self.following.include?(other_user) #mozna uzyc bez self
    # !active_relationships.find_by(followed_id: other_user.id).nil? to samo co wyzej
  end
  private

  # Converts email to all lower-case
  def downcase_email
    self.email = email.downcase
  end

  # Creates and assings the activation token and digest.
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end


end
