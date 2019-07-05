class Agent < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  has_many :roles, dependent: :destroy
  has_many :apps, through: :roles, source: :app   
  has_many :assignment_rules

  has_many :conversations, foreign_key: "assignee_id"


  store_accessor :properties, [ 
    :name, 
    :first_name, 
    :last_name, 
    :country, 
    :country_code, 
    :region, 
    :region_code 
  ]


  def display_name
    [self.name, self.email].join(" ")
  end


  def as_json(options = nil)
    super({ 
      only: [:email, :id, :kind, :display_name] , 
      methods: [:email, :id, :kind, :display_name] }
      .merge(options || {})
    )
  end

  def kind
    self.class.model_name.singular
  end
end