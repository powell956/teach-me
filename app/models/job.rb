class Job < ApplicationRecord

  belongs_to :student, class_name: "User", foreign_key: "student_id", optional: true
  belongs_to :tutor, class_name: "User",  foreign_key: "tutor_id", optional: true
  belongs_to :topic
  delegate :subject, :to => :topic, :allow_nil => true



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
    subject = Subject.find_by(name: search)
      if !!subject
        topics = Topic.where(subject_id: subject.id)
        topic_ids = topics.map {|topic| topic.id}
        self.where(topic_id: topic_ids)
      else
        Job.all
      end
    else
      Job.all
    end
  end

  # def topic
  #   Topic.find(self.topic_id)
  # end

end
