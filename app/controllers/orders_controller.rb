class OrdersController < ApplicationController
  def index

    if current_user.admin?
      @orders = Order.order(finished_flag: :asc)
      .order(working_flag: :asc)
      # if params[:query] == '受付済'
      #   @orders = Order.where(working_flag: false,finished_flag: false)
      #   .order(created_at: :desc)
      # elsif params[:query] == '刺繍中'
      #   @orders = Order.where('working_flag = ?', "true")
      #   .order(created_at: :desc)
      # elsif params[:query] == '仕上がり'
      #   @orders = Order.where('finished_flag = ?', "true")
      #   .order(created_at: :desc)
      # end
    else
      @orders = current_user.orders.order(finished_flag: :asc)
      .order(working_flag: :asc)
    end
  end

  def show
    if current_user.admin?
      @order = Order.find(params[:id])
    else
      @order = current_user.orders.find(params[:id])
    end
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
    if current_user.admin?
      @order = Order.find(params[:id])
    else
      @order = current_user.orders.find(params[:id])
    end
  end

  def update
    if current_user.admin?
      @order = Order.find(params[:id])
    else
      @order = current_user.orders.find(params[:id])
    end

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
    params.require(:order).permit(:child_name,:ruby_name,:need_ruby,:need_space,:thread_color,:font_name,:working_flag,:finished_flag)
  end
end
