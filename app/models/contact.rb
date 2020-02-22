class Contact < ActiveRecord::Base
  #Unless these three fields return true by having been filled out, the
  #form will not be saved
  validates :name, presence: true
  validates :email, presence: true #Add a validation that only accepts ...@example.com
  validates :comments, length: {maximum: 10}, presence: true 
end