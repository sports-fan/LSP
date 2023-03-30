# typed: strict
# frozen_string_literal: true

module Rails
  class << self
    sig { returns(Application) }
    def application; end
  end

  class Application
    sig { params(block: T.proc.bind(Rails::Application).void).void }
    def configure(&block); end
  end
end

module RailsRubyLsp
  class Engine
    class << self
      sig { returns(ActionDispatch::Routing::RouteSet) }
      def routes; end
    end
  end
end
