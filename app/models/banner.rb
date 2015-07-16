class Banner < ActiveRecord::Base

	self.abstract_class = true
	self.table_name="BANINST1.AWS_ONBOARDING_MAIN"

	establish_connection(:bannertest)


	#BEGIN: QUERIES TO BANINST1.AWS_ONBOARDING_MAIN
		def self.find_student_by_netid(id)
		 	get = connection.exec_query("select distinct Z_NUMBER, L_NAME, F_NAME, GOBTPAC_EXTERNAL_USER  FROM BANINST1.AWS_ONBOARDING_MAIN WHERE GOBTPAC_EXTERNAL_USER=#{connection.quote(id)} AND rownum = 1")
		end

		def self.fullname(id)
		 	get = connection.exec_query("select distinct CONCAT(CONCAT(L_NAME, ' '), F_NAME) as fullname  FROM BANINST1.AWS_ONBOARDING_MAIN WHERE Z_NUMBER=#{connection.quote(id)} AND rownum = 1")
		end

		def self.find_newstudents
		 	get = connection.exec_query("select distinct Z_NUMBER, L_NAME, F_NAME, GOBTPAC_EXTERNAL_USER from BANINST1.AWS_ONBOARDING_MAIN where rownum <= 30")
		end


		def self.aleks_status(id)
			get = connection.exec_query("SELECT aleks_taken FROM BANINST1.AWS_ONBOARDING_MAIN WHERE Z_NUMBER=#{connection.quote(id)}")
		end

		def self.tuition_deposit_status(id)
			get = connection.exec_query("SELECT sarchkl_admr_code, sarchkl_receive_date FROM BANINST1.AWS_ONBOARDING_MAIN WHERE Z_NUMBER=#{connection.quote(id)}")
		end

	#END: QUERIES TO BANINST1.AWS_ONBOARDING_MAIN
	

	#BEGIN: QUERIES TO BANINST1.AWS_ONBOARDING_COURSE_REG

		def self.registered_hours(id)
			get = connection.exec_query("SELECT Z_NUMBER, SFRSTCR_TERM_CODE, SUM(sfrstcr_credit_hr) as sfrstcr_credit_hr from BANINST1.AWS_ONBOARDING_COURSE_REG WHERE Z_NUMBER=#{connection.quote(id)} AND sfrstcr_credit_hr >0 GROUP BY  Z_NUMBER, SFRSTCR_TERM_CODE, sfrstcr_credit_hr")
		end

	#END:QUERIES TO BANINST1.AWS_ONBOARDING_COURSE_REG


	#BEGIN: QUERIES TO BANINST1.AWS_ONBOARDING_FINAID

		def self.fin_aid_docs(id)
			get = connection.exec_query("SELECT fafsa_flg, rtvtreq_long_desc, rrrareq_sat_ind  from BANINST1.AWS_ONBOARDING_FINAID WHERE Z_NUMBER=#{connection.quote(id)}")
		end

		def self.immunization_status(id)
			get = connection.exec_query("SELECT IMM_HOLD_FLG from BANINST1.AWS_ONBOARDING_FINAID WHERE Z_NUMBER=#{connection.quote(id)}")
		end

		def self.residency_status(id)
			get = connection.exec_query("SELECT SGBSTDN_RESD_CODE from BANINST1.AWS_ONBOARDING_FINAID WHERE Z_NUMBER=#{connection.quote(id)}")
		end

	#END:QUERIES TO BANINST1.AWS_ONBOARDING_FINAID


	# def self.oars_status(id)
	# 	get = connection.exec_query("SELECT fname, lname, semester_desc, oars_version, status_desc FROM DWPROD.OARS_STUDENTS WHERE ID=#{connection.quote(id)}")
	# end

	# def self.orientation_status(id)
	# 	get = connection.exec_query("SELECT id, firstname, lastname studenttype, term_entry, sessiondate, attended FROM DWPROD.ORIENTATION_TRACKING WHERE ID=#{connection.quote(id)}")
	# end

end