require "rails_helper"

RSpec.describe ProjectPolicy do
  let(:admin) { create(:user, :admin) }
  let(:manager) { create(:user, :manager) }
  let(:member) { create(:user) }

  before(:each) do
    @project = create(:project, manager_user_id: nil)
  end

  after(:each) do
    ProjectUser.destroy_all
    Project.destroy_all
  end

  describe "#index?" do
    it "allows access to all users governed by scope" do
      expect(ProjectPolicy.new(admin, @project).index?).to be true

      # manager not assigned to project
      expect(ProjectPolicy.new(manager, @project).index?).to be false

      @project.update(manager_user_id: manager.id)
      # after manager assignment to project
      expect(ProjectPolicy.new(manager, @project).index?).to be true

      # member not assigned to project
      expect(ProjectPolicy.new(member, @project).index?).to be false

      ProjectUser.create(project_id: @project.id, user_id: member.id)
      # after member assignment to project
      expect(ProjectPolicy.new(member, @project).index?).to be true
    end
  end

  describe "#show?" do
    it "allows admin to view any project" do
      expect(ProjectPolicy.new(admin, @project).show?).to be true
    end

    it "allows manager to view their managed projects" do
      expect(ProjectPolicy.new(manager, @project).show?).to be false

      @project.update(manager_user_id: manager.id)
      expect(ProjectPolicy.new(manager, @project).show?).to be true
    end

    it "allows member to view projects they are part of" do
      expect(ProjectPolicy.new(member, @project).show?).to be false

      ProjectUser.create(project_id: @project.id, user_id: member.id)
      expect(ProjectPolicy.new(member, @project).show?).to be true
    end
  end

  describe "#create?" do
    it "allows admin to create projects" do
      expect(ProjectPolicy.new(admin, @project).create?).to be true
    end

    it "denies managers from creating projects" do
      expect(ProjectPolicy.new(manager, @project).create?).to be false

      @project.update(manager_user_id: manager.id)
      expect(ProjectPolicy.new(manager, @project).create?).to be false
    end

    it "denies members from creating projects" do
      expect(ProjectPolicy.new(member, @project).create?).to be false

      ProjectUser.create(project_id: @project.id, user_id: member.id)
      expect(ProjectPolicy.new(member, @project).create?).to be false
    end
  end

  describe "#update?" do
    it "allows admin to edit any project" do
      expect(ProjectPolicy.new(admin, @project).update?).to be true
    end

    it "allows manager to edit their managed projects" do
      expect(ProjectPolicy.new(manager, @project).update?).to be false

      @project.update(manager_user_id: manager.id)
      expect(ProjectPolicy.new(manager, @project).update?).to be true
    end

    it "denies members from editing projects" do
      expect(ProjectPolicy.new(member, @project).update?).to be false

      ProjectUser.create(project_id: @project.id, user_id: member.id)
      expect(ProjectPolicy.new(member, @project).update?).to be false
    end
  end

  describe "#destroy?" do
    it "allows admin to delete any project" do
      expect(ProjectPolicy.new(admin, @project).destroy?).to be true
    end

    it "denies managers from deleting projects" do
      expect(ProjectPolicy.new(manager, @project).destroy?).to be false

      @project.update(manager_user_id: manager.id)
      expect(ProjectPolicy.new(manager, @project).destroy?).to be false
    end

    it "denies members from deleting projects" do
      expect(ProjectPolicy.new(member, @project).destroy?).to be false

      ProjectUser.create(project_id: @project.id, user_id: member.id)
      expect(ProjectPolicy.new(member, @project).update?).to be false
    end
  end
end
