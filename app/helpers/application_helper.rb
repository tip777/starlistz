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
    
    # 40文字以上は表示しない
    def trun_str(str)
        return str.truncate(40)
    end
end
