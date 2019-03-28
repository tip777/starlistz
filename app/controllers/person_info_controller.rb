class PersonInfoController < ApplicationController
  
  def index
    @user = User.find(params[:id])
    if current_user.nil?
      redirect_to new_user_session_path
      
    elsif current_user.id == @user.id
      reject_page
      
    else
      user_personInfo = @user.person_info
      if user_personInfo.nil?
        @person_info = PersonInfo.new
      else
        @person_info = user_personInfo
      end
      
    end
    
  end
  
  def create
    @person_info = current_user.create_person_info(personinfo_params)
    
    begin
      @person_info.birthday = Date.new(personinfo_params['birthday(1i)'].to_i, personinfo_params['birthday(2i)'].to_i, personinfo_params['birthday(3i)'].to_i)
      
    rescue ArgumentError #存在しない日付だったら
      @person_info.errors.add(:birthday, "誕生日の日付が不正です")
      return
      
    end
    binding.pry
    return
    
    # if @person_info.save
    #   #ここのcurrent_userは@userの方がいい？ここでデバッグして@userまだのこっているか見る
    #   redirect_to person_info_path(current_user), notice: "会員情報を登録しました"
    # else
    #   render 'index', alert: "会員情報の作成に失敗しました"
    # end
    
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def set_personInfo(personinfo_id)
    @person_info.tap { @person_info = nil }
    @person_info = PersonInfo.with_deleted.find_by(id: personinfo_id)
  end

  def personinfo_params
    params.require(:person_info).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :birthday,
                                        :zipcode, :prefecture, :city, :address1, :address2, :phone_number)
  end
  
end
