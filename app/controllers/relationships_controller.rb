class RelationshipsController < ApplicationController
before_action :authenticate_user!

	def create
		current_user.create(params[:id])
		redirect_to users_path
	end

	def destroy
		current_user.destroy(params[:id])
		redirect_to users_path
	end

	def create_show
		current_user.create(params[:id])
		redirect_to user_path
	end

	def destroy_show
		current_user.destroy(params[:id])
		redirect_to user_path
	end

	def follows_index
		current_user.create(params[:id])
		redirect_to user_follows_path
	end

	def followers_index
		current_user.destroy(params[:id])
		redirect_to user_follows_path
	end

end
