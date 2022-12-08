class AdminsBackoffice::QuestionsController < AdminsBackofficeController
  before_action :set_question, only: %i[edit update destroy]
  before_action :get_subjects, only: %i[new edit]

  def index
    @questions = Question.includes(:subject)
                         .order(:description)
                         .page(params[:page])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to admins_backoffice_questions_path, notice: 'Pergunta foi criada com sucesso.'
    else
      render :new, notice: 'Algo deu errado.'
    end
  end

  def edit; end

  def update
    if @question.update(question_params)
      redirect_to admins_backoffice_questions_path, notice: 'Pergunta foi atualizada com sucesso.'
    else
      render :edit, notice: 'Algo deu errado.'
    end
  end

  def destroy
    if @question.destroy
      redirect_to admins_backoffice_questions_path, notice: 'Pergunta excluído com sucesso.'
    else
      render :index, notice: 'Algo deu errado.'
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def get_subjects
    @subjects = Subject.all
  end

  def question_params
    params.require(:question).permit(:description)
  end
end
