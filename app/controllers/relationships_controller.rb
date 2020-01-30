class RelationshipsController < ApplicationController
before_action :authenticate_user!

	def create
		current_user.create(params[:id])
		redirect_to request.referer
	end

	def destroy
		current_user.destroy(params[:id])
		redirect_to request.referer
	end

	# ユーザのフォロー一覧
	def follower
		user = User.find(params[:user_id])
		@users = user.following_user
	end

	# ユーザのフォロワー一覧
	def followed
		user = User.find(params[:user_id])
		@users = user.follower_user
	end
end
