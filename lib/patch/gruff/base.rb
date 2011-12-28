module Gruff
  class Base
    undef draw_legend
    def draw_legend
      return if @hide_legend

      @legend_labels = @data.collect {|item| item[DATA_LABEL_INDEX] }

      legend_square_width = @legend_box_size # small square with color of this item

      # May fix legend drawing problem at small sizes
      @d.font = @font if @font
      @d.pointsize = @legend_font_size

      label_widths = [[]] # Used to calculate line wrap
      @legend_labels.each do |label|
        metrics = @d.get_type_metrics(@base_image, label.to_s)
        label_width = metrics.width + legend_square_width * 2.7
        label_widths.last.push label_width

        if sum(label_widths.last) > (@raw_columns * 0.9)
          label_widths.push [label_widths.last.pop]
        end
      end

      current_x_offset = center(sum(label_widths.first))
      current_y_offset =  @hide_title ?
      @top_margin + title_margin :
        @top_margin + title_margin + @title_caps_height

      @legend_labels.each_with_index do |legend_label, index|

        # Draw label
        @d.fill = @font_color
        @d.font = @font if @font
        @d.pointsize = scale_fontsize(@legend_font_size)
        @d.stroke('transparent')
        @d.font_weight = NormalWeight
        @d.gravity = WestGravity
        @d = @d.annotate_scaled( @base_image,
                                 @raw_columns, 1.0,
                                 current_x_offset + (legend_square_width * 1.7), current_y_offset,
                                 legend_label.to_s, @scale)

        # Now draw box with color of this dataset
        @d = @d.stroke('transparent')
        @d = @d.fill @data[index][DATA_COLOR_INDEX]
        @d = @d.rectangle(current_x_offset,
                          current_y_offset - legend_square_width / 2.0,
                          current_x_offset + legend_square_width,
                          current_y_offset + legend_square_width / 2.0)

        @d.pointsize = @legend_font_size
        metrics = @d.get_type_metrics(@base_image, legend_label.to_s)
        current_string_offset = metrics.width + (legend_square_width * 2.7)

        # Handle wrapping
=begin
        label_widths.first.shift
        if label_widths.first.empty?
          debug { @d.line 0.0, current_y_offset, @raw_columns, current_y_offset }

          label_widths.shift
          current_x_offset = center(sum(label_widths.first)) unless label_widths.empty?
          line_height = [@legend_caps_height, legend_square_width].max + legend_margin
          if label_widths.length > 0
            # Wrap to next line and shrink available graph dimensions
            current_y_offset += line_height
            @graph_top += line_height
            @graph_height = @graph_bottom - @graph_top
          end
        else
          current_x_offset += current_string_offset
        end
=end
        line_height = [@legend_caps_height, legend_square_width].max + legend_margin
        current_y_offset += line_height
        @graph_top += line_height
        @graph_height = @graph_bottom - @graph_top
      end
      @color_index = 0
    end
  end
end
