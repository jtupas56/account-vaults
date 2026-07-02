class VaultsController < ApplicationController
  before_action :set_vault, only: %i[ show edit update destroy ]

  # GET /vaults or /vaults.json
  def index
    @vaults = Vault.all
  end

  # GET /vaults/1 or /vaults/1.json
  def show
  end

  # GET /vaults/new
  def new
    @vault = Vault.new
  end

  # GET /vaults/1/edit
  def edit
  end

  # POST /vaults or /vaults.json
  def create
    @vault = Vault.new(vault_params)

    respond_to do |format|
      if @vault.save
        format.html { redirect_to @vault, notice: "Vault was successfully created." }
        format.json { render :show, status: :created, location: @vault }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @vault.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /vaults/1 or /vaults/1.json
  def update
    respond_to do |format|
      if @vault.update(vault_params)
        format.html { redirect_to @vault, notice: "Vault was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @vault }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @vault.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /vaults/1 or /vaults/1.json
  def destroy
    @vault.destroy!

    respond_to do |format|
      format.html { redirect_to vaults_path, notice: "Vault was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vault
      @vault = Vault.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def vault_params
      params.expect(vault: [ :site, :url, :login, :password ])
    end
end
