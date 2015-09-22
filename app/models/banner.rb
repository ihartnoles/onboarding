class Banner < ActiveRecord::Base

	self.abstract_class = true
	self.table_name="BANINST1.AWS_ONBOARDING_MAIN"

	establish_connection(:bannertest)


	#BEGIN: QUERIES TO BANINST1.AWS_ONBOARDING_MAIN
		def self.find_student_by_netid(id)
		 	get = connection.exec_query("select distinct Z_NUMBER, L_NAME, F_NAME, GOBTPAC_EXTERNAL_USER  FROM BANINST1.AWS_ONBOARDING_MAIN WHERE GOBTPAC_EXTERNAL_USER=#{connection.quote(id)} AND rownum = 1")
		end

		def self.find_student_zip_by_z(id)
		 	get = connection.exec_query("select distinct SUBSTR( SPRADDR_ZIP, 1 , 5 ) as ZIP FROM BANINST1.AWS_ONBOARDING_MAIN WHERE Z_NUMBER=#{connection.quote(id)} AND rownum = 1")
		end

		def self.age_calculation(netid)
			get = connection.exec_query("select floor(months_between(SYSDATE, SPBPERS_BIRTH_DATE) /12) as AGE FROM BANINST1.AWS_ONBOARDING_MAIN WHERE Z_NUMBER=#{connection.quote(netid)} AND rownum = 1")
		end

		def self.additional_housing_reqs(id)
			get = connection.exec_query("select floor(months_between(SYSDATE, SPBPERS_BIRTH_DATE) /12) as AGE, SPBPERS_MRTL_CODE, WHC_STUDENT FROM BANINST1.AWS_ONBOARDING_MAIN WHERE Z_NUMBER=#{connection.quote(id)} AND rownum = 1")
		end

		def self.fullname(id)
		 	get = connection.exec_query("select distinct CONCAT(CONCAT(F_NAME, ' '), L_NAME) as fullname  FROM BANINST1.AWS_ONBOARDING_MAIN WHERE Z_NUMBER=#{connection.quote(id)} AND rownum = 1")
		end

		def self.find_newstudents
		 	get = connection.exec_query("select distinct Z_NUMBER, L_NAME, F_NAME, GOBTPAC_EXTERNAL_USER from BANINST1.AWS_ONBOARDING_MAIN")
		end


		def self.aleks_status(id)
			get = connection.exec_query("SELECT aleks_taken FROM BANINST1.AWS_ONBOARDING_MAIN WHERE Z_NUMBER=#{connection.quote(id)}")
		end

		def self.tuition_deposit_status(id)
			get = connection.exec_query("SELECT sarchkl_admr_code, sarchkl_receive_date FROM BANINST1.AWS_ONBOARDING_MAIN WHERE Z_NUMBER=#{connection.quote(id)}")
		end

		def self.account_claimed_status(id)
			get = connection.exec_query("SELECT spremrg_first_name, spremrg_last_name FROM BANINST1.AWS_ONBOARDING_MAIN WHERE Z_NUMBER=#{connection.quote(id)}")
		end

		#BEGIN: a test to consolidate aleks tution and account claim status
			# presence of gobtpac_external_user means they have their netid;
			# aleks_taken = self explanatory
			# sarchkl_admr_code == TUTD -> deposit has been made
			# spremrg fields = emergency contact info on file
		def self.get_multistatus(id)
			get = connection.exec_query("SELECT GOBTPAC_EXTERNAL_USER, aleks_taken, sarchkl_admr_code, sarchkl_receive_date, sarchkl_receive_date, sarchkl_admr_code, CONCAT(CONCAT(spremrg_first_name,' '),spremrg_last_name) as spremrg_contact_name FROM BANINST1.AWS_ONBOARDING_MAIN WHERE Z_NUMBER=#{connection.quote(id)}")
		end
		#END: a test to consolidate aleks tution and account claim status


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