class Invoice < ApplicationRecord
  has_one :job
  belongs_to :job
end
