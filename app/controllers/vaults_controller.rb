class VaultsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vault, only: %i[show edit update destroy]

  # GET /vaults
  def index
    @vaults = current_user.vaults
  end

  # GET /vaults/1
  def show
  end

  # GET /vaults/new
  def new
    @vault = current_user.vaults.build
  end

  # GET /vaults/1/edit
  def edit
  end

  # POST /vaults
  def create
    @vault = current_user.vaults.build(vault_params)

    respond_to do |format|
      if @vault.save
        format.html { redirect_to @vault, notice: "Vault was successfully created." }
        format.json { render :show, status: :created, location: @vault }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vault.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vaults/1
  def update
    respond_to do |format|
      if @vault.update(vault_params)
        format.html { redirect_to @vault, notice: "Vault was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @vault }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vault.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vaults/1
  def destroy
    @vault.destroy!

    respond_to do |format|
      format.html { redirect_to vaults_path, notice: "Vault was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  # SECURITY FIX: user can only access THEIR vaults
  def set_vault
    @vault = current_user.vaults.find(params[:id])
  end

  # Strong parameters
  def vault_params
    params.require(:vault).permit(:site, :url, :login, :password)
  end
end