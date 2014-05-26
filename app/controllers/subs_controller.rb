class SubsController < ApplicationController
	def create
		@main = Main.find(params[:main_id])
		@sub = @main.subs.create(sub_params)
		@sub.save
		redirect_to main_path(@main.id)
	end


	private

	def sub_params
		params[:sub].permit(:title, :name, :text)
	end
end
