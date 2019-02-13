class Job < ApplicationRecord
  belongs_to :student, class_name: "User", foreign_key: "student_id", optional: true
  belongs_to :tutor, class_name: "User",  foreign_key: "tutor_id", optional: true
end
