class BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: [:edit, :update]

	def show
		@bookf = Book.find(params[:id])
		@book = Book.new
	end

	def index
		@books = Book.all
		@book = Book.new
	end

	def new
		@book = Book.new
	end


	def edit
		@book = Book.find(params[:id])
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
	if  @book.save
		flash[:notice] = "posted successfully"
		redirect_to book_path(@book)
	else
		@books = Book.all

		render "index"
	end
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			flash[:notice] = "updated successfully"
		redirect_to book_path(@book)
	else
		render 'edit'
	end
	end

	def destroy
		@user = current_user.id
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to user_path(@user)
	end

	private
	def book_params
		params.require(:book).permit(:title, :opinion)
	end

	def correct_user
		@book = Book.find(params[:id])
	if  @book.user_id != current_user.id
		redirect_to books_path
	end
	end

end
