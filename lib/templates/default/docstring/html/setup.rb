# frozen_string_literal: true

require 'nokogiri'

def code_add_border(html)
  doc = Nokogiri::HTML::DocumentFragment.parse(html)
  doc.search('pre.code').each do |pre|
    pre['style'] = 'border: 1px solid #cfcfcf;'\
                   'border-radius: 2px;'\
                   'margin: 0.5em;'\
                   'padding: 0.3em;'
  end
  doc.to_html
end
