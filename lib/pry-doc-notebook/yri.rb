# frozen_string_literal: true

require 'yard'
require 'rubygems'

module PryDocNotebook
  class YRI < YARD::CLI::YRI
    USAGE = <<~USAGE
      Usage: ? <Path to object>
      Example: ? String#gsub
    USAGE

    def display(name)
      if name.nil? || name.strip.empty?
        puts USAGE
        return nil
      end

      object = find_object(name)
      if object
        IRuby.display object.format(format: :html), mime: 'text/html'
      else
        puts "No documentation for `#{name}'"
      end
      return nil
    end

    private

    def pry_doc_yardoc_path
      ruby_version = RUBY_VERSION[0...3].sub!('.', '')
      pry_doc_path = Gem.loaded_specs['pry-doc'].full_gem_path
      return "#{pry_doc_path}/lib/pry-doc/docs/#{ruby_version}"
    end

    def find_object(name)
      @search_paths.unshift(@cache[name]) if @cache[name]
      @search_paths.unshift(YARD::Registry.yardoc_file)
      @search_paths.unshift(pry_doc_yardoc_path)

      @search_paths.each do |path|
        next unless File.exist?(path)

        YARD::Registry.load(path)
        obj = try_load_object(name, path)
        return obj if obj
      end
      return nil
    end
  end
end
