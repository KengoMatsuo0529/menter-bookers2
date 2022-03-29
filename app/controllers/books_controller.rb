class BooksController < ApplicationController
  
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      @users = User.all
      @user = current_user
    render :index
    end
  end

  def index
    @books = Book.all
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
    @books = Book.all
    @users = User.all
    @book = Book.new
    @show_book = Book.find(params[:id])
    @user = @show_book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
      if @book.update(book_params)
    redirect_to book_path(@book), notice: "You have updated book successfully."
      else
      @books = Book.all
      @users = User.all
      @user = current_user
      render :edit
      end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "You have deleted book successfully."
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  def correct_user
    book = Book.find(params[:id])
    if current_user.id != book.user.id
    redirect_to books_path
    end
  end
end
