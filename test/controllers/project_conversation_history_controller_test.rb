require "test_helper"

class ProjectConversationHistoryControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get project_conversation_history_show_url
    assert_response :success
  end
end
