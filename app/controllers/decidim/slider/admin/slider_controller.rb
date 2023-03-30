# frozen_string_literal: true

module Decidim
  module Slider
    module Admin
      class SliderController < Decidim::Admin::ApplicationController
        layout "decidim/admin/settings"

        helper_method :content_blocks_title, :add_content_block_text, :available_manifests, :active_content_blocks_title,
                      :resource_sort_url, :active_blocks, :scoped_resource, :inactive_content_blocks_title,
                      :inactive_blocks, :resource_create_url, :resource_content_block_cell, :content_block_destroy_confirmation_text

        def update
          enforce_permission_to_update_resource
          patch_organization
          ReorderContentBlocks.call(current_organization, content_block_scope, params[:ids_order], scoped_resource&.id) do
            on(:ok) do
              head :ok
            end
            on(:invalid) do
              head :bad_request
            end
          end
        end

        def content_block_destroy_confirmation_text
          t("slider.edit.destroy_confirmation", scope: "decidim.admin")
        end

        private

        def patch_organization
          upload_size = Decidim::ContentBlock.published.where(
            organization: current_organization,
            manifest_name: :slider
          ).last&.settings&.upload_size

          current_organization.settings.upload.maximum_file_size.default = upload_size if upload_size.present?
        end

        def scoped_resource; end

        def available_manifests
          @available_manifests ||= Decidim.content_blocks.for(content_block_scope)
        end

        # Shared methods
        def content_blocks
          @content_blocks ||= Decidim::ContentBlock.for_scope(
            content_block_scope,
            organization: current_organization
          ).where(scoped_resource_id: scoped_resource&.id, manifest_name: available_manifests.map(&:name))
        end

        def inactive_blocks
          @inactive_blocks ||= content_blocks.unpublished
        end

        def active_blocks
          @active_blocks ||= content_blocks.published
        end

        def resource_create_url(manifest_name)
          tabs_path(manifest_name: manifest_name)
        end

        def content_block_scope
          :slider_tabs
        end

        def resource_sort_url
          update_path
        end

        def content_blocks_title
          # t("organization_homepage.edit.title", scope: "decidim.admin")
          "The title for Tabs"
        end

        def active_content_blocks_title
          "Active Blocks"
        end

        def add_content_block_text
          # t("organization_homepage.edit.add", scope: "decidim.admin")
          "Add Tabs"
        end

        def inactive_content_blocks_title
          "Inactive Tabs"
        end

        def resource_content_block_cell
          "decidim/slider/admin/administrable_content_block"
        end

        def enforce_permission_to_update_resource
          enforce_permission_to :update, :organization, organization: current_organization
        end
      end
    end
  end
end
