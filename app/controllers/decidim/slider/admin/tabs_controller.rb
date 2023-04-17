# frozen_string_literal: true

module Decidim
  module Slider
    module Admin
      class TabsController < Decidim::Admin::ApplicationController
        layout "decidim/admin/settings"

        helper_method :content_block_create_success_text, :content_block_create_error_text
        before_action :patch_organization

        # uncomment me when upgrading to Decidim 0.28
        # include Decidim::Admin::ContentBlocks::LandingPageContentBlocks
        # Remove me when upgrading to Decidim 0.28
        helper_method :content_block, :resource_landing_page_content_block_path, :scoped_resource, :submit_button_text

        def destroy
          enforce_permission_to_update_resource

          DestroyContentBlock.call(content_block) do
            on(:ok) do
              flash[:success] = content_block_destroy_success_text
            end
            on(:invalid) do
              flash[:error] = content_block_destroy_error_text
            end

            redirect_to edit_resource_landing_page_path
          end
        end

        # Remove me when upgrading to Decidim 0.28
        def create
          enforce_permission_to_update_resource

          CreateContentBlock.call(current_organization, content_block_scope, params[:manifest_name], scoped_resource&.id) do
            on(:ok) do
              flash[:success] = content_block_create_success_text
            end
            on(:invalid) do
              flash[:error] = content_block_create_error_text
            end

            redirect_to root_path
          end
        end

        # Remove me when upgrading to Decidim 0.28
        # Remove the template as well
        def edit
          enforce_permission_to_update_resource
          @form = form(Decidim::Admin::ContentBlockForm).from_model(content_block)
        end

        def update
          enforce_permission_to_update_resource

          patch_organization
          @form = form(Decidim::Admin::ContentBlockForm).from_params(params)

          UpdateContentBlock.call(@form, content_block, content_block_scope) do
            on(:ok) do
              redirect_to edit_resource_landing_page_path
            end
            on(:invalid) do
              edit # Sets the model to the view so that it can render the form
              render "edit"
            end
          end
        end

        private

        def submit_button_text
          t("slider.tabs.save", scope: "decidim.admin")
        end

        def content_block_create_error_text
          t("slider.tabs.create_error", scope: "decidim.admin")
        end

        def content_block_create_success_text
          t("slider.tabs.success_message", scope: "decidim.admin")
        end

        def content_block_destroy_success_text
          t("slider.tabs.destroy_message", scope: "decidim.admin")
        end

        def content_block_destroy_error_text
          t("slider.tabs.destroy_error", scope: "decidim.admin")
        end

        def patch_organization
          upload_size = Decidim::ContentBlock.published.where(
            organization: current_organization,
            manifest_name: :slider
          ).last&.settings&.upload_size

          content_block.organization.settings.upload.maximum_file_size.default = upload_size if upload_size.present? && content_block.present?
        end

        def edit_resource_landing_page_path
          root_path
        end

        def resource_landing_page_content_block_path
          tab_path(params[:id])
        end

        def scoped_resource; end

        def content_block_scope
          :slider_tabs
        end

        def enforce_permission_to_update_resource
          enforce_permission_to :update, :organization, organization: current_organization
        end

        # Remove me when upgrading to Decidim 0.28
        def content_blocks
          @content_blocks ||= Decidim::ContentBlock.for_scope(
            content_block_scope,
            organization: current_organization
          ).where(scoped_resource_id: scoped_resource&.id)
        end

        # Remove me when upgrading to Decidim 0.28
        def content_block
          return unless params[:id]

          @content_block ||= content_blocks.find(params[:id])
        end
      end
    end
  end
end
