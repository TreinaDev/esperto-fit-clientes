module ApplicationHelper
  def owner?(appointment)
    appointment.personal == current_personal
  end
end
