# 20.times do |i|
#     if i >= 6
#         if i.odd?  
#             Purchase.create(user_id: "1", list_id: i, order_date: Time.now)
#         end
#     end
# end

#売上管理画面用　テストデータ
Purchase.create(user_id: "2", list_id: 2, order_date: Time.zone.local(2014, 3, 3))
Purchase.create(user_id: "4", list_id: 2, order_date: Time.zone.local(2014, 3, 20))
Purchase.create(user_id: "4", list_id: 4, order_date: Time.zone.local(2014, 3, 21))
Purchase.create(user_id: "4", list_id: 5, order_date: Time.zone.local(2014, 4, 21))
Purchase.create(user_id: "2", list_id: 4, order_date: Time.zone.local(2014, 7, 12))
Purchase.create(user_id: "2", list_id: 5, order_date: Time.zone.local(2014, 9, 1))
Purchase.create(user_id: "3", list_id: 3, order_date: Time.zone.local(2016, 2, 23))
Purchase.create(user_id: "3", list_id: 4, order_date: Time.zone.local(2017, 5, 23))
Purchase.create(user_id: "3", list_id: 5, order_date: Time.zone.local(2017, 1, 6))
Purchase.create(user_id: "5", list_id: 2, order_date: Time.zone.local(2016, 2, 6))
Purchase.create(user_id: "5", list_id: 4, order_date: Time.zone.local(2014, 7, 28))
Purchase.create(user_id: "5", list_id: 5, order_date: Time.zone.local(2017, 1, 1))
Purchase.create(user_id: "6", list_id: 5, order_date: Time.zone.local(2018, 4, 1))
Purchase.create(user_id: "7", list_id: 5, order_date: Time.zone.local(2018, 4, 15))
Purchase.create(user_id: "8", list_id: 5, order_date: Time.zone.local(2018, 4, 28))
Purchase.create(user_id: "9", list_id: 5, order_date: Time.zone.local(2018, 4, 1))
Purchase.create(user_id: "7", list_id: 4, order_date: Time.zone.local(2018, 1, 3))
Purchase.create(user_id: "9", list_id: 4, order_date: Time.zone.local(2018, 1, 30))
Purchase.create(user_id: "9", list_id: 2, order_date: Time.zone.local(2017, 5, 20))
Purchase.create(user_id: "8", list_id: 2, order_date: Time.zone.local(2017, 5, 1))