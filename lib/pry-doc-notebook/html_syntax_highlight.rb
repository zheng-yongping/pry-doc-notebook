# frozen_string_literal: true

require 'yard'
require 'rouge'

module PryDocNotebook

  class ModifiedPastie < Rouge::CSSTheme
    # Modified by Rouge::Themes::Pastie
    # See https://github.com/rouge-ruby/rouge/blob/master/lib/rouge/themes/pastie.rb

    style Comment,                   :fg => '#408080'
    style Comment::Preproc,          :fg => '#cc0000', :bold => true
    style Comment::Special,          :fg => '#cc0000', :bg => '#fff0f0', :bold => true

    style Error,                     :fg => '#a61717', :bg => '#e3d2d2'
    style Generic::Error,            :fg => '#aa0000'

    style Generic::Heading,          :fg => '#333333'
    style Generic::Subheading,       :fg => '#666666'

    style Generic::Deleted,          :fg => '#000000', :bg => '#ffdddd'
    style Generic::Inserted,         :fg => '#000000', :bg => '#ddffdd'

    style Generic::Emph,             :italic => true
    style Generic::Strong,           :bold => true

    style Generic::Lineno,           :fg => '#888888'
    style Generic::Output,           :fg => '#888888'
    style Generic::Prompt,           :fg => '#555555'
    style Generic::Traceback,        :fg => '#aa0000'

    style Keyword,                   :fg => '#008800', :bold => true
    style Keyword::Pseudo,           :fg => '#008800'
    style Keyword::Type,             :fg => '#888888', :bold => true

    style Num,                       :fg => '#0000dd', :bold => true

    style Str,                       :fg => '#dd2200'
    style Str::Escape,               :fg => '#0044dd'
    style Str::Interpol,             :fg => '#3333bb'
    style Str::Other,                :fg => '#22bb22'
    #style Str::Regex,                :fg => '#008800', :bg => '#fff0ff'
    # The background color on regex really doesn't look good, so let's drop it
    style Str::Regex,                :fg => '#008800'
    style Str::Symbol,               :fg => '#aa6600'

    style Name::Attribute,           :fg => '#336699'
    style Name::Builtin,             :fg => '#003388'
    style Name::Class,               :fg => '#bb0066', :bold => true
    style Name::Constant,            :fg => '#003366', :bold => true
    style Name::Decorator,           :fg => '#555555'
    style Name::Exception,           :fg => '#bb0066', :bold => true
    style Name::Function,            :fg => '#0066bb', :bold => true
    #style Name::Label,              :fg => '#336699', :italic => true
    # Name::Label is used for built-in CSS properties in Rouge, so let's drop italics
    style Name::Label,               :fg => '#336699'
    style Name::Namespace,           :fg => '#bb0066', :bold => true
    style Name::Property,            :fg => '#336699', :bold => true
    style Name::Tag,                 :fg => '#bb0066', :bold => true
    style Name::Variable,            :fg => '#336699'
    style Name::Variable::Global,    :fg => '#dd7700'
    style Name::Variable::Instance,  :fg => '#3333bb'

    style Operator::Word,            :fg => '#008800'

    style Text,                      {}
    style Text::Whitespace,          :fg => '#bbbbbb'
  end

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
          formatter = Rouge::Formatters::HTMLInline.new(ModifiedPastie)
          return formatter.format(lexer.lex(*args))
        end
      end
      super
    end

    def html_syntax_highlight_ruby(source)
      html_syntax_highlight_Ruby(source)
    end
  end
end
