class Public::HomesController < ApplicationController
  def top
    @reviews = Review.all.order(created_at: :desc)
    @genres = Genre.all
  end
end
