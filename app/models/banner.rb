class Banner < ActiveRecord::Base

	self.abstract_class = true
	self.table_name="BANINST1.AWS_ONBOARDING_MAIN"

	establish_connection(:bannertest)

	def self.aleks_status(id)
		get = connection.exec_query("SELECT aleks_taken FROM BANINST1.AWS_ONBOARDING_MAIN WHERE Z_NUMBER=#{connection.quote(id)}")
	end


	def self.fin_aid_docs(id)
		get = connection.exec_query("SELECT fafsa_flg, rtvtreq_long_desc from BANINST1.AWS_ONBOARDING_FINAID WHERE Z_NUMBER=#{connection.quote(id)}")
	end


	def self.registered_hours(id)
		get = connection.exec_query("SELECT sfrstcr_credit_hr from BANINST1.AWS_ONBOARDING_COURSE_REG WHERE Z_NUMBER=#{connection.quote(id)}")
	end


	# def self.oars_status(id)
	# 	get = connection.exec_query("SELECT fname, lname, semester_desc, oars_version, status_desc FROM DWPROD.OARS_STUDENTS WHERE ID=#{connection.quote(id)}")
	# end

	# def self.orientation_status(id)
	# 	get = connection.exec_query("SELECT id, firstname, lastname studenttype, term_entry, sessiondate, attended FROM DWPROD.ORIENTATION_TRACKING WHERE ID=#{connection.quote(id)}")
	# end

end