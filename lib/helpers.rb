module AdminInterface::Helpers
  
  AREAS = %w(panel_header panel_footer sidebar)  

  def select_tab(tab)
    @admin_current_tab = tab
  end

  def current_tab
    @admin_current_tab
  end
  
  def tab(tab_name, tab_url)
    options = {}
    content_tag "li", options, true do
      current_tab == tab_name ? content_tag(:span, tab_name) : link_to(tab_name, tab_url)
    end
  end
  
  def display_success_if_present
    if flash[:success]
      content_tag 'div', flash[:success], :id => "success"
    end
  end
  
  def display_notice_if_present
    if flash[:notice]
      content_tag 'div', flash[:notice], :id => "notice"
    end
  end
  
  def display_error_if_present
    if flash[:error]
      content_tag 'div', flash[:error], :id => "error"
    end
  end
  
  def horizontal_list(separator = ' | ', &block)
    @_horizontal_list = []
    capture(&block)
    concat @_horizontal_list.compact.join(separator)
  end
  
  def horizontal_list_item(content)
    @_horizontal_list << content
  end
  
  def submit_tag(value, options = {})
    form_id = options.delete(:form_id)
    options[:onclick] = "$('##{form_id}').submit()" if form_id
    super(value, options)
  end
  
  def submit_to_remote(name, value, options = {})
    form_id = options.delete(:form_id)
    options[:with] ||= form_id ? "$('##{form_id}').serialize()" : '$(this).closest("form").serialize()'
    html_options = options.delete(:html) || {}
    html_options[:name] = name
    button_to_remote(value, options, html_options)
  end
  
  def truncate_words(text, max_length = 20, end_string = "&hellip;")
    text.split.map{|w| w[0..max_length] + (w.size > max_length ? end_string : "")}.join(' ')
  end
  
  protected
    def self.define_area(name)
      module_eval %Q[
        def #{name}(content = nil, &block)
          content_for :#{name}, content, &block
        end

        def #{name}_present?
          !!@content_for_#{name}
        end
        
        def display_#{name}_if_present
          if #{name}_present?
            content_tag 'div', @content_for_#{name}, :id => "#{name}"
          end
        end
      ]
    end
    
    AREAS.each {|name| define_area(name) }
end