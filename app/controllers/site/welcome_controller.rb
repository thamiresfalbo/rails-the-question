class Site::WelcomeController < SiteController
  def index
    @questions = Question.includes(:subject)
    .order(:description)
    .page(params[:page])
  end
end
