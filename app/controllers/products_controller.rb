class ProductsController < ApplicationController

  before_action :private_access, except: [:index, :show]
  
  def index
  	@products = Product.all 
  end

  def new 
  	@product = Product.new 
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      redirect_to products_path, notice: "El producto fue publicado con éxito"
    else
      render :new
    end	
  end

  def show
  	@product = Product.find(params[:id])
  end

  def edit
  	@product = Product.find(params[:id])
  end

  def update
  	product = Product.find(params[:id])
  	if product.update(product_params) # el update almacena los cambios e la base de datos 
  	  redirect_to products_path, notice: "El producto ha sido modificado con éxito"
    else
      render :edit
    end	
  end

  def destroy
  	product = Product.find(params[:id])
  	product.delete

  	redirect_to products_path, notice: "El producto fue eliminado con éxito"
  end

  private
    def product_params # metodo para obtener la info que se ingresa en el formulario
    params.require(:product).permit(:name, :url, :description, :image)
    end
end