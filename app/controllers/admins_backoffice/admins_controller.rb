class AdminsBackoffice::AdminsController < AdminsBackofficeController
  def index
    @admins = Admin.all
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    @admin = Admin.find(params[:id])
    if @admin.update(admin_parms)
      redirect_to admins_backoffice_admins_index_path, notice: 'Admin was successfully updated'
    else
      render :edit, notice: 'Something went wrong'
    end
  end

  private

  def admin_parms
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end
end
