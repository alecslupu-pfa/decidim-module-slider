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
        end
      end
    end
  end
end
