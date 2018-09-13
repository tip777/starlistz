# 20.times do |i|
#     if i >= 6
#         if i.odd?  
#             Purchase.create(user_id: "1", list_id: i, order_date: Time.now)
#         end
#     end
# end


#売上管理画面用　テストデータ
Purchase.create(user_id: "2", list_id: 2, order_date: Time.zone.local(2014, 3, 3), uid: SecureRandom.uuid, status: "succeeded")
Purchase.create(user_id: "4", list_id: 2, order_date: Time.zone.local(2014, 3, 20), uid: SecureRandom.uuid, status: "succeeded")
Purchase.create(user_id: "4", list_id: 4, order_date: Time.zone.local(2014, 3, 21), uid: SecureRandom.uuid, status: "succeeded")
Purchase.create(user_id: "4", list_id: 5, order_date: Time.zone.local(2014, 4, 21), uid: SecureRandom.uuid, status: "succeeded")
Purchase.create(user_id: "2", list_id: 4, order_date: Time.zone.local(2014, 7, 12), uid: SecureRandom.uuid, status: "succeeded")
Purchase.create(user_id: "2", list_id: 5, order_date: Time.zone.local(2014, 9, 1), uid: SecureRandom.uuid, status: "succeeded")
Purchase.create(user_id: "3", list_id: 3, order_date: Time.zone.local(2016, 2, 23), uid: SecureRandom.uuid, status: "succeeded")
Purchase.create(user_id: "3", list_id: 4, order_date: Time.zone.local(2017, 5, 23), uid: SecureRandom.uuid, status: "succeeded")
Purchase.create(user_id: "3", list_id: 5, order_date: Time.zone.local(2017, 1, 6), uid: SecureRandom.uuid, status: "succeeded")
Purchase.create(user_id: "5", list_id: 2, order_date: Time.zone.local(2016, 2, 6), uid: SecureRandom.uuid, status: "succeeded")
Purchase.create(user_id: "5", list_id: 4, order_date: Time.zone.local(2014, 7, 28), uid: SecureRandom.uuid, status: "succeeded")
Purchase.create(user_id: "5", list_id: 5, order_date: Time.zone.local(2017, 1, 1), uid: SecureRandom.uuid, status: "succeeded")
Purchase.create(user_id: "6", list_id: 5, order_date: Time.zone.local(2018, 4, 1), uid: SecureRandom.uuid, status: "succeeded")
Purchase.create(user_id: "7", list_id: 5, order_date: Time.zone.local(2018, 4, 15), uid: SecureRandom.uuid, status: "succeeded")
Purchase.create(user_id: "8", list_id: 5, order_date: Time.zone.local(2018, 4, 28), uid: SecureRandom.uuid, status: "succeeded")
Purchase.create(user_id: "9", list_id: 5, order_date: Time.zone.local(2018, 4, 1), uid: SecureRandom.uuid, status: "succeeded")
Purchase.create(user_id: "7", list_id: 4, order_date: Time.zone.local(2018, 1, 3), uid: SecureRandom.uuid, status: "succeeded")
Purchase.create(user_id: "9", list_id: 4, order_date: Time.zone.local(2018, 1, 30), uid: SecureRandom.uuid, status: "succeeded")
Purchase.create(user_id: "9", list_id: 2, order_date: Time.zone.local(2017, 5, 20), uid: SecureRandom.uuid, status: "succeeded")
Purchase.create(user_id: "8", list_id: 2, order_date: Time.zone.local(2017, 5, 1), uid: SecureRandom.uuid, status: "succeeded")