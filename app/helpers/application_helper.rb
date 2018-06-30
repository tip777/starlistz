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
    
    # targetが削除済みか判定
    def is_delete(target)
        if target.deleted_at.nil?
            return false
        else
            return true
        end
    end
end
