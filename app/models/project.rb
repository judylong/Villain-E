class Project < ActiveRecord::Base
  # validates :goal, format: { with: /^[0-9]+$/, on: :create}
  has_attached_file :image, default_url: "missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to :owner,
    class_name: "User",
    foreign_key: "owner_id"

  belongs_to :category

  has_many :rewards

  has_many :project_backers, through: :rewards, source: :reward_backers
  has_many :backed_rewards, through: :project_backers, source: :backed_rewards
end
