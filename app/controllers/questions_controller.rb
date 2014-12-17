class QuestionsController < ApplicationController

  def index
  @questions = Question.order('name')
  #@questions = Question.order('timestamps')
  end

  def show
  @question = Question.find(params[:id])
  @answers = Answer.where(question_id: params[:id])
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
    @question.update
    redirect_to @question
  end

  def question_params
    params.require(:question).permit(:name, :description)
  end

end
