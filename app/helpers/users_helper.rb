module UsersHelper
  def is_current_user?(user)
    user.id == current_user.id
  end

  def is_valid_coord?(coord)
    !coord.nil? && !coord.empty?
  end
end
