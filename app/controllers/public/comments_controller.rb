class Public::CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def show
    @comment = Comment.find(params[:id])
    @customer = @Comment.customer
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.customer_id = current_customer
    if @comment.save
      redirect_to comment_path(@comment)
    else
      @customer = current_customer
      @comment = Comment.all
      render :show
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    if @comment.customer == current_customer
      render :edit
    else
      redirect_to comment_path
    end
  end

  def update
    @comment = Comment(params[:id])
    @comment.customer_id = current_customer.id
    if @comment.update(comment_params)
      redirect_to comment_path(@comment.id)
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to reviews_path
    end
  end

  private
  def comment_params
    params.require(:comment).premit(:comment_text)
  end
end
