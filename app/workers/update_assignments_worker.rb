# frozen_string_literal: true

require "#{Rails.root}/lib/wiki_course_edits"

class UpdateAssignmentsWorker
  include Sidekiq::Worker

  def self.schedule_edits(course:, editing_user:)
    perform_async(course.id, editing_user.id)
  end

  def perform(course_id, editing_user_id)
    course = Course.find(course_id)
    editing_user = User.find(editing_user_id)
    WikiCourseEdits.new(action: :update_assignments, course: course, current_user: editing_user)
  end
end
