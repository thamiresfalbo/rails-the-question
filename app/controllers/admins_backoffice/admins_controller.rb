class AdminsBackoffice::AdminsController < AdminsBackofficeController
  before_action :verify_password, only: [:update]
  before_action :set_admin, only: %i[edit update]

  def index
    @admins = Admin.all
  end

  def edit; end

  def update
    if @admin.update(admin_params)
      redirect_to admins_backoffice_admins_index_path, notice: 'Admin was successfully updated'
    else
      render :edit, notice: 'Something went wrong'
    end
  end

  private

  def verify_password
    return unless params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?

    params[:admin].extract!(:password, :password_confirmation)
  end

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def admin_params
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end
end
