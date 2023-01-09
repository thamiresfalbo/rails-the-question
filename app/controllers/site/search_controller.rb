class Site::SearchController < SiteController
  def questions
    @questions = Question.includes(:subject)
                         .order(:description)
                         .page(params[:page])
  end
end
