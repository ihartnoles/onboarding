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



  	 def get_fullname(znum)
  	 	 output = Faudw.fullname(znum)

  	 	 if !output.nil?
  	 	 	return output
  	 	 else
  	 	 	return 'unknown'
  	 	 end
  	 end

end