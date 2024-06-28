# app/controllers/jedis_controller.rb
class JedisController < ApplicationController
    before_action :set_jedi, only: [:show, :edit, :update, :destroy] 
  
    # GET /jedis
    def index
      @jedis = Jedi.all
    end
  
    # GET /jedis/1
    def show
    end
  
    # GET /jedis/new
    def new
      @jedi = Jedi.new
    end
  
    # GET /jedis/1/edit
    def edit
      # Uses @jedi instance variable set by before_action :set_jedi
    end
  
    # POST /jedis
    def create
      @jedi = Jedi.new(jedi_params)
  
      if @jedi.save
        redirect_to @jedi, notice: 'Jedi profile was successfully created.'
      else
        render :new
      end
    end
  
    # PATCH/PUT /jedis/1
    def update
      if @jedi.update(jedi_params)
        redirect_to @jedi, notice: 'Jedi profile was successfully updated.'
      else
        render :edit
      end
    end
  
    # DELETE /jedis/1
    def destroy
      @jedi.destroy
      redirect_to jedis_url, notice: 'Jedi profile was successfully deleted.'
    end
  
    private
  
    def set_jedi
      @jedi = Jedi.find(params[:id])
    end
  
    def jedi_params
      params.require(:jedi).permit(:name, :homeworld, :lightsaber_color, :image)
    end
  end
  