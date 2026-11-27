xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.channel do
    xml.title "OmniBlog"
    xml.link root_url
    xml.description "Stories worth reading"
    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.link post_url(post)
        xml.description post.excerpt.presence || post.content.to_s.truncate(200)
        xml.pubDate post.published_at&.rfc2822
        xml.guid post_url(post)
      end
    end
  end
end
