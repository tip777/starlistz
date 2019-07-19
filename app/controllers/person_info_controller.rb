class PersonInfoController < ApplicationController
  
  def index
    @user = User.find(params[:id])
    
    #list newからのリダイレクトかどうか
    if params[:ref] == "list_add"
      @is_ref_list_add = 1
    else
      @is_ref_list_add = nil
    end
    
    if current_user.nil?
      redirect_to new_user_session_path
      
    elsif current_user.id != @user.id
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
    reject_pageh if current_user.nil?
    
    @person_info = current_user.create_person_info(personinfo_params)
    
    # begin
    #   @person_info.birthday = Date.new(personinfo_params['birthday(1i)'].to_i, personinfo_params['birthday(2i)'].to_i, personinfo_params['birthday(3i)'].to_i)
      
    # rescue ArgumentError #存在しない日付だったら
    #   @person_info.errors.add(:birthday, "誕生日の日付が不正です")
    #   # return
      
    # end
    
    if @person_info.save
      if params[:is_ref_list_add] == '1'
        redirect_to new_list_path
      else
        redirect_to person_info_path(current_user), notice: "アカウント情報を登録しました"
      end
      
    else
        render 'index'
      
    end

  end
  
  def update
    reject_pageh if current_user.nil?
    
    @person_info = current_user.person_info
    
    if !Date.valid_date?(personinfo_params['birthday(1i)'].to_i, personinfo_params['birthday(2i)'].to_i, personinfo_params['birthday(3i)'].to_i)
      # errors.add(:birthday, "誕生日の日付が不正です")
    end
    
    if @person_info.update(personinfo_params)
      redirect_to person_info_path(current_user), notice: "アカウント情報を変更しました"
    else
      render 'index'
    end

  end
  
  private

  def personinfo_params
    params.require(:person_info).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :birthday,
                                        :zipcode, :prefecture_id, :city, :address1, :address2, :phone_number, :is_ref_list_add)
  end
  
end
