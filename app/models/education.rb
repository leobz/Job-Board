class Education < ApplicationRecord
	enum discipline: [ :ART, :COMPUTER_SCIENCE, :ENGLISH_STUDIES,
		:FINANCE, :INFORMATION_SYSTEMS, :ACCOUNTING, :BUSINESS, :BUSINESS_ADMINISTRATION,
	 	:EDUCATION, :MATHEMATICS, :FHYSICS, :SCIENCE, :STATISTICS_AND_DECISION_THEORY, :LAW, :OTHER]
end
