class ProductsController < ApplicationController
  before_action :set_product, only: [:send_product_mail, :show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = current_user.products.order(:position)
    prices = @products.map(&:price)
    @sum = prices.sum
  end

  def sort
    params[:product].each_with_index do |id, index|
      Product.where(id: id).update_all(position: index + 1)
    end

    head :ok
  end

  def send_product_mail
    @user = current_user
    email = ProductMailer.with(product: @product, user: @user).product_info

    if email.deliver_later
      flash[:notice] = 'Email was sent.'
    else
      flash[:notice] = 'Email could not be sent. Please try again.'
    end

    redirect_to products_path
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product.user = current_user
    shop = Shop.find(params[:product][:shop_id])
    @product.shop = shop

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    shop = Shop.find(params[:product][:shop_id])
    @product.shop = shop

    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = current_user.products.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :price, :attachment, :url)
    end
end
