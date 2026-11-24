# frozen_string_literal: true

require "test_helper"

class AdminDashboardTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @admin_user = admin_users(:one)
  end

  test "redirects unauthenticated user to admin login" do
    get "/admin"
    assert_response :redirect
    assert_redirected_to new_admin_user_session_path
  end

  test "renders admin login page successfully" do
    get new_admin_user_session_path
    assert_response :success
    assert_select "title", text: /Login/
  end

  test "renders admin dashboard successfully for authenticated admin user" do
    sign_in @admin_user, scope: :admin_user
    get admin_root_path
    assert_response :success
    assert_select "title", text: /Dashboard/
  end
end
