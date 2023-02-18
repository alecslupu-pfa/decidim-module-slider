# frozen_string_literal: true

module Decidim
  module Slider
    module Admin
      # When upgrading to Decidim 0.28, use Decidim::Admin::ContentBlockCell instead of Decidim::ViewModel
      # And delete the show template corresponding to this cell
      class AdministrableContentBlockCell < Decidim::ViewModel
        include Decidim::IconHelper

        delegate :public_name_key, :has_settings?, to: :model
        delegate :content_block_destroy_confirmation_text, to: :controller

        def edit_content_block_path
          decidim_admin_slider.edit_tab_path(model)
        end

        def content_block_path
          decidim_admin_slider.tab_path(model)
        end

        def decidim_admin_slider
          Decidim::Slider::AdminEngine.routes.url_helpers
        end
      end
    end
  end
end
