require File.join(File.dirname(__FILE__), "../lib/admin_interface.rb")
require File.join(File.dirname(__FILE__), "../lib/helpers.rb")

ActionView::Base.send :include, AdminInterface::Helpers