#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require 'gruff'
require 'lib/patch/gruff/base'
require 'lib/patch/gruff/line'

class Chart
  FONT        = "/Library/Fonts/Osaka.ttf"
  LEGEND_SIZE = 12
  TITLE_SIZE  = 14
  Y_INCREMENT = 50

  def initialize(width=800, height=600)
    @gruff = Gruff::Line.new("#{width}x#{height}")
    @gruff.font              = FONT
    @gruff.title_font_size   = TITLE_SIZE
    @gruff.legend_font_size  = LEGEND_SIZE
    @gruff.legend_box_size   = LEGEND_SIZE
    @gruff.marker_font_size  = LEGEND_SIZE
    @gruff.y_axis_increment  = Y_INCREMENT
  end

  def write(title, labels, y_max, data, filename)
    @gruff.title            = title
    @gruff.labels           = Hash[*labels.map.with_index {|label, idx|
                                                            [idx, label]
                                                          }.select {|tuple|
                                                            tuple.last != ""
                                                          }.flatten
                                  ]
    @gruff.maximum_value    = y_max
    @gruff.minimum_value    = 0
    data.keys.each do |series|
      puts "#{series}:#{data[series][:pageviews]}"
      @gruff.data(series, data[series][:pageviews], data[series][:color])
    end
    @gruff.write(filename)
  end
end
