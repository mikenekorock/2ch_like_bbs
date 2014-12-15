class SubsController < ApplicationController
	def create
		@main = Main.find(params[:main_id])
		#@sub = @main.subs.create(sub_params)#create:モデルオブジェクトの生成、保存を同時に行う。わかりやすくnewとsaveをまとめてやっちゃう。なるほどここで保存しちゃってたから↓の正規表現での置き換え処理がどうやってもできなかったんだね
		@sub = @main.subs.new(sub_params)
		@sub[:text].gsub!(/>>(\d{1,3})/,'<a href=#\1>>>\1</a>')
		@sub[:text].gsub!(/＞＞(\d{1,3})/,'<a href=#\1>>>\1</a>')
		#セーブ処理
		@sub.save
		redirect_to main_path(@main.id)
		#render main_path(@main.id)
		#binding.pry
	end

	def destroy
		@sub = Sub.find(params[:id])
		@sub.destroy
		redirect_to main_path(params[:main_id])
	end
	private

	def sub_params
		params[:sub].permit(:title, :name, :text)
	end
end
