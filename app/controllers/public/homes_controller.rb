class Public::HomesController < ApplicationController
  def top
    @reviews = Review.all.order(created_at: :desc)
    @reviews = Review.all.page(params[:page]).per(3)
    @genres = Genre.all.page(params[:page]).per(8)
  end
end
