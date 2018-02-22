# ->
#     #parameter get
#     add = ->
#       url = location.href
#       paramArray = []
#       if url.indexOf('?') != -1
#         params = url.split('?')
#         spparams = params[1].split('&')
#         i = 0
#         while i < spparams.length
#           vol = spparams[i].split('=')
#           paramArray.push vol[1]
#           i++
#       paramArray
    
#     #select tag parameter send
    
#     param_change = ->
#       array = $('.js-multiple').val()
#       url = 'sort=' + $('.select-main').val()
#       if array
#         $.each array, (i, val) ->
#           url = url + '&genre[]=' + val
#           return
#       window.location.search = url
#       return
    
#     $('.js-multiple').select2 width: 200
#     $('.js-hide-search').select2
#       minimumResultsForSearch: Infinity
#       width: 100
#     url = add()
#     #パラメーター取得
#     if url.length > 0
#       $('.select-main').val(url[0]).trigger 'change'
#       #select2 sort set value
#     else
#       $('.select-main').val('new').trigger 'change'
#     #select2 multi val parameters
#     multiVal = []
#     if url.length > 1
#       $.each url, (i, val) ->
#         if i != 0
#           multiVal[i - 1] = val
#         return
#     else
#       multiVal[0] = 'all'
#       #controllerからもらう値にする
#     $('.js-multiple').val(multiVal).trigger 'change'
#     #select2 multi set value
#     $('.select-main').on 'change', param_change
#     $('.js-multiple').on 'change', param_change
