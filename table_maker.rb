require 'erb'
require 'rubygems'
require 'e4u'

# output = 'lib/e4u/emoji/docomo.rb'
# target = :docomo
# label = DOCOMO_TABLE
def make_emoji_table output, target, label
  values = {}
  E4U.google.each do |emj|
    next unless emj[:name]

    key = emj[:name].to_s.tr('-','_').tr(' ','_').downcase

    if emj[target]
      hex = emj[target].to_s.tr('>', '').split(/\+/, -1).map{|e| "0x%X" % [e.hex]}
      val = "[#{hex.join(',')}].pack('U').freeze"
    elsif emj[:text_fallback] || emj[:text_repr]
      val = (emj[:text_fallback] || emj[:text_repr]).dump
    else
      val = "[0x3013].pack('U').freeze"
    end

    values[key] = val
  end

  mlen = values.keys.max{ |a,b| a.size <=> b.size }.size

  data = ERB.new(<<EOF, nil, '-').result(binding)
# -*- coding: utf-8 -*-
module E4U
  class Emoji
    <%= label %> = {
<% values.sort.each do |key,val| -%>
      <%= ":" + key.ljust(mlen) %> => <%= val %>,
<% end -%>
    }.freeze
  end
end
EOF
  File.open(output,'wb') do |out|
    out.print data
  end
end
