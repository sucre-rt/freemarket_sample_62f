class MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    if message.save
      flash[:notice] = "メッセージを送信しました"
      redirect_to  product_path(params[:product_id])
    else
      binding.pry
      flash[:notice] = "メッセージの送信に失敗しました"
      redirect_to  product_path(params[:product_id])
    end
  end

  def show
  end

  def edit
  end

  def delete
  end

  private
  def message_params
    params.require(:message).permit(:message).merge(product_id: params[:product_id]).merge(user_id: current_user.id)
  end
end
