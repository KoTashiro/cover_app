class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.new(order_params)
    if @order.save
      redirect_to orders_url, notice: "オーダー 「#{@order.child_name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    @order = current_user.orders.find(params[:id])
  end

  def update
    @order = current_user.orders.find(params[:id])

    if @order.update(order_params)
      redirect_to orders_url, notice: "オーダー 「#{@order.child_name}」を更新しました"
    else
      render :edit
    end
  end

  def destroy
    order = current_user.orders.find(params[:id])
    order.destroy
    redirect_to orders_url, notice: "オーダー「#{order.child_name}」を削除しました。"
  end

  private

  def order_params
    params.require(:order).permit(:child_name,:ruby_name,:need_ruby,:need_space,:thread_color,:font_name)
  end
end
