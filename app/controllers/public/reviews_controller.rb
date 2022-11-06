class Public::ReviewsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @reviews = Review.all
    @customer = current_customer
    @reviews = Review.all.page(params[:page]).per(20)
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.customer_id = current_customer.id
    if @review.save
      redirect_to review_path(@review)
    else
      @customer = current_customer
      @review = Review.all
      render :index
    end
  end

  def show
    @review = Review.find(params[:id])
    @customer = @review.customer
  end

  def edit
    @review = Review.find(params[:id])
    if @review.customer == current_customer
      render :edit
    else
      redirect_to reviews_path
    end
  end

  def update
    @review = Review.find(params[:id])
    @review.customer_id = current_customer.id
    if @review.update(review_params)
      redirect_to review_path(@review.id)
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if @review.destroy
      redirect_to reviews_path
    end
  end

  def search
    @spaces = Space.all
  end

  private
  def review_params
    params.require(:review).permit(:image, :title, :address, :evaluation, :genre_id, :reviw_text)
  end
end
