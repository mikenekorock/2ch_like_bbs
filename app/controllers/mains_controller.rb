class MainsController < ApplicationController
	def index
		@mains = Main.all
	end
end
