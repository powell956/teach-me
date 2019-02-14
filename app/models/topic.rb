class Topic < ApplicationRecord
  belongs_to :subject
  has_many :user_topics
  has_many :users, through: :user_topics
  has_many :jobs


  def self.alphabetical
    self.all.sort_by { |t| t.name.downcase }
  end
end
