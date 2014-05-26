class Main < ActiveRecord::Base
	has_many :subs
	validates :title, presence: { message: "ootto!"}
end
