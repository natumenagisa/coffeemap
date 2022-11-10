class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @reviews = Review.all
    @customer = current_customer
    @reviews = Review.all.page(params[:page]).per(20)
  end

  def show
    @review = Review.find(params[:id])
    @customer = @review.customer
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to admin_review_path(@review.id)
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if @review.destroy
      redirect_to admin_reviews_path
    end
  end

  private
  def review_params
    params.require(:review).permit(:image, :title, :address, :evaluation, :genre_id, :reviw_text)
  end
end
