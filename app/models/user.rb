class User < ActiveRecord::Base



	validate :eu_vat_is_correct

	def eu_vat_is_correct
		if valid == false
			errors.add(:euvat, "Wrong EUvat number for Poland, Greece or Portugal")
		end
	end


	def valid
		country = euvat[0..1]
		numbers = euvat[2..-1]
		splitter = numbers.split("")
		splitter = splitter.map(&:to_i)
		splitter = splitter[0..-2]
		if country == "PL" && numbers.length == 10		
			x = splitter[0]*6 + splitter[1]*5 + splitter[2]*7 + splitter[3]*2 + splitter[4]*3 + splitter[5]*4 + splitter[6]*5 + splitter[7]*6 + splitter[8]*7
			y = x%11
			if y == numbers[-1].to_i
				return true

			else
				return false
			end
			
		elsif country == "EL" && numbers.length == 9
			x = splitter[0]*256 + splitter[1]*128 + splitter[2]*64 + splitter[3]*32 + splitter[4]*16 + splitter[5]*8 + splitter[6]*4 + splitter[7]*2 
			y = x%11
			if y > 10
				y = y%11
			end
			if y == numbers[-1].to_i
				return true
			else
				return false
			end


		elsif country == "PT" && numbers.length == 9
			x = splitter[0]*9 + splitter[1]*8 + splitter[2]*7 + splitter[3]*6 + splitter[4]*5 + splitter[5]*4 + splitter[6]*3 + splitter[7]*2
			y = 11 - x%11
			if y == numbers[-1].to_i
				return true
			else
				return false
			end
		else
			return false
		end
	end
end
