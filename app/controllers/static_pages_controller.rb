require 'mapquest_api'

class StaticPagesController < ApplicationController
      
      #before_filter :get_session_info

      before_filter CASClient::Frameworks::Rails::GatewayFilter, :only => [:login, :do_manual_login, :gatewayed_home, :main]
      before_filter CASClient::Frameworks::Rails::Filter, :except => [:login, :do_manual_login, :gatewayed_home, :main]
      # before_filter RubyCAS::Filter, :only => [:login, :do_manual_login, :gatewayed_home, :main]
      # before_filter RubyCAS::Filter, :except => [:login, :do_manual_login, :gatewayed_home, :main]
 	 

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

      #BEGIN: manually pulling information for desiree young
      # @fullname = Faudw.fullname('Z23122293')

      # @orientation = Faudw.orientation_status('Z23122293')

      # @oars= Faudw.oars_status('Z23122293')
      #END

      #TO DO: revisit this logic; it works fine with ugapp credentials but not straight NETID!!
        # if !session[:fullname].nil?
        #  session[:fullname].each do |fn|
        #    @displayname = "#{fn['fullname']}"
        #  end
        # else
        #   redirect_to unauthorized_path
        # end

         # puts YAML::dump(' *** BEGIN CAS USER  ***')      
         # puts YAML::dump(session[:cas_user])
         # puts YAML::dump('*** END CAS USER ***')  

       #if !session[:cas_user].nil?
          @displayname = session[:cas_user]
        #else
         # redirect_to unauthorized_path
        #end

  end

	def home		
		# @title      = 'Home'
  		# @description = 'What would you like to do?'		
		
    	session[:usertype]  = nil
      @znum = nil
      
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
      else
         @displayname = 'UFO'
      end
      
      if params[:znum] 
        #this is to allow impersonation
        @znum = params[:znum]
        znum = params[:znum]
        record_activity("Proxy Login")
      else
		 
		    # puts YAML::dump(' *** BEGIN CAS USER  ***')      
	      # puts YAML::dump(session[:cas_user])
        # puts YAML::dump('*** END CAS USER ***')      
      
        # @znum = 'Z23122293'
        output = Banner.find_student_by_netid(session[:cas_user])
         
        znum = nil

        output.each do |o| 
    		  	@znum = o['z_number']      
            znum =  o['z_number']                  
    	  end			
      
        record_activity("User Login")
      end


      if znum.nil? || znum.empty? || znum.blank?
        #we can't find you in the system peaches
        redirect_to unauthorized_path
      else 

          availability = FticModulesAvailable.where(:znumber => @znum)

          availability.each do |a|
            @welcome_available = a.welcome
            @deposit_available = a.deposit
            @account_available = a.account
            @communication_available = a.communication
            @immunization_available = a.immunization
            @finaid_available = a.finaid
            @housing_fee_available = a.housingfee
            @residency_available = a.residency
            @housing_meal_plans_available = a.housingmealplan
            @aleks_available = a.aleks
            @oars_available = a.oars
            @learning_comm_available = a.learning_comm
            @orientation_available = a.orientation
            @reg_available = a.registration
            @emergency_available = a.emergency
            @fau_alert_available = a.faualert
            @owlcard_available = a.owlcard
            @bookadvance_available = a.bookadvance
            @tuition_available = a.tution
            @vehicle_reg_available = a.vehiclereg
          end

          #module flags
          # @welcome_available = 1
          # @deposit_available = 1
          # @account_available = 1
          # @communication_available = 1
          # @immunization_available = 1
          # @finaid_available = 1
          # @housing_fee_available = 1
          # @residency_available = 1
          # @housing_meal_plans_available = 1
          # @aleks_available = 1
          # @oars_available = 1
          # @learning_comm_available = 1
          # @orientation_available = 1
          # @reg_available = 1
          # @emergency_available = 1
          # @fau_alert_available = 1
          # @owlcard_available = 1
          # @bookadvance_available = 1
          # @tuition_available = 1
          # @vehicle_reg_available = 1

          #module completion flags

          tuition_status = Banner.tuition_deposit_status(@znum)
          aleks_status = Banner.aleks_status(@znum)
          immunization_status = Banner.immunization_status(@znum)
          residency_status = Banner.residency_status(@znum)
          finaid_status = Banner.fin_aid_docs(@znum)
          #pull the student's zip
          student_zip = Banner.find_student_zip_by_z(@znum)

           # puts YAML::dump('**********AYYEEEEE**********')
           # puts YAML::dump(student_zip)

          #set the zip
          student_zip.each do |o| 
             zipcode = o['zip']  
             @zipcode = o['zip']      
             # puts YAML::dump('**********ZIIIIIIIP**********')
             # puts YAML::dump(zipcode)
             # puts YAML::dump('**********CODE**********')
          end     

          

          housing_fee_status = 0
          oars_status = Faudw.oars_status(@znum)
          orientation_status = Faudw.orientation_status(@znum)
          registration_status = Banner.registered_hours(@znum)


          #Banner.tuition_deposit_status('Z23122293')

          #puts YAML::dump(tuition_status)

          @welcome_complete = 1

          tuition_status.each do |o|
            if o['sarchkl_admr_code'] == 'TUTD' && !o['sarchkl_receive_date'].nil?
              @deposit_complete = 1
            else
              @deposit_complete = 0
            end 
          end

          @account_complete = 0
          @communication_complete = 0
                
          immunization_status.each do |o|
             if o['imm_hold_flg'] == 'N' || o['imm_hold_flg'].nil?
              @immunization_complete = 0
            else
              @immunization_complete = 1
            end 
          end


          #begin finaidflags
          finaidflags = []

          finaid_status.each do |o|
            
            if o['rrrareq_sat_ind'] == 'N' || o['rrrareq_sat_ind'].nil?
              #@finaid_complete = 0
              finaidflags.push('0')
            else
              #@finaid_complete = 1
              finaidflags.push('1')
            end
          end

         
          if  finaidflags.include? '0'
            @finaid_complete = 0
          elsif finaidflags.empty?
             @finaid_complete = 0
          else
            @finaid_complete = 1
          end 
          #end finaidflags

          #begin housing fee

            #check zipcode radius
            housing_fee_required = HousingZipcode.where(:zip => @zipcode, :campus => 'Boca Raton')
            
            # puts YAML::dump('BBHMM')
            # puts YAML::dump(housing_fee_required.empty?)

            #determine if housing fee is required
            if housing_fee_required.count > 0            
                @housing_fee_required = 0
                @housing_fee_complete = 1           
            else
                @housing_fee_required = 1
                @housing_fee_complete = 0         
            end

            # begin: check the student's age 
            age_requirement = Banner.age_calculation(@znum)

            age_requirement.each do |o| 
               # age = o['age']  
               @age = o['age']                 
            end      

            if @age < 21 && @housing_fee_required == 1
              @housing_fee_required = 1
            else
              @housing_fee_required = 0
              @housing_fee_complete = 1
            end

            #end: chec the student's age 

          #end housing housing_fee

          @residency_complete = 0
          residency_status.each do |o|
             if o['sgbstdn_resd_code'].include?('T') || o['sgbstdn_resd_code'].include?('F') || o['sgbstdn_resd_code'].include?('R') || o['sgbstdn_resd_code'].include?('O')
              @residency_complete = 1
            else
              @residency_complete = 0
            end 
          end

          @housing_meal_plans_complete = 0

         
          aleks_status.each do |o|
            if o['aleks_taken'] == 'N' || o['aleks_taken'].nil?
              @aleks_complete = 0
            else
              @aleks_complete = 1
            end 
          end


          #@oars_complete = 1
          oars_status.each do |o|
            if o.nil?
              @oars_complete = 0
            else
              @oars_complete = 1
            end
          end

          @learning_comm_complete = 0

          orientation_status.each do |o|
            if o['attended'] == 'Yes' && !o['attended'].nil?
              @orientation_complete = 1
            else
              @orientation_complete = 0
            end
          end

          #@reg_complete = 0
          registration_status.each do |o|
            if o['sfrstcr_credit_hr'] >= 12
              @reg_complete = 1
            else
              @reg_complete = 0
            end

            @sfrstcr_credit_hr = o['sfrstcr_credit_hr']

          end


          @emergency_complete = 0
          @fau_alert_complete = 0
          @owlcard_complete = 0
          @bookadvance_complete = 1
          @tuition_complete = 0
          @vehicle_reg_complete = 0

          #Z23001699 ;  Z23292493

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


      end #END: znum.nil?

    
    	
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

  def record_activity(note)
    @activity = ActivityLog.new
    @activity.netid = session[:cas_user]
    @activity.note = note
    @activity.browser = request.env['HTTP_USER_AGENT']
    @activity.ip_address = request.env['REMOTE_ADDR']
    @activity.controller = controller_name 
    @activity.action = action_name 
    @activity.params = params.inspect
    @activity.save
  end

  def fticsync
      @Bannerstuds = Banner.find_newstudents

      @Bannerstuds.each do | bs |
        
        if FticModulesAvailable.find_by_znumber(bs['z_number']).nil? 
         newstudent = FticModulesAvailable.new
         newstudent.znumber = bs['z_number']
         newstudent.netid   = bs['gobtpac_external_user']
         newstudent.welcome = 1
         newstudent.deposit = 1
         newstudent.account = 0
         newstudent.communication = 0
         newstudent.immunization = 0
         newstudent.finaid = 0
         newstudent.housingfee = 0
         newstudent.residency = 0
         newstudent.housingmealplan = 0
         newstudent.aleks = 0
         newstudent.oars = 0
         newstudent.learning_comm = 0
         newstudent.orientation = 0
         newstudent.registration = 0
         newstudent.emergency = 0
         newstudent.faualert = 0
         newstudent.owlcard = 0
         newstudent.bookadvance = 0
         newstudent.tution = 0
         newstudent.vehiclereg = 0 
         newstudent.save(validate: false)   
        else
         student = FticModulesAvailable.find_by_znumber(bs['z_number'])       
         student.update_attributes(
          :netid => bs['gobtpac_external_user'],
          :znumber => bs['z_number']
         )
        end

      end

  end

  #mapquest integration - 
  def calc_distance
      @from  = 'Boca Raton, FL'
      @to = 'Aventura, FL'
      mapquest = MapquestApi.new
      distance = mapquest.post_url(@from, @to)
      puts YAML::dump('*** DUH HELLO ***')
      puts YAML::dump(distance)
      render :nothing => true
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