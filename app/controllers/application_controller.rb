class ApplicationController < ActionController::Base
  layout :layout_by_resource
  before_action :set_search

  protected

  def layout_by_resource
    if devise_controller?
      "#{resource_class.to_s.downcase}_devise"
    else
      'application'
    end
  end

  def set_search
    @q = Question.ransack(params[:q])
    @questions = @q.result.includes(:subject, :answers).page(params[:page])
  end

end
