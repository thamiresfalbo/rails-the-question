require 'test_helper'

class AdminsBackoffice::QuestionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_backoffice_questions_index_url
    assert_response :success
  end

end
