#!/usr/bin/ruby

require 'rss'

rss = RSS::Parser.parse("http://www.kotodama.in/bbs/rss/board/remark/", false)

i = rand(rss.items.length)

puts rss.item(i).title
puts " -- " + rss.item(i).content_encoded
