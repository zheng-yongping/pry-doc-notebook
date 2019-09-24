# frozen_string_literal: true

require_relative 'pry-doc-notebook/version'
require_relative 'pry-doc-notebook/yri'

require 'yard'

module PryDocNotebook
  YARD::Templates::Engine.register_template_path("#{File.dirname(__FILE__)}/templates")

  Pry::Commands.create_command '?' do
    group 'Introspection'
    description 'View yard documentation.'
    banner YRI::USAGE

    def process(name)
      YRI.new.display(name)
    end
  end
end
