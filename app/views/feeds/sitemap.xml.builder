xml.instruct! :xml, version: "1.0"
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  xml.url { xml.loc root_url; xml.changefreq "daily" }
  @posts.each do |post|
    xml.url { xml.loc post_url(post); xml.lastmod post.updated_at.iso8601 }
  end
  @categories.each do |c|
    xml.url { xml.loc category_url(c) }
  end
  @tags.each do |t|
    xml.url { xml.loc tag_url(t) }
  end
end
