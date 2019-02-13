class User < ApplicationRecord
  has_many :job_postings, class_name: "Job", foreign_key: "student_id"
  has_many :teaching_jobs, class_name: "Job", foreign_key: "tutor_id"

  has_many :user_topics
  has_many :topics, through: :user_topics

  def subjects
    self.topics.map do |topic|
      topic.subject
    end.uniq
  end

  has_secure_password

end
