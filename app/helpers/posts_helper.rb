module PostsHelper
  COVERS = [
    "from-orange-500 via-rose-500 to-violet-600",
    "from-emerald-500 via-teal-600 to-cyan-700",
    "from-violet-600 via-indigo-600 to-blue-700",
    "from-amber-500 via-orange-600 to-rose-600",
    "from-stone-800 via-stone-900 to-black",
    "from-sky-500 via-indigo-600 to-violet-700"
  ].freeze

  def cover_gradient(post)
    COVERS[(post.id || post.object_id) % COVERS.size]
  end

  def reading_time(post)
    words = post.content.to_s.split.size
    mins = [(words / 200.0).ceil, 1].max
    "#{mins} min read"
  end

  def post_excerpt(post, length = 160)
    truncate(post.content.to_s.strip, length: length, separator: " ")
  end

  def author_initials(post)
    post.title.to_s.split.first(2).map { |w| w[0] }.join.upcase.presence || "OB"
  end
end
