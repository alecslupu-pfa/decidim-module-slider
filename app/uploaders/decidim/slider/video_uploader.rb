# frozen_string_literal: true

module Decidim
  module Slider
    class VideoUploader < RecordImageUploader
      def content_type_allowlist
        %w(video/mp4 application/mp4)
      end

      def extension_allowlist
        %w(mp4 mpeg)
      end

      private

      def maximum_upload_size
        raise Decidim.organization_settings(model).upload_maximum_file_size.inspect
      end
    end
  end
end
