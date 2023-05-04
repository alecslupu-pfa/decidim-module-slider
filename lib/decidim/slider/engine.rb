# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module Slider
    # This is the engine that runs on the public interface of slider.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Slider

      routes do
        # Add engine routes here
        # resources :slider
        # root to: "slider#index"
      end

      initializer "slider.register.homepage_block" do
        Decidim.content_blocks.register(:homepage, :slider) do |content_block|
          content_block.cell = "decidim/slider/homepage/main"
          content_block.settings_form_cell = "decidim/slider/homepage/settings"

          content_block.public_name_key = "decidim.content_blocks.slider.name"

          content_block.settings do |settings|
            settings.attribute :upload_size, type: :integer, default: 500
            settings.attribute :autoplay, type: :boolean, default: true
          end
        end
      end

      initializer "slider.register.tabs.image" do
        Decidim.content_blocks.register(:slider_tabs, :image) do |content_block|
          content_block.cell = "decidim/slider/tabs/image/main"
          content_block.settings_form_cell = "decidim/slider/tabs/image/settings"
          content_block.public_name_key = "decidim.content_blocks.slider.tabs.image"

          content_block.images = [
            {
              name: :image,
              uploader: "Decidim::Slider::ImageUploader"
            }
          ]

          content_block.settings do |settings|
            settings.attribute :title, type: :text, translated: true
            settings.attribute :content, type: :text, translated: true
            settings.attribute :cta, type: :text, translated: true, required: false
            settings.attribute :url, type: :text, translated: true, required: false
            settings.attribute :accessibility_label, type: :text, translated: true, required: false
            settings.attribute :secondary_cta, type: :text, translated: true, required: false
            settings.attribute :secondary_url, type: :text, translated: true, required: false
          end
        end
      end

      initializer "slider.register.tabs.video" do
        Decidim.content_blocks.register(:slider_tabs, :video_text) do |content_block|
          content_block.cell = "decidim/slider/tabs/video_text/main"
          content_block.settings_form_cell = "decidim/slider/tabs/video_text/settings"
          content_block.public_name_key = "decidim.content_blocks.slider.tabs.video_text"

          content_block.images = [
            name: :video,
            uploader: "Decidim::Slider::VideoUploader"
          ]

          content_block.settings do |settings|
            settings.attribute :title, type: :text, translated: true
            settings.attribute :content, type: :text, translated: true
            settings.attribute :cta, type: :text, translated: true, required: false
            settings.attribute :url, type: :text, translated: true, required: false
            settings.attribute :accessibility_label, type: :text, translated: true, required: false
            settings.attribute :secondary_cta, type: :text, translated: true, required: false
            settings.attribute :secondary_url, type: :text, translated: true, required: false

            settings.attribute :loop, type: :boolean, default: true
            settings.attribute :autoplay, type: :boolean, default: true
            settings.attribute :muted, type: :boolean, default: true
            settings.attribute :controls, type: :boolean, default: true
            settings.attribute :playsinline, type: :boolean, default: true
          end
        end
      end

      initializer "slider.register.add_cells_view_paths" do
        Cell::ViewModel.view_paths << File.expand_path("#{Decidim::Slider::Engine.root}/app/cells")
        Cell::ViewModel.view_paths << File.expand_path("#{Decidim::Slider::Engine.root}/app/views") # for partials
      end

      initializer "slider.webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("app/packs", root)
      end
    end
  end
end
