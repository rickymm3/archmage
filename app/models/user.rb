class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable
  before_destroy :destroy_structure_assignments
  has_many :user_structures, dependent: :delete_all
  has_many :structures, :through => :user_structures
  has_many :user_notifications, dependent: :delete_all
  has_many :notifications, :through => :user_notifications

  has_many :user_armies, dependent: :delete_all
  has_many :armies, :through => :user_armies
  has_and_belongs_to_many :roles

  def role?(role)
    return !!self.roles.find_by_name(role.to_s)
  end

  def make_admin
    self.roles << Role.admin
  end

  def revoke_admin
    self.roles.delete(Role.admin)
  end

  def admin?
    role?(:admin)
  end

  def destroy_structure_assignments
    self.user_structures.destroy_all
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['info']
    if user = User.find_by_email(data["email"])
      user
    else # Create a user with a stub password.
      User.create!(:email => data["email"], :password => Devise.friendly_token[0,20])
    end
  end

end
