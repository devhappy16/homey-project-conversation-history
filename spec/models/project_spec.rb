require "rails_helper"

RSpec.describe Project, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "validations" do
    it { should validate_presence_of(:name) }
    it "should validate enum status" do
      expect(Project.statuses.keys).to eq(%w[todo active completed])
    end
  end

  describe "associations" do
    it { should belong_to(:manager_user).class_name("User").optional(true) }
    it { should have_many(:project_users) }
    it { should have_many(:users).through(:project_users) }
    it { should have_many(:comments) }
    it { should have_many(:project_conversation_histories) }
  end

  describe "status change tracking" do
    let(:user) { create(:user) }
    let(:project) { create(:project, status: :todo) }

    before do
      allow(Current).to receive(:user).and_return(user)
    end

    it "creates a conversation history when status changes" do
      expect {
        project.update!(status: :active)
      }.to change(ProjectConversationHistory, :count).by(1)

      history = project.project_conversation_histories.last
      expect(history.history_type).to eq("project_status_update")
      expect(history.user).to eq(user)
      expect(history.previous_value).to eq("todo")
      expect(history.new_value).to eq("active")
    end

    it "does not create conversation history when status remains the same" do
      expect {
        project.update!(name: "New Name")
      }.not_to change(ProjectConversationHistory, :count)
    end

    it "tracks multiple status changes" do
      expect {
        project.update!(status: :active)
        project.update!(status: :completed)
      }.to change(ProjectConversationHistory, :count).by(2)

      histories = project.project_conversation_histories.order(created_at: :asc)

      first_change = histories.first
      expect(first_change.previous_value).to eq("todo")
      expect(first_change.new_value).to eq("active")

      second_change = histories.last
      expect(second_change.previous_value).to eq("active")
      expect(second_change.new_value).to eq("completed")
    end
  end
end
