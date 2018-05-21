# 定数
module Constants
    ## Constants::SORTでアクセスできる
    SORT = "new"
    GENRE = "All genre"
    
    arr = []
    arr.push(50)
    arr.push(5500)
    for i in 1..50 do
        if i <= 5
            arr.push(i * 100)
            arr.push(i * 100 + 50)
        else
            arr.push(i * 100)
        end
    end
    AMOUNT =  arr
end