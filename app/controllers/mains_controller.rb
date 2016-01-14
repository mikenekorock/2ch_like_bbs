class MainsController < ApplicationController

	before_action :main_new, only: [:index, :new, :search]

	def index
		#paramsがnilなら1を代入、早い話が最初のブラウジング時の対応
		params[:page] = 1 if params[:page].blank?

		#早い話がこれのタイトルにリンクつけてループで回せばいい
		#全部表示は却下#@mains = Main.all
		
		#kaminariを使ったページング
		#なんか決まり事のオンパレードなので割愛
		@mains = Main.page(params[:page]).per(5)

		#検索フォームのvalue値に検索ワードを入れているけど、
		#対応するインスタンス変数を予め入れないとエラーになるのでこんな変数が必要になる
		#これもbefore_actionに入れてもいいけどめんどくさかった・・・
		@search_value = {}


	end

	def show
		#これに建てたスレのデータが入っている。
		#わかりやすく言えば＞＞1のデータはこの中に入っている
		#idがSubテーブルに関連付けられているからまとめて呼び出せる
		@main = Main.find(params[:id])
	end



	def destroy
		@main = Main.find(params[:id])
		#スレを削除するときはスレ内の書き込みもまとめて削除しよう
		@main.subs.destroy_all
		#スレそのものも削除
		@main.destroy
		redirect_to "/"
	end


	#一見意味無いように見えるけどこれも必要。
	#before_actionを見てみよう。
	def new
	end


    #スレを建てる
	def create
		@search_value = {}
		#スレ建てのテーブルに新しい空テーブルを作成
		#この時点ではまだ保存されていない
		@main = Main.new(main_params)
		#安価があったらリンクに変換する
		@main[:text].gsub!(/>>(\d{1,3})/, '<a href=#\1>>>\1</a>')

		#ここで初めてDBに保存される、
		#saveメソッドは同時にvalidateも実行される
		#if文にsaveを入れるとvalidateが通ればtrue、同時にsaveも実行
		#通らなければfalseになるというやたら都合のいいルールがある。
		#これを使わない手はない
		if @main.save
			redirect_to root_path
		else
			#save時にvalidateに引っかかってエラー文が入っていたらこっちへ行く
			@mains = Main.page(params[:page]).per(5)
			render "index"
		end
	end


	def search
		#ransackを使って検索結果に絞り込む処理
		main = Main.search(params[:search]).result

		#kaminariどーん
		@mains = main.page(params[:page]).per(5)

		#検索フォームのvalue値
		@search_value = params[:search]
		render "index"

	end


	#スレ建てフォームのパラメータに使う
	#newメソッドではsaveするデータを作るためのパラメータに使う
	def main_new
		@main = Main.new
	end

	private

		#セキュリティの強化でparamsの値をこういうふうに格納するらしい
		def main_params
			params[:main].permit(:title, :name, :text)
		end

end
