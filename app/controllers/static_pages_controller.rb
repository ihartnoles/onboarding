class StaticPagesController < ApplicationController

	before_filter CASClient::Frameworks::Rails::GatewayFilter, :only => [:login, :do_manual_login]
  	before_filter CASClient::Frameworks::Rails::Filter, :except => [:login, :do_manual_login]

  	
  	def login
  		#a cas_user is already set so let's send them thru to home
  		if !session[:cas_user].nil?
  			redirect_to home_path  		
  		end
  		#this is to display manual login
  	end

  	def do_manual_login

  		#validate and authenticate here if they provide valid credentails then pass them on to the home_path
  		
  		# if #manual authentication passed
  		# 	#manual authentication passed
  		# 	redirect_to home_path
  		# else
  		# 	#authentication failed
  		# 	redirect_to_login_path
  		# end

  	end


	def home		
		# @title      = 'Home'
  		# @description = 'What would you like to do?'		

    	session[:usertype]  = nil

    	# if !User.find_by_username(session[:cas_user]).blank?
	    # 	session[:usertype]  = User.find_by_username(session[:cas_user]).usertype_id
	    # 	session[:userid] 	= User.find_by_username(session[:cas_user]).id
	    # 	session[:poweruseraccess] = Useraccesslevel.where(:affiliate_id => session[:userid]).pluck(:facultyclassification_id)
	    # else
	    # 	#end user doesn't have access in the system!
	    # 	redirect_to unauthorized_path
    	# end


    	
    	# if session[:cas_user] == 'ihartstein' || session[:cas_user] == 'frodrig6'
    		
    	# 	@extra_attributes = {:real_name => "John Doe", :employee_number => 12345} 

    	# 	session[:cas_extra_attributes] = @extra_attributes

    	# 	# @title      = 'Yeah'
    	# else
    	# 	#user should be bounced
    	# 	redirect_to unauthorized_path
    	# end
    	
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