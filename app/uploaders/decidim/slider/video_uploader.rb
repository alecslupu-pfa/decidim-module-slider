# frozen_string_literal: true

module Decidim
  module Slider
    class VideoUploader < ApplicationUploader
      def content_type_allowlist
        %w(video/mp4 application/mp4)
      end

      def extension_allowlist
        %w(mp4 mpeg)
      end
    end
  end
end
