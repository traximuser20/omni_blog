require "test_helper"

class DeviseViewsTest < ActionDispatch::IntegrationTest
  test "login page renders input fields and password toggle" do
    get new_user_session_path
    assert_response :success
    assert_select "input[type=email][name='user[email]']"
    assert_select "input[name='user[password]'][data-password-visibility-target='input']"
    assert_select "button[data-action='click->password-visibility#toggle']"
    assert_select "[data-password-visibility-target='visible']"
    assert_select "[data-password-visibility-target='hidden'].hidden"
  end

  test "sign up page renders input fields and password toggles" do
    get new_user_registration_path
    assert_response :success
    assert_select "input[type=email][name='user[email]']"
    assert_select "input[name='user[password]'][data-password-visibility-target='input']"
    assert_select "input[name='user[password_confirmation]'][data-password-visibility-target='input']"
    assert_select "button[data-action='click->password-visibility#toggle']", count: 2
  end

  test "forgot password page renders email input field" do
    get new_user_password_path
    assert_response :success
    assert_select "input[type=email][name='user[email]']"
  end

  test "reset password page renders new password inputs and toggles" do
    get edit_user_password_path(reset_password_token: "mock-token")
    assert_response :success
    assert_select "input[name='user[password]'][data-password-visibility-target='input']"
    assert_select "input[name='user[password_confirmation]'][data-password-visibility-target='input']"
    assert_select "button[data-action='click->password-visibility#toggle']", count: 2
  end
end
