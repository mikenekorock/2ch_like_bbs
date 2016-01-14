class Main < ActiveRecord::Base
	has_many :subs
	validates :title, presence: { message: "スレッドタイトルが入力されていません"}
end
