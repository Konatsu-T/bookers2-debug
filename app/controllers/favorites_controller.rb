class FavoritesController < ApplicationController
	def create
		book = Book.find(params[:book_id])
		favorite = current_user.favorites.new(book_id: book.id)
		favorite.save
		redirect_to books_path
	end

	def destroy
		book = Book.find(params[:book_id])
		favorite = current_user.favorites.find_by(book_id: book.id)
		favorite.destroy
		redirect_to books_path
	end

	def create_show
		book = Book.find(params[:book_id])
		favorite = current_user.favorites.new(book_id: book.id)
		favorite.save
		redirect_to book_path(book.id)
	end

	def destroy_show
		book = Book.find(params[:book_id])
		favorite = current_user.favorites.find_by(book_id: book.id)
		favorite.destroy
		redirect_to book_path(book.id)
	end
end
