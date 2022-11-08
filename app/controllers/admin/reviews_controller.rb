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

  def destroy
    @review = Review.find(params[:id])
    if @review.destroy
      redirect_to admin_reviews_path
    end
  end
end
