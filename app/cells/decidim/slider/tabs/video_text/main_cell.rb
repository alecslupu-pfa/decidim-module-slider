# frozen_string_literal: true

module Decidim
  module Slider
    module Tabs
      module VideoText
        class MainCell < ::Decidim::Slider::Tabs::Generic::MainCell
          def uploader_name
            :video
          end

          def video_url
            asset.path
          end

          def settings
            {
              controls: model.settings.controls,
              autoplay: model.settings.autoplay,
              muted: model.settings.muted,
              loop: model.settings.loop,
              playsinline: model.settings.playsinline
            }.select { |_, v| v }.keys.join(" ")
          end
        end
      end
    end
  end
end
