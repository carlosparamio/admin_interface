class AdminFormBuilder < ActionView::Helpers::FormBuilder #:nodoc:
  
  protected
    def pre_labeled_field(method_name, content, accessor_method, *args)
      options = extract_options(args)
      label = extract_label(accessor_method, options)
      tips = extract_tips(options)
      klass = extract_class(method_name, options)
      prefix = extract_prefix(options)
      suffix = extract_suffix(options)
      @template.content_tag("dt", "#{prefix} #{label} #{tips}", :class => klass) +
      @template.content_tag("dd", "#{content} #{suffix}", :class => klass)
    end
    
    def post_labeled_field(method_name, content, accessor_method, *args)
      options = extract_options(args)
      label = extract_label(accessor_method, options)
      tips = extract_tips(options)
      klass = extract_class(method_name, options)
      prefix = extract_prefix(options)
      suffix = extract_suffix(options)
      @template.content_tag(:dt, "#{prefix} #{tips}", :class => klass) +
      @template.content_tag(:dd, "#{content} #{label} #{suffix}", :class => klass)
    end
    
    def extract_options(args)
      args.last.is_a?(Hash) ? args.last : {}
    end
    
    def extract_label(default, options)
      label = options.delete(:label) || default.to_s.humanize
      @template.content_tag(:label, label, :for => "#{@object_name}_#{default}")
    end

    def extract_tips(options)
      tips = options.delete(:tips)
      @template.content_tag(:span, tips, :class => 'tips') if tips
    end
    
    def extract_class(method_name, options)
      required = options.delete(:required) || false
      required ? "required #{method_name}" : method_name
    end
    
    def extract_prefix(options)
      options.delete(:prefix)
    end
    
    def extract_suffix(options)
      options.delete(:suffix)
    end
    
  public
    def field_set(options = {}, &block)
      content = @template.capture(&block)
      @template.concat @template.content_tag(:fieldset, @template.content_tag(:dl, content), options)
    end
    
    def radio_group(options = {}, &block)
      tips = extract_tips(options)
      klass = extract_class(:radio_group, options)
      @template.concat @template.content_tag(:dt, tips, :class => klass)
      @template.concat @template.content_tag(:dd, @template.capture(&block), :class => klass)
    end
    
    def radio_button(accessor_method, tag_value, options = {})
      label = extract_label(tag_value, options)
      @template.content_tag(:div, "#{super} #{label}", :class => "radio_button")
    end

    [ :file_field, :text_field, :text_area, :password_field, :time_select, :collection_select, :select,
      :country_select, :date_select, :datetime_select ].each do |method_name| 
      define_method(method_name) do |accessor_method, *args|
        pre_labeled_field(method_name, super, accessor_method, *args)
      end
    end

    [ :check_box ].each do |method_name|
      define_method(method_name) do |accessor_method, *args|
        post_labeled_field(method_name, super, accessor_method, *args)
      end
    end

end