module AdminInterface
  class Config
    cattr_accessor :app_name, :app_author, :app_url, :main_color, :username, :password_digest, :results_per_page
  end
end