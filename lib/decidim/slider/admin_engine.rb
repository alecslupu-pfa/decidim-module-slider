# frozen_string_literal: true

module Decidim
  module Slider
    # This is the engine that runs on the public interface of `Slider`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::Slider::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
        resources :tabs, except: [:show, :index]
        put "/update", to: "slider#update"
        root to: "slider#index"
      end

      initializer "slider.admin.routes" do
        Decidim::Admin::Engine.routes do
          mount Decidim::Slider::AdminEngine, at: "/organization/slider", as: :decidim_admin_slider
        end
      end

      initializer "slider.admin.menu_entries" do
        Decidim.menu :admin_settings_menu do |menu|
          menu.add_item :slider,
                        I18n.t("decidim.content_blocks.slider.admin_menu"),
                        decidim_admin_slider.root_path,
                        active: is_active_link?(decidim_admin_slider.root_path),
                        if: allowed_to?(:update, :organization, organization: current_organization)
        end
      end

      def load_seed
        nil
      end
    end
  end
end
