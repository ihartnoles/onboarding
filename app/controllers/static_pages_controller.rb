class StaticPagesController < ApplicationController
	def home	
		@title      = 'Home'
    	@description = 'What would you like to do?'		

    	session[:usertype]  = nil

    	# if !User.find_by_username(session[:cas_user]).blank?
	    # 	session[:usertype]  = User.find_by_username(session[:cas_user]).usertype_id
	    # 	session[:userid] 	= User.find_by_username(session[:cas_user]).id
	    # 	session[:poweruseraccess] = Useraccesslevel.where(:affiliate_id => session[:userid]).pluck(:facultyclassification_id)
	    # else
	    # 	#end user doesn't have access in the system!
	    # 	redirect_to unauthorized_path
    	# end

    	if session[:cas_user] == 'ihartstein'
    		# @title      = 'Yeah'
    	else
    		#user should be bounced
    		redirect_to unauthorized_path
    	end
    	
    end

	# def admin	

	# 	if session[:usertype] != 4
	# 		redirect_to unauthorized_path
	# 	else
	# 		@title      = 'Administration'
 #    		@description = 'Administrative Panel'		
 #    	end

	# end

	# def reports
	# 	@title = 'Reports'
	# 	@description = 'Reporting Options'
	# end 

	def unauthorized
		@title = 'Unauthorized'
		@description = ''

		render layout: false
	end 
end