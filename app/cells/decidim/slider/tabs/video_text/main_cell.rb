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

          def skip_when_finished?
            model.settings.skip_when_finished && !model.settings.loop
          end

          def settings
            [
              video_settings,
              skip_when_finished? ? "data-skip-when-finished" : nil
            ].compact.join(" ")
          end

          protected

          def video_settings
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
