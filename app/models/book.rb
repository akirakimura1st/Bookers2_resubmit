class Book < ApplicationRecord
	belongs_to :user

	validates :title, presence: true
	validates :opinion, presence: true, length: { in: 1..200 }
end
