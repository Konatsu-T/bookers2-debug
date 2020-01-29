class BookCommentsController < ApplicationController
	def create
		book = Book.find(params[:book_id])
		@book_comment = BookComment.new(book_comment_params)
		@book_comment.user_id = current_user.id
		@book_comment.book_id = book.id
		if @book_comment.save
		redirect_to book_path(book)
		flash[:notice] = "successfully created comment!"
	    else
	    @book = Book.find(params[:book_id])
	    @newbook = Book.new
	    @user1 = @book.user
	    render template: "books/show"
	  end
	end

	def destroy
		@book_comment = BookComment.find(params[:id])
		@book_comment.destroy
		redirect_to book_path(@book_comment.book_id)
	end

private
def book_comment_params
	params.require(:book_comment).permit(:user_id, :book_id, :comment)
end
end
