class AirfieldsController < ApplicationController
  before_action :set_airfield, only: [:show, :edit, :update, :destroy]

  # GET /airfields
  # GET /airfields.json
  def index
    @airfields = Airfield.all
  end

  # GET /airfields/1
  # GET /airfields/1.json
  def show
  end

  # GET /airfields/new
  def new
    @airfield = Airfield.new
  end

  # GET /airfields/1/edit
  def edit
  end

  # POST /airfields
  # POST /airfields.json
  def create
    @airfield = Airfield.new(airfield_params)

    respond_to do |format|
      if @airfield.save
        format.html { redirect_to @airfield, notice: 'Airfield was successfully created.' }
        format.json { render :show, status: :created, location: @airfield }
      else
        format.html { render :new }
        format.json { render json: @airfield.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /airfields/1
  # PATCH/PUT /airfields/1.json
  def update
    respond_to do |format|
      if @airfield.update(airfield_params)
        format.html { redirect_to @airfield, notice: 'Airfield was successfully updated.' }
        format.json { render :show, status: :ok, location: @airfield }
      else
        format.html { render :edit }
        format.json { render json: @airfield.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /airfields/1
  # DELETE /airfields/1.json
  def destroy
    @airfield.destroy
    respond_to do |format|
      format.html { redirect_to airfields_url, notice: 'Airfield was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_airfield
      @airfield = Airfield.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def airfield_params
      params.require(:airfield).permit(:icao, :iata, :name, :city, :state, :elevation, :lat, :lon)
    end
end
