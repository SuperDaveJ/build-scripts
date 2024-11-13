##########################################################
##########################################################
# This file needs to be placed in ~/.rake
# Run any of these task from the terminal using 'rake subv:theTaskname["variable1","variable2",...]'
# You can check all available task by running 'rake -T' in Terminal
##########################################################
##########################################################

namespace :subv do
    desc "Checkout remote branch and run pod install"
    task :checkout_branch, [:branch_name] => [:download_repo] do |t, args|
        branch_name = args[:branch_name].to_s

        path_to_pod = locate_path_to_podfile branch_name
        
        begin
            FileUtils.cd "#{branch_name}/#{path_to_pod}"
            sh "pod install"
            sh "open ."
        rescue
            error_with_message "Couldn't locate Podfile path or install pods."
        end
        
    end
    
    task :download_repo, [:branch_name] do |t, args|
        branch_name = args[:branch_name].to_s
        path = "https://192.168.80.13:8443/svn/mobile/branches/#{branch_name}"
        
        begin
            sh "svn co #{path}"
        rescue
            error_with_message "Unable to locate a branch with that name."
        end
    end
    
    desc "List all remote branches"
    task :list_branches do
        sh "svn list https://192.168.80.13:8443/svn/mobile/branches/"
    end
    
    private
        def error_with_message (message)
            puts "***** ERROR: #{message} *****"
        end

        def locate_path_to_podfile (branch_name)
        	@path = ""
        	if Dir.exist? "#{branch_name}/iOS"
        		@path = "iOS/essWrapper/"
        	elsif Dir.exist? "#{branch_name}/essWrapper"
        		@path = "essWrapper/"
        	end
        	return @path
        end
end


