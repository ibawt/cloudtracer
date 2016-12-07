class HeebiesController < ApplicationController
  before_action :set_heeby, only: [:show, :edit, :update, :destroy]

  # GET /heebies
  def index
    @heebies = Heebie.all
  end

  # GET /heebies/1
  def show
  end

  # GET /heebies/new
  def new
    @heeby = Heebie.new
  end

  # GET /heebies/1/edit
  def edit
  end

  # POST /heebies
  def create
    @heeby = Heebie.new(heeby_params)

    if @heeby.save
      redirect_to @heeby, notice: 'Heebie was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /heebies/1
  def update
    if @heeby.update(heeby_params)
      redirect_to @heeby, notice: 'Heebie was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /heebies/1
  def destroy
    @heeby.destroy
    redirect_to heebies_url, notice: 'Heebie was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_heeby
      @heeby = Heebie.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def heeby_params
      params.require(:heeby).permit(:name, :age)
    end
end
