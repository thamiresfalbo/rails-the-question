class AdminsBackoffice::AdminsController < AdminsBackofficeController
  before_action :verify_password, only: [:update]
  before_action :set_admin, only: %i[edit update destroy]

  def index
    @admins = Admin.all.page(params[:page])
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      redirect_to admins_backoffice_admins_index_path
      flash[:success] = 'Administrador foi criado com sucesso.'
    else
      render :new
      flash[:warning] = 'Algo deu errado.'
    end
  end

  def edit; end

  def update
    if @admin.update(admin_params)
      redirect_to admins_backoffice_admins_index_path
      flash[:success] = 'Administrador foi atualizado com sucesso.'
    else
      render :edit
      flash[:warning] = 'Algo deu errado.'
    end
  end

  def destroy
    if @admin.destroy
      redirect_to admins_backoffice_admins_index_path
      flash[:success] = 'Administrador excluído com sucesso.'
    else
      render :index
      flash[:warning] = 'Algo deu errado.'
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
