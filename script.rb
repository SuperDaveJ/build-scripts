require 'fileutils'
require 'io/console'

class Utility
  
  def evaluate_current_keys_to_new_keys
    current_file_path = "BuildScript/strings.xml"
    current_keys = fetch_keys(current_file_path)
    new_file_path = "#{Dir.home}/Desktop/strings.xml"
    new_keys = fetch_keys(new_file_path)
    
    for i in 0..(current_keys.count - 1)
      isMatch = current_keys[i] == new_keys[i]
      
      if not isMatch
        puts "ERROR: Current Strings keys don't match the new Strings keys"
        fail
      end
      
    end
  end
  
  private
    def fetch_keys(path)
      keyRegex = /\"([a-zA-Z]*\_*[a-zA-Z]*)*\"/
      file = IO.readlines(path)
      keys = []
      file.each do |line|
        keyRegex.match line do |k|
          keys.push k.to_s
        end
      end
      keys
    end

end

utility = Utility.new
utility.evaluate_current_keys_to_new_keys



