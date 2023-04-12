# typed: strict
# frozen_string_literal: true

require "rails/engine"
require "action_dispatch"

module RailsRubyLsp
  class Engine < ::Rails::Engine
    isolate_namespace RailsRubyLsp

    initializer "rails_ruby_lsp.routes" do
      config.after_initialize do |app|
        if Rails.env.development? || Rails.env.test?
          app.routes.prepend do
            T.bind(self, ActionDispatch::Routing::Mapper)
            mount(RailsRubyLsp::Engine => "/rails_ruby_lsp")
          end
        end

        if defined?(Rails::Server)
          ssl_enable, host, port = Rails::Server::Options.new.parse!(ARGV).values_at(:SSLEnable, :Host, :Port)
          File.write("#{Rails.root}/tmp/app_uri.txt", "http://#{host}:#{port}")
          "#{ssl_enable ? 'https' : 'http'}://#{host}:#{port}"
        end
      end
    end
  end
end
