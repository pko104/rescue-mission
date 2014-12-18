class AnswersController < ApplicationController

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

  def vote
    #binding.pry
    @answer = Answer.find_by(id: params[:format])
    @answer.vote += 1
    @answer.save
    redirect_to :back, notice: "VOTE SUCCESS!!!!."
  end

  def create
   # @question_id = params[:id]
    @user = User.all
    @question = Question.find_by(params[:id])
    @answer = Answer.new(answer_params)
    @answer.user_id = current_user.id
    @answer.question_id = @question.id
    @answer.vote = 0
    if @answer.save
    redirect_to question_path(id: @question.id), notice: "Your answer was submitted."
    else
    redirect_to :back, notice: "Your answer must be longer than 50 chars."
    end
  end

  def new
    @users = User.all
    @question = Question.find_by(params[:id])
    @answers = Answer.new
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    redirect_to :back, notice: "Your answer was terminated."
  end

  # def create
  #   @post = Post.find_by(params[:id])
  #   @response = Response.new(response_params)
  #   @response.post_id = @post.id
  #   @response.save!
  #   render "posts/show"
  # end


  def answer_params
    params.require(:answer).permit(:message, :question_id, :user_id)
  end

end

