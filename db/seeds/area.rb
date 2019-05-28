# coding: utf-8
require "csv"

# Prefecture.delete_all # 重複するとERRORになる為、seedの度に再作成している。
# namelist = Array.new
# CSV.foreach('db/prefecturals_name_seed.csv') do |row|
#   record = {
#     :id              => row[0].to_i,
#     :name            => row[1],
#   }
#   p record
#   name = Prefecture.create!(record)
#   namelist[name.id] = name # 配列でオブジェクトを退避
# end

namelist = Array.new
namelist = Prefecture.all

Area.delete_all
CSV.foreach('db/postal_code_seed.csv') do |row|
  record = {
    :postal_code     => row[0],
    :prefecture     => namelist[row[1].to_i - 1], # オブジェクトを紐付け
    :city            => row[3],
    :street          => row[4],
  }
  p record
  Area.create!(record)
end