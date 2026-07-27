class VaultsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vault, only: %i[show edit update destroy]

  def index
    @vaults = current_user.vaults
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @vaults = @vaults.where(
        "site ILIKE :q OR url ILIKE :q OR login ILIKE :q",
        q: search_term
      )
    end
    @vaults = @vaults.order(updated_at: :desc)
  end

  def show
  end

  def new
    @vault = current_user.vaults.build
  end

  def edit
  end

  def create
    @vault = current_user.vaults.build(vault_params)

    respond_to do |format|
      if @vault.save
        format.html { redirect_to vaults_path, notice: "Vault was successfully created." }
        format.json { render :show, status: :created, location: @vault }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vault.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @vault.update(vault_params)
        format.html { redirect_to vaults_path, notice: "Vault was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @vault }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vault.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vault.destroy!

    respond_to do |format|
      format.html { redirect_to vaults_path, notice: "Vault was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_vault
    @vault = current_user.vaults.find(params[:id])
  end

  def vault_params
    params.require(:vault).permit(:site, :url, :login, :password)
  end
end