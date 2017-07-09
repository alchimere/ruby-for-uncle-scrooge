class OperationCategoriesController < ApplicationController
  before_action :set_operation_category, only: [:show, :edit, :update, :destroy]

  # GET /operation_categories
  # GET /operation_categories.json
  def index
    @operation_categories = OperationCategory.all
  end

  # GET /operation_categories/1
  # GET /operation_categories/1.json
  def show
  end

  # GET /operation_categories/new
  def new
    @operation_category = OperationCategory.new
  end

  # GET /operation_categories/1/edit
  def edit
  end

  # POST /operation_categories
  # POST /operation_categories.json
  def create
    @operation_category = OperationCategory.new(operation_category_params)

    respond_to do |format|
      if @operation_category.save
        format.html { redirect_to @operation_category, notice: 'Operation category was successfully created.' }
        format.json { render :show, status: :created, location: @operation_category }
      else
        format.html { render :new }
        format.json { render json: @operation_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operation_categories/1
  # PATCH/PUT /operation_categories/1.json
  def update
    respond_to do |format|
      if @operation_category.update(operation_category_params)
        format.html { redirect_to @operation_category, notice: 'Operation category was successfully updated.' }
        format.json { render :show, status: :ok, location: @operation_category }
      else
        format.html { render :edit }
        format.json { render json: @operation_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operation_categories/1
  # DELETE /operation_categories/1.json
  def destroy
    @operation_category.destroy
    respond_to do |format|
      format.html { redirect_to operation_categories_url, notice: 'Operation category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operation_category
      @operation_category = OperationCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def operation_category_params
      params.require(:operation_category).permit(:name, :operation_category_id)
    end
end
