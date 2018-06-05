module ApplicationHelper
    def is_signed(user_id, other_id)
        if user_id == other_id
            return  true 
        end
    end
    
    def is_signin
        if current_user != nil
            return  true 
        end
    end
    
    # 〇文字以上は...で表示する
    def trun_str(str, strLen)
        return str.truncate(strLen)
    end
end
