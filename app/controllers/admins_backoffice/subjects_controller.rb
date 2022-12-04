class AdminsBackoffice::SubjectsController < AdminsBackofficeController
  before_action :set_subject, only: %i[edit update destroy]

  def index
    @subjects = Subject.all.order(:description).page(params[:page])
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      redirect_to admins_backoffice_subjects_path, notice: 'Assunto foi criado com sucesso.'
    else
      render :new, notice: 'Algo deu errado.'
    end
  end

  def edit; end

  def update
    if @subject.update(subject_params)
      redirect_to admins_backoffice_subjects_path, notice: 'Assunto foi atualizado com sucesso.'
    else
      render :edit, notice: 'Algo deu errado.'
    end
  end

  def destroy
    if @subject.destroy
      redirect_to admins_backoffice_subjects_path, notice: "Assunto excluído com sucesso."
    else
      render :index, notice: 'Algo deu errado.'
    end
  end

  private

  def set_subject
    @subject = Subject.find(params[:id])
  end

  def subject_params
    params.require(:subject).permit(:description)
  end
end

