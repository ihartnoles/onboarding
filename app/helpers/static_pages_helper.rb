module StaticPagesHelper

	def orientation_status(znum)
    	output = Faudw.orientation_status(znum)

    	if output.count > 0
    	   output.each do |o| 

	    	 if o['attended'] == 'Yes'
	    	 	 tmp =  "You have attended an orientation session on #{o['sessiondate']}. You have completed this requirement!"
	    	 else
	    	 	 tmp =  "You have NOT attended an orientation session yet. You must attend orientation and complete orientation. "
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
           tmp =  "You have taken ALEKS! Congrats!"
         else
           tmp =  "You have NOT taken ALEKS yet. <br> You must complete this requirement. <a title='FAU Aleks' href='https://www.fau.edu/uas/pdf/ALEKS.pdf' target='_blank'>[More Information]</a>"
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
               tmp =  "<tr><td>You DO NOT have FAFSA information on file.</td></tr>"
             end        
        end

           return tmp.html_safe

      else
         tmp =  "<tr><td>You DO NOT have FAFSA information on file.</td></tr>"
       return tmp.html_safe
      end 
     end


     def registered_hours(znum)
      output = Banner.registered_hours(znum)

      tmp = ''

      if output.count > 0
        output.each do |o| 

        this_term  = o['sfrstcr_term_code']

         case this_term[4..5]
           when '01'
              term_value = "Spring"
           when '08'
              term_value = "Fall"
           else
              term_value = "Summer"
          end


         if !o.nil? 
           tmp <<  "<tr><td>#{o['sfrstcr_credit_hr']}</td><td>#{term_value} #{this_term[0..3]}</td></tr>"
         else
           tmp =  "<tr><td colspan='2'>You are NOT registered for 12 credit hours.</td></tr>"
         end       

        end

          return tmp.html_safe

      else
        return "Registration status pending"
      end 
     end


  	 def oars_status(znum)
  	 	output = Faudw.oars_status(znum)

  	 	if output.count > 0
  	 		output.each do |o| 

         if !o.nil?
           tmp =  "You have taken OARS for #{o['semester_desc']}! Great work!"
         else
           tmp =  "You have NOT completed OARS. <a title='OARS information' href='http://www.fau.edu/uas/oars_welcome.php' target='_blank'>[More Information]</a>"
         end
	    	 

	    	 return tmp.html_safe

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
           tmp <<  "You have an immunization hold! <br> You need to make sure your immunization records are up to date. <a title='FAU Immunizations' href='http://myhealth.fau.edu/Account/Logon?ReturnUrl=%2f' target='_blank'>[More Information]</a>"           
         else
           tmp =  "Your immunization records are up to date!  Good job!"
         end
         
         return tmp.html_safe

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
           tmp =  "You are classified as a RESIDENT. <br> Because of this classification you will save $518.55 per credit hour! <br> That's a savings of over $6000 for a 12 hour course load!"
         else
           tmp =  "You are classified as a NON-RESIDENT. <br>  Because of this classification You will pay $518.55 more per credit hour than residents!"
         end
        
           return tmp.html_safe
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

     def get_tuition_deposit_status(znum)
      output = Banner.tuition_deposit_status(znum)

      if output.count > 0
        output.each do |o| 

         if o['sarchkl_admr_code'] == 'TUTD' && !o['sarchkl_receive_date'].nil?
           tmp =  "Your tuition deposit was paid on #{o['sarchkl_receive_date'].strftime('%x')}."
         else
           tmp =  "Your tuition deposit has NOT been paid yet! <a href='http://www.fau.edu/admissions/tuitiondeposit.php' target='_blank'>[More Information]</a>."
         end
         

         return tmp.html_safe

         end
      else
        return "Tuition deposit status is pending."
      end 
     end

  	 def get_statusicon(available,completed)
  	 	case 
  	 		when available == 0 && ( completed == 0 || completed.nil?)
  	 			return "unavailable <i class='fa fa-ban'></i>".html_safe
  	 		when available == 1 && ( completed == 0 || completed.nil?)
  	 			return "incomplete  <i class='fa fa-times'></i>".html_safe
  	 		when available == 1 && completed == 1  	 			
  	 			return "completed <i class='fa fa-check'></i>".html_safe
  	 	else
  	 		return "N/A <i class='fa fa-ban'></i>".html_safe
  	 	end
  	 end

end