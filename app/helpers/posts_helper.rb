module PostsHelper
       def cache_key_for_post(post)
       	   "post-#{post.user_id}-#{post.created_at}-#{post.content}"
       end
end
