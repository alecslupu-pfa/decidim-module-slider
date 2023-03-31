# frozen_string_literal: true

module Decidim
  module Slider
    module Tabs
      module VideoText
        class MainCell < ::Decidim::Slider::Tabs::Generic::MainCell
          def video_url
            model.images_container.attached_uploader(:video).path
          end

          def video_content_type
            model.images_container.video.content_type
          end
        end
      end
    end
  end
end
