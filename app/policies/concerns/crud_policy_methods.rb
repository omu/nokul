# frozen_string_literal: true

module CrudPolicyMethods
  extend ActiveSupport::Concern

  included do
    def create?
      permitted? :write
    end

    def destroy?
      permitted? :destroy
    end

    def edit?
      update?
    end

    def index?
      permitted? :read
    end

    def new?
      create?
    end

    def show?
      permitted? :read
    end

    def update?
      permitted? :write
    end
  end
end
