class Job < ApplicationRecord

  belongs_to :student, class_name: "User", foreign_key: "student_id", optional: true
  belongs_to :tutor, class_name: "User",  foreign_key: "tutor_id", optional: true
  belongs_to :topic


  def self.looking_for_tutors
    Job.where(tutor_id: nil)
  end

  def self.looking_for_students
    Job.where(student_id: nil)
  end

  def has_student?
    !!self.student
  end

  def has_tutor?
    !!self.tutor
  end

  def self.search(search)
    if search
      # byebug
    topic = Topic.find_by(name: search)
      if !!topic
        # byebug
        self.where(topic_id: topic.id)
      else
        Job.all
      end
    else
      Job.all
    end
    # byebug
  end

  # def topic
  #   Topic.find(self.topic_id)
  # end

end
