class StaticPagesController < ApplicationController
      
      #before_filter :get_session_info

      before_filter CASClient::Frameworks::Rails::GatewayFilter, :only => [:login, :do_manual_login, :gatewayed_home, :main]
      before_filter CASClient::Frameworks::Rails::Filter, :except => [:login, :do_manual_login, :gatewayed_home, :main]
 	 

      #puts YAML::dump(@cas_user)

      # if @lexluthor = 'true'
      #   before_filter CASClient::Frameworks::Rails::GatewayFilter, :only => [:login, :do_manual_login, :home]
      #   before_filter CASClient::Frameworks::Rails::Filter, :except => [:login, :do_manual_login, :home ]       
      # else
      #   before_filter CASClient::Frameworks::Rails::GatewayFilter, :only => [:login, :do_manual_login]
      #   before_filter CASClient::Frameworks::Rails::Filter, :except => [:login, :do_manual_login]
      # end 

  def main
     @login = Login.new
  end

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


      #module flags
      @welcome_available = 1
      @deposit_available = 1
      @account_available = 1
      @communication_available = 1
      @immunization_available = 1
      @finaid_available = 1
      @housing_fee_available = 0
      @residency_available = 0
      @housing_meal_plans_available = 0
      @aleks_available = 0
      @oars_available = 1
      @learning_comm_available = 0
      @orientation_available = 1
      @reg_available = 0
      @emergency_available = 0
      @fau_alert_available = 0
      @owlcard_available = 0
      @bookadvance_available = 1
      @tuition_available = 0
      @vehicle_reg_available = 0

      #module completion flags
      @welcome_complete = 1
      @deposit_complete = 1
      @account_complete = 0
      @communication_complete = 0
      @immunization_complete = 1
      @finaid_complete = 1
      @housing_fee_complete = 0
      @residency_complete = 0
      @housing_meal_plans_complete = 0
      @aleks_complete = 0
      @oars_complete = 1
      @learning_comm_complete = 0
      @orientation_complete = 0
      @reg_complete = 0
      @emergency_complete = 0
      @fau_alert_complete = 0
      @owlcard_complete = 0
      @bookadvance_complete = 1
      @tuition_complete = 0
      @vehicle_reg_complete = 0

      #Z23001699 ;  Z23292493


      @znum = 'Z23001699'

      #@fullname = Faudw.fullname('Z23001699')

      #@fullname = view_context.get_fullname(@znum)


      # puts YAML::dump('begin fullname')
      # puts YAML::dump(@fullname)

      #@orientation = Faudw.orientation_status('Z23001699')

      # puts YAML::dump('begin orientation')
      # puts YAML::dump(@orientation)


      # @oars= Faudw.oars_status('Z23001699')

      # puts YAML::dump('begin oars')
      # puts YAML::dump(@oars)



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