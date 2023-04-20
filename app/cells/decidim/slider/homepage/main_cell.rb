# frozen_string_literal: true

module Decidim
  module Slider
    module Homepage
      class MainCell < Decidim::ViewModel
        include Decidim::LayoutHelper

        def show
          return unless has_slides?

          render
        end

        private

        def cells
          return @cells if defined?(@cells)

          @cells ||= []
          index = 0
          slides.each do |slide|
            cl = cell(slide.manifest.cell, slide, context: { index: index })

            next unless cl.renderable?

            @cells.push(cl)
            index += 1
          end

          @cells
        end

        def has_slides?
          cells.map(&:renderable?).any?
        end

        def slides
          @slides ||= Decidim::ContentBlock.published.for_scope(:slider_tabs, organization: current_organization).order(:weight)
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
