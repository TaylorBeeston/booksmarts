class BooksController < ApplicationController
  before_action :set_book,     only: [:show, :edit, :update, :destroy, :add]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /books
  # GET /books.json
  def index
    @books = Book.where.not(title: current_user.books.pluck(:title)) + current_user.books
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    @book.library_id = current_user.libraries.first.id

    respond_to do |format|
      if !@book.in_library?(current_user) && @book.save
        format.html { redirect_to root_path, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to root_path, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /books/add
  def add
    @new_book = @book.dup
    @new_book.cover.attach(@book.cover.blob) if @book.cover.present?
    @new_book.library_id = current_user.libraries.first.id

    respond_to do |format|
      if !@book.in_library?(current_user) && @new_book.save
        format.html { redirect_to @new_book, notice: 'Book was successfully added.' }
        format.json { render :show, status: :added, location: @new_book }
      else
        format.html { render :new }
        format.json { render json: @new_book.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :author, :cover, :note)
    end

    # Ensure this book is for the currnet user
    def correct_user
      redirect_to root_path unless current_user.id == @book.library.user_id
    end
end
