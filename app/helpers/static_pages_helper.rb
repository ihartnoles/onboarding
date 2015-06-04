module StaticPagesHelper

	def orientation_status(znum)
    	output = Faudw.orientation_status(znum)

    	if output.count > 0
    	   output.each do |o| 

	    	 if o['attended'] == 'Yes'
	    	 	 tmp =  "You have attended an orientation session on #{o['sessiondate']}. You have completed this requirement!"
	    	 else
	    	 	 tmp =  "You have NOT attended an orientation session yet. You must attend orientation and complete orientation."
	    	 end

	    	 return tmp

      	   end
      	 else
      	 	return "Orienation status pending"
      	 end        
  	end


     def aleks_status(znum)
      output = Banner.aleks_status(znum)

      if output.count > 0
        output.each do |o| 

         if o['aleks_taken'] == 'Y' 
           tmp =  "You have taken ALEKS!"
         else
           tmp =  "You have NOT taken ALEKS yet. You must complete this requirement."
         end

         return tmp

           end
      else
        return "ALEKS status pending"
      end 
     end


     def fin_aid_docs(znum)
      output = Banner.fin_aid_docs(znum)

      tmp = ''
      doc_status = ''

      if output.count > 0
        output.each do |o| 
             if !o.nil?

               case o['rrrareq_sat_ind']
                 when 'Y'
                    doc_status = "received"
                 when 'N'
                    doc_status = "not received"
                 else
                    doc_status = "undetermined"
                end

               tmp <<  "<tr><td>#{o['rtvtreq_long_desc']}</td><td>#{doc_status}</td></tr>"
             else
               tmp =  "<td>You DO NOT have FAFSA information on file.</td>"
             end        
        end

           return tmp.html_safe

      else
        return "OARS status pending"
      end 
     end


     def registered_hours(znum)
      output = Banner.registered_hours(znum)

      if output.count > 0
        output.each do |o| 

         if !o.nil?
           tmp =  "You are currently registered for #{o['sfrstcr_credit_hr']} credit hours."
         else
           tmp =  "You have NOT registered for any classes yet."
         end
         

         return tmp

           end
      else
        return "Registration status pending"
      end 
     end


  	 def oars_status(znum)
  	 	output = Faudw.oars_status(znum)

  	 	if output.count > 0
  	 		output.each do |o| 

         if !o.nil?
           tmp =  "You have taken OARS for #{o['semester_desc']}.  Your status is: #{o['status_desc']}"
         else
           tmp =  "You have NOT attended an orientation session yet. You must attend orientation and complete orientation."
         end
	    	 

	    	 return tmp

      	   end
  	 	else
  	 		return "OARS status pending"
  	 	end 
  	 end


     def get_immunization_status(znum)
      output = Banner.immunization_status(znum)

      tmp = ''

      if output.count > 0
        output.each do |o| 

          # puts YAML::dump('begin immunization status')
          # puts YAML::dump(o)

         if o['imm_hold_flg'] == 'N' 
           tmp =  "Your immunization records are up to date!  Good job!"
         else
           tmp <<  "You have an immunization hold! You need to make sure your immunization records are up to date."
         end
         
         return tmp

        end
      else
        return "Immunization status pending"
      end 
     end


     def get_residency_status(znum)
       output = Banner.residency_status(znum)

       # if !output.nil?
       #  return output
       # else
       #  return 'unknown'
       # end
        if output.count > 0
        output.each do |o| 

         if o['sgbstdn_resd_code'].include?('T') || o['sgbstdn_resd_code'].include?('F') || o['sgbstdn_resd_code'].include?('R') || o['sgbstdn_resd_code'].include?('O')
           tmp =  "Your residency status is classified as IN-STATE."
         else
           tmp =  "Your residency status is classified as out of state."
         end
         

         return tmp

           end
      else
        return "Residency status pending"
      end 


     end



  	 def get_fullname(znum)
  	 	 output = Faudw.fullname(znum)

  	 	 # if !output.nil?
  	 	 # 	return output
  	 	 # else
  	 	 # 	return 'unknown'
  	 	 # end
        if output.count > 0
        output.each do |o| 

         if !o.nil?
           tmp =  "#{o['fname']} #{o['lname']}"
         else
           tmp =  ""
         end
         

         return tmp

           end
      else
        return "OARS status pending"
      end 


  	 end

  	 def get_statusicon(available,completed)
  	 	case 
  	 		when available == 0 && completed == 0
  	 			return "unavailable <i class='fa fa-ban'></i>".html_safe
  	 		when available == 1 && completed == 0
  	 			return "incomplete  <i class='fa fa-times'></i>".html_safe
  	 		when available == 1 && completed == 1  	 			
  	 			return "completed <i class='fa fa-check'></i>".html_safe
  	 	else
  	 		return "N/A <i class='fa fa-ban'></i>".html_safe
  	 	end
  	 end

end