module UsersHelper
  def is_current_user?(user)
    user.id == current_user.id
  end

  def is_valid_coord?(coord)
    !coord.nil? && !coord.empty?
  end

  # Returns the Gravatar for the given user.
  def gravatar_profile_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    "https://www.gravatar.com/#{gravatar_id}"
  end

  def gravatar_for(user, size=80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://www.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=mp" # another option: "d=wavatar"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
  
  # Generates a cache key
  def cache_key_for_user(user)
      "user-#{user.name}-#{user.created_at}-#{user.bio}"
  end
end
