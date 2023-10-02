class LoansController < ApplicationController
  
  skip_before_action :verify_authenticity_token
  before_action :set_loan, only: [:show, :update, :destroy]
  skip_before_action :set_loan, only: [:create]

  # GET /loans
  def index
    if params[:clientId].present?
      @loans = Loan.where(client_id: params[:clientId])
    else
      @loans = Loan.all
    end

    render json: @loans
  end


  # GET /loans/1
  def show
    render json: @loan
  end

  def create
    puts "Received params: #{params.inspect}"
    @loan = Loan.new(loan_params)
    puts "Loan Params: #{loan_params.inspect}"
    client_id = params[:client_id]     
    @loan.client_id = client_id
  
    if @loan.save
      render json: @loan, status: :created, location: @loan
    else
      render json: @loan.errors, status: :unprocessable_entity
    end
  end
  


  # PATCH/PUT /loans/1
  def update
    if @loan.update(loan_params)
      render json: @loan
    else
      render json: @loan.errors, status: :unprocessable_entity
    end
  end

  # DELETE /loans/1
   
  def destroy
    if @loan
      @loan.destroy
      render json: { message: 'Loan deleted successfully' }, status: :ok
    else
      render json: { error: 'Loan not found' }, status: :not_found
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan
      @loan = Loan.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def loan_params
      params.permit(:amount, :interest_rate, :interest_amount, :start_date, :client_id)
    end
    
end
