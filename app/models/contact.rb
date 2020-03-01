class Contact < ActiveRecord::Base
  # Contact form validations
  validates :name, presence: true
  validates :email, presence: true #Add a validation that only accepts ...@example.com
  validates :comments, length: {maximum: 10}, presence: true 
end