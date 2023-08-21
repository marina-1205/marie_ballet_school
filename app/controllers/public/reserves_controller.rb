class Public::ReservesController < ApplicationController
 def new
    @reserve = Reserve.new
    @lesson_class = LessonClass.all
 end
  
 def create
    @reserve = Reserve.new(reserve_params) # フォームからの入力を使って新しい Reserve オブジェクトを作成
  if @reserve.save
    redirect_to complete_reserves_path
  else
    # 保存に失敗した場合の処理（エラーメッセージの表示など）
    render 'new'
  end
 end


 def complete
 end

private

def reserve_params
  # フォームから許可された属性のみを取得する
  params.require(:reserve).permit(:last_name, :first_name, :last_kana_name, :first_kana_name, :phone_number, :email, :age, :reservation_date, :lesson_class_id, :address)
end

end

