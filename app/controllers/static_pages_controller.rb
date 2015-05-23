class StaticPagesController < ApplicationController
      
      #before_filter :get_session_info

      before_filter CASClient::Frameworks::Rails::GatewayFilter, :only => [:login, :do_manual_login, :gatewayed_home]
      before_filter CASClient::Frameworks::Rails::Filter, :except => [:login, :do_manual_login, :gatewayed_home]
 	 

      #puts YAML::dump(@cas_user)

      # if @lexluthor = 'true'
      #   before_filter CASClient::Frameworks::Rails::GatewayFilter, :only => [:login, :do_manual_login, :home]
      #   before_filter CASClient::Frameworks::Rails::Filter, :except => [:login, :do_manual_login, :home ]       
      # else
      #   before_filter CASClient::Frameworks::Rails::GatewayFilter, :only => [:login, :do_manual_login]
      #   before_filter CASClient::Frameworks::Rails::Filter, :except => [:login, :do_manual_login]
      # end 

  	
  	# def login
   #    @login = Login.new
   #    #a cas_user is already set so let's send them thru to home
   #    if !session[:cas_user].nil?
   #      redirect_to home_path     
   #    end

   #    #this is to display manual login
   #  end

   #  def do_manual_login

   #    require 'digest/sha1'
   #    require 'base64'

   #    #sha1   = Digest::SHA1.digest('bicboi')
   #    sha1  = Digest::SHA1.digest(params[:password])
   #    base64_passwd = Base64.strict_encode64(sha1)

   #    authenticated = Ugapp.find_user(params[:email], base64_passwd)

   #    if authenticated
   #      @message = 'i found yo ass'

       
   #      session[:fullname] = Ugapp.get_fullname(params[:email], base64_passwd)
   #      @displayname = session[:fullname]

   #      #redirect_to home_path
   #    else
   #      @message = 'nopity nope nope'
   #      #redirect_to unauthorized_path
   #    end

   #    #validate and authenticate here if they provide valid credentails then pass them on to the home_path
      
   #    # if #manual authentication passed
   #    #   #manual authentication passed
   #    #   redirect_to home_path
   #    # else
   #    #   #authentication failed
   #    #   redirect_to_login_path
   #    # end

   #  end

  def gatewayed_home

      @fullname = Faudw.fullname('Z23292493')

      @orientation = Faudw.orientation_status('Z23292493')

      @oars= Faudw.oars_status('Z23292493')


        if !session[:fullname].nil?
         session[:fullname].each do |fn|
           @displayname = "#{fn['fullname']}"
         end
        else
          redirect_to unauthorized_path
        end
  end

	def home		
		# @title      = 'Home'
  		# @description = 'What would you like to do?'		

      # puts YAML::dump(session.inspect)

    	session[:usertype]  = nil
      
      if !session[:cas_user].nil?
         @displayname = session[:cas_user]
      # else
      #   if !session[:fullname].nil?
      #    session[:fullname].each do |fn|
      #      @displayname = "#{fn['fullname']}"
      #    end
      #   else
      #     @displayname = 'TAMAS'
      #   end
      end

      #Z23001699
      @fullname = Faudw.fullname('Z23292493')

      @orientation = Faudw.orientation_status('Z23292493')

      @oars= Faudw.oars_status('Z23292493')

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

  # protected

  # def get_session_info
  #    #puts YAML::dump(session.inspect)
  #    session[:booyah] = "begin"
  #    puts YAML::dump(session[:booyah])
  #    puts YAML::dump(session[:cas_user].nil?)
  #    puts YAML::dump(session[:cas_user].blank?)
  #    puts YAML::dump(request.env['HTTP_REFERER'])

  #    @lexluthor ='bananas'

  #   if request.env['HTTP_REFERER'] == 'http://10.16.9.208:3000/login'
  #        # @lexluthor = 'true'
  #       CASClient::Frameworks::Rails::GatewayFilter, :only => [:login, :do_manual_login]
  #       #CASClient::Frameworks::Rails::Filter, :except => [:login, :do_manual_login]
  #   else
  #        # @lexluthor = 'false'
  #       CASClient::Frameworks::Rails::GatewayFilter, :only => [:login, :do_manual_login, :home]
  #       #CASClient::Frameworks::Rails::Filter, :except => [:login, :do_manual_login, :home]
  #   end 
     
  # end
end