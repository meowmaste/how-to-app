class StepsController < ApplicationController
  before_action :set_step, only: [ :edit, :update, :destroy]

  # GET /steps
  # GET /steps.json
  def index
    @list = List.find(params[:list_id])
    @steps = Step.all
  end

  # GET /steps/1
  # GET /steps/1.json
  def show
     @list = List.find(params[:list_id])
     @step = @list.steps[params[:id].to_i - 1]
  end

  # GET /steps/new
  def new
    @list = List.find(params[:list_id])
    @step = Step.new 
  end

  # GET /steps/1/edit
  def edit
  end

  # POST /steps
  # POST /steps.json
  def create
    @step = Step.new(step_params.merge(list_id: params[:list_id]))
    @list = List.find(params[:list_id])

    respond_to do |format|
      if @step.save
        format.html { redirect_to @list, notice: 'Step was successfully created.' }
        format.json { render action: 'show', status: :created, location: @list }
      else
        format.html { render action: 'new' }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /steps/1
  # PATCH/PUT /steps/1.json
  def update
    respond_to do |format|
      if @step.update(step_params)
        format.html { redirect_to @step, notice: 'Step was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /steps/1
  # DELETE /steps/1.json
  def destroy
    @step.destroy
    respond_to do |format|
      format.html { redirect_to steps_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_step
      @step = Step.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def step_params
      params.require(:step).permit(:title)
    end
end
