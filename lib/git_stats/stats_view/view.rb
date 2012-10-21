module GitStats
  module StatsView
    class View
      def initialize(view_data, out_path)
        @view_data, @out_path = view_data, out_path
      end

      def render_all
        prepare_static_content
        prepare_assets

        layout = Tilt.new("templates/layout.haml")

        all_templates.each do |template|
          output = Template.new(template, layout).render(@view_data, all_templates: all_templates)
          File.open("#@out_path/#{template}.html", 'w') { |f| f.write output }
        end
      end


      private

      def all_templates
        %w(general activity authors files lines)
      end

      def prepare_static_content
        FileUtils.cp_r(Dir['templates/static/*'], @out_path)
      end

      def prepare_assets
        FileUtils.cp_r('templates/assets', @out_path)
      end

    end
  end
end