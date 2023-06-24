class Job < ApplicationRecord
    validates :company, :company_logo, :title, :description, :website, :presence => true
    enum location_mode: [ :REMOTE, :ON_SITE, :HYBRID]
    has_one_attached :company_logo
    has_many :invoice
    # Uncomment if you use companies table
    # belongs_to :company1
end
