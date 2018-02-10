module ApplicationHelper
    def is_signin(user_id, other_id)
        if user_id == other_id
            return  true 
        end
    end 
end
