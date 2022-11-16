class AdminsBackoffice::AdminsController < AdminsBackofficeController
  def index
    @admins = Admin.all
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    @admin = Admin.find(params[:id])
      if @admin.update_attributes(params[:admin])
        flash[:success] = "Object was successfully updated"
        redirect_to @admin
      else
        flash[:error] = "Something went wrong"
        render 'edit'
      end
  end

end
