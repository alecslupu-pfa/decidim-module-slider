# frozen_string_literal: true

module Decidim
  module Slider
    module Homepage
      class MainCell < Decidim::ViewModel
        def show
          return unless has_slides?

          render
        end

        private

        def has_slides?
          slides.any?
        end

        def slides
          @slides ||= Decidim::ContentBlock.published.for_scope(:slider_tabs, organization: current_organization)
        end
        #
        # def cache_hash
        #   hash = [I18n.locale]
        #   slides.each do |slide|
        #     hash.push(slide.cache_key_with_version)
        #   end
        #   hash.join(Decidim.cache_key_separator)
        # end
      end
    end
  end
end
