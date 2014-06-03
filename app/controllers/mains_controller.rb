class MainsController < ApplicationController
	def index
		@mains = Main.all
		@main = Main.new
	end

	def show
		@main = Main.find(params[:id])
	end



	def destroy
		@main = Main.find(params[:id])
		@main.destroy
		redirect_to "/"
	end


	def new
		@main = Main.new
	end


	def create
		@main = Main.new(main_params)
		@main[:text].gsub!(/>>(\d{1,3})/, '<a href=#\1>>>\1</a>')
		@main.save
		redirect_to '/'
	end


	private

		def main_params
			params[:main].permit(:title, :name, :text)
		end

end
