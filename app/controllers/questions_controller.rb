class QuestionsController < ApplicationController

  helpers do
    def current_user
      user_id = session[:user_id]
      @current_user ||= User.find(user_id) if user_id.present?

    end

    def signed_in?
      current_user.present?
    end
  end

  def set_current_user(user)
    session[:user_id] = user.id
  end

  def index
    @users = User.all
    @questions = Question.order('created_at')
  end

  def show
    @question = Question.find(params[:id])
    @answers = Answer.order('vote DESC').where(question_id: params[:id])
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_path, notice: "Your question was terminated."
  end

  def new
  @questions = Question.new
  end

  def create
    @questions = Question.new(question_params)
    @questions.user_id = current_user.id
    if @questions.save
      redirect_to questions_path(@questions), notice: "Question Submitted"
    else
      flash.now[:notice]= @questions.errors.full_messages
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.update_attributes(question_params)
    redirect_to @question
  end

  def question_params
    params.require(:question).permit(:name, :description)
  end

end
