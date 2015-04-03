class DatastoresController < ApplicationController
  before_action :set_datastore, only: [:show, :edit, :update, :destroy]

  # GET /datastores
  # GET /datastores.json
  def index
    @datastores = Datastore.all
  end

  # GET /datastores/1
  # GET /datastores/1.json
  def show
  end

  # GET /datastores/new
  def new
    @datastore = Datastore.new
  end

  # GET /datastores/1/edit
  def edit
  end

  # POST /datastores
  # POST /datastores.json
  def create
    @datastore = Datastore.new(datastore_params)

    respond_to do |format|
      if @datastore.save
        format.html { redirect_to @datastore, notice: 'Datastore was successfully created.' }
        format.json { render :show, status: :created, location: @datastore }
      else
        format.html { render :new }
        format.json { render json: @datastore.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /datastores/1
  # PATCH/PUT /datastores/1.json
  def update
    respond_to do |format|
      if @datastore.update(datastore_params)
        format.html { redirect_to @datastore, notice: 'Datastore was successfully updated.' }
        format.json { render :show, status: :ok, location: @datastore }
      else
        format.html { render :edit }
        format.json { render json: @datastore.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /datastores/1
  # DELETE /datastores/1.json
  def destroy
    @datastore.destroy
    respond_to do |format|
      format.html { redirect_to datastores_url, notice: 'Datastore was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_datastore
      @datastore = Datastore.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def datastore_params
      params.require(:datastore).permit(:type, :version, :url, :user_id, :project_id)
    end
end
