class AnswersController < ApplicationController

  def create
    #.pry
   # @question_id = params[:id]
    @question = Question.find_by(params[:id])
    @answer = Answer.new(answer_params)
    @answer.question_id = @question.id
    if @answer.save!
    redirect_to question_path(id: @question.id), notice: "Your answer was submitted."
    else
    redirect_to :back, flash.now[:notice] = @answer.errors.full_messages
    end
  end

  def new
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
    params.require(:answer).permit(:message, :question_id)
  end

end

