class Admin::LessonClassesController < ApplicationController
  def index
    @lesson_class = LessonClass.new
    @lesson_classes = LessonClass.all
  end

  def create
    @lesson_class = LessonClass.new(genre_params)
    @lesson_classes = LessonClass.all
    if @lesson_class.save
      redirect_to admin_lesson_classes_path, notice:"ジャンル名を追加しました"
    else
      render :index
    end
  end

  def edit
    @lesson_class = LessonClass.find(params[:id])
  end

  def update
    @lesson_class = LessonClass.find(params[:id])
    if @lesson_class.update(lesson_class_params)
     redirect_to admin_lesson_classes_path, notice:"ジャンル名を変更しました。"
    else
     render :edit
    end
  end

  private

  def lesson_class_params
    params.require(:lesson_class).permit(:name)
  end

end