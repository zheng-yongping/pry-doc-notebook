# frozen_string_literal: true

require 'yard'
require 'rouge'

YARD::Templates::Helpers::HtmlHelper.class_eval do
  def respond_to_missing?(name, include_all)
    if name =~ /^html_syntax_highlight_(\w+)/
      lang = $1.to_sym
      return Rouge::Lexers.constants.include?(lang)
    end
    super
  end

  def method_missing(name, *args, &block)
    if name =~ /^html_syntax_highlight_(\w+)/
      lang = $1.to_sym
      if Rouge::Lexers.constants.include?(lang)
        lexer = Rouge::Lexers.const_get(lang).new
        formatter = Rouge::Formatters::HTMLInline.new('pastie')
        return formatter.format(lexer.lex(*args))
      end
    end
    super
  end

  def html_syntax_highlight_ruby(source)
    html_syntax_highlight_Ruby(source)
  end
end
