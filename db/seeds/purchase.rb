20.times do |i|
    if i >= 6
        if i.odd?  
            Purchase.create(user_id: "1", list_id: i, order_date: Time.now)
        end
    end
end