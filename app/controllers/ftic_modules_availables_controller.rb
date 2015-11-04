class FticModulesAvailablesController < ApplicationController

  before_filter CASClient::Frameworks::Rails::Filter
  before_action :set_ftic_modules_available, only: [:show, :edit, :update, :destroy]

  # GET /modules_availables
  # GET /modules_availables.json
  def index
    @modules_availables = FticModulesAvailable.where(:isactive => 1).order(:netid)
  end

  def moduledetail
    @modules_availables = FticModulesAvailable.where(:znumber => params[:znum])
  end

  # GET /modules_availables/1
  # GET /modules_availables/1.json
  def show
  end

  # GET /modules_availables/new
  def new
    @modules_available = FticModulesAvailable.new
  end

  # GET /modules_availables/1/edit
  def edit
  end

  # POST /modules_availables
  # POST /modules_availables.json
  def create
    @modules_available = FticModulesAvailable.new(ftic_modules_available_params)

    # PUTS YAML:DUMP('BEGIN*************************************')
    # PUTS YAML:DUMP(ftic_modules_available_params)
    # PUTS YAML:DUMP('END*************************************')


    respond_to do |format|
      if @modules_available.save
        format.html { redirect_to @modules_available, notice: 'Modules available was successfully created.' }
        format.json { render action: 'show', status: :created, location: @modules_available }
      else
        format.html { render action: 'new' }
        format.json { render json: @modules_available.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /modules_availables/1
  # PATCH/PUT /modules_availables/1.json
  def update
    respond_to do |format|
      if @modules_available.update(ftic_modules_available_params)
        format.html { redirect_to ftic_modules_availables_path, notice: 'Record updated!' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @modules_available.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /modules_availables/1
  # DELETE /modules_availables/1.json
  def destroy
    @modules_available.destroy
    respond_to do |format|
      format.html { redirect_to modules_availables_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ftic_modules_available
      @modules_available = FticModulesAvailable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ftic_modules_available_params
      params.require(:ftic_modules_available).permit(:znumber, :netid, :f_name, :l_name, :welcome, :deposit, :depositbypass, :account, :accountbypass, :communication, :communicationbypass, :immunization, :immunizationbypass, :finaid, :finaidbypass, :housingfee, :housingfeebypass, :residency, :residencybypass, :housingmealplan, :housingmealplanbypass, :aleks, :aleksbypass, :oars, :oarsbypass, :learning_comm,  :learning_commbypass, 
        :orientation, :orientationbypass, 
        :registrationbypass, :registration, :emergency, :emergencybypass, :faualert,  :faualertbypass, :owlcard, :owlcardbypass, :bookadvance, :bookadvancebypass ,:tution, :tuitionbypass, :vehiclereg, :vehicleregbypass)
    end
end
