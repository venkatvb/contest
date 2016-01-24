class Submission < ActiveRecord::Base
  belongs_to :account
  belongs_to :problem
end
