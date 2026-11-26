require "test_helper"

class PostTest < ActiveSupport::TestCase
  setup do
    @post = posts(:one)
  end

  test "is valid with title and content" do
    assert Post.new(title: "Hello", content: "World").valid?
  end

  test "requires a title" do
    post = Post.new(title: " ", content: "World")
    assert_not post.valid?
    assert_includes post.errors[:title], "can't be blank"
  end

  test "requires content" do
    post = Post.new(title: "Hello", content: " ")
    assert_not post.valid?
    assert_includes post.errors[:content], "can't be blank"
  end

  test "limits title length" do
    post = Post.new(title: "a" * 121, content: "World")
    assert_not post.valid?
  end
end
