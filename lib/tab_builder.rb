module AdminInterface
  class TabBuilder
  
    def initialize(&block)
      @block = block
    end
    
    def tab(tab_name, url)
      @block.call(tab_name, url)
    end
  end
end