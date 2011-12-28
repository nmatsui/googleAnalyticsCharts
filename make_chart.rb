#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

$: << File.dirname(__FILE__)
require 'date'
require 'lib/google_analytics'
require 'lib/chart'

PAGE_LIMIT     = 10
PAGE_Y_MAX     = 750
REF_Y_MAX      = 300

unless ARGV.length == 1 && /^(\d{4})-(\d{2})$/ =~ ARGV.first
  puts "USAGE: #{__FILE__} yyyy-mm"
  exit 0
end

puts "start script"

year  = $1.to_i
month = $2.to_i

start_date = Date.new(year, month,  1)
end_date   = Date.new(year, month, -1)

labels = (start_date .. end_date).to_a.map{|d| 
  d.monday? ? d.strftime("%m/%d(月)") : ""
}

ga = GoogleAnalytics.new

pages = ga.pageviews(start_date, end_date, PAGE_LIMIT)
Chart.new(640, 840).write(
  "記事のPageview TOP#{PAGE_LIMIT} #{year}-#{month}",
  labels,
  PAGE_Y_MAX,
  ga.pageviews(start_date, end_date, PAGE_LIMIT),
  "page-#{year}-#{month}.png"
)

Chart.new(640, 840).write(
  "referrer #{year}-#{month}",
  labels,
  REF_Y_MAX,
  ga.referrers(start_date, end_date),
  "ref-#{year}-#{month}.png"
)

puts "end script"
