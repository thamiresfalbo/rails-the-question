class Subject < ApplicationRecord
  has_many :questions
  paginates_per 25
end
