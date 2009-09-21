class AdminInterfaceGenerator < Rails::Generator::Base
  def banner
    "Usage #{$0} #{spec.name}"
  end

  def manifest
    record do |m|
      # copy stylesheet
      stylesheets_path = File.join('public', 'stylesheets', 'sass')
      m.directory(stylesheets_path)
      m.file('admin.sass', File.join(stylesheets_path, 'admin.sass'))

      # copy images
      images_path = File.join('public', 'images', 'admin')
      m.directory(images_path)
      %w(panel_bg.gif panel_content_bg.gif success_icon.png notice_icon.png error_icon.png).each do |filename|
        m.file(filename, File.join(images_path, filename))
      end

      # copy layout and partials
      layouts_path = File.join('app', 'views', 'layouts')
      m.directory(layouts_path)
      %w(_primary_tabs.html.haml _secondary_tabs.html.haml _header_links.html.haml admin.html.haml).each do |filename|
        m.file(filename, File.join(layouts_path, filename))
      end

      # copy admin form builder
      helpers_path = File.join('app', 'helpers')
      m.directory(helpers_path)
      m.file('admin_form_builder.rb', File.join(helpers_path, 'admin_form_builder.rb'))

      # copy initializer
      initializers_path = File.join('config', 'initializers')
      m.directory(initializers_path)
      m.file 'admin_interface.rb', File.join(initializers_path, 'admin_interface.rb')
      
      # copy admin controller
      controllers_path = File.join('app', 'controllers')
      m.directory(controllers_path)
      m.file 'admin_controller.rb', File.join(controllers_path, 'admin_controller.rb')
    end
  end
end