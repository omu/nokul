# frozen_string_literal: true

module Nokul
  module Name
    module_function

    def application
      @app_name ||= if File.exist?(manifest = Rails.root.join('app.json'))
                     JSON.parse(File.read(manifest)).fetch 'name'
                   else
                     self.class.module_parent.to_s.underscore
                   end
    end
  end
end
