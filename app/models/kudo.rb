class Kudo < ApplicationRecord
  belongs_to :given_by, :class_name => 'User'
  belongs_to :given_to, :class_name => 'User'

end
