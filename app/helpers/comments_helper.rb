module CommentsHelper
  # Display name for a comment author, derived from the account email.
  def comment_author(comment)
    comment.user&.email.to_s.split("@").first.presence || "Reader"
  end

  def comment_initials(comment)
    comment_author(comment).first(2).upcase
  end
end
