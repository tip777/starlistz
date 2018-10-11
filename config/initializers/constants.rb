# 定数
module Constants
    ## Constants::SORTでアクセスできる
    SORT = "new"
    GENRE = "All genre"
    SUPPORT_MAIL = "support@starlistz.com" 
    COMPANY_ADDRESS = "〒451-0045 愛知県名古屋市西区名駅2丁目34-17 セントラル名古屋1101" 
    COMPANY_TELL = "050-5433-0291" 
    DLETE_MARK_LIST = "(削除済)"
    DLETE_MARK_USER = "(退会済)"
    HP_URL = "https://www.starlistz.com"
    STRIPE_AUTH_URL = "https://dashboard.stripe.com/oauth/authorize?response_type=code&client_id=#{ENV['STRIPE_CLIENT_ID']}&scope=read_write"
    ENCRYPT_SECRET_KEY = "f7583c012fb7fba87fe6e091b7bb4116b41c17ffe9bb88659f867079995c609f"
    
    arr = []
    # arr.push(50)
    # arr.push(5500)
    for i in 1..50 do
        if i <= 5
            arr.push(i * 100)
            arr.push(i * 100 + 50)
        else
            arr.push(i * 100)
        end
    end
    AMOUNT =  arr
    
    #ユーザー名で使用できないもの
    ERR_WORD = %w(index home top help about security contact connect support faq form mail update mobile phone portal tour tutorial navigation navi manual doc company store shop topic news information info howto pr press release sitemap plan price business premium member term privacy rule inquiry legal policy icon image img photo css stylesheet style script src js javascript dist asset source static file flash swf xml json sag cgi account user item entry article page archive tag category event contest word product project download video blog diary site popular i my me owner profile self old first last start end special design theme purpose book read organization community group all status state search explore share feature upload rss atom widget api wiki bookmark captcha comment jump ranking setting config tool connect notify recent report system sys message msg log analysis query call calendar friend graph watch cart activity password auth session register login logout signup signin signout forgot admin root secure get show create edit update post destroy delete remove reset error new dashboard recruit join offer career corp Apache:cgi-bin server-status balancer-manager ldap-status server-info svn as by if is on or add dir off out put case else find then when count order select switch school developer dev test bug code guest app maintenance roc id bot game forum contribute usage feed ad service official language repository spec license asct dictionary dict version ver gift alpha beta tux year public private default request req data master die exit eval issue thread diagram undef nan null empty 0 www chart about copyright list lists users charges charge relationships relationship favorites favorite playlist purchasehistory salesmanage salesmonth playlist_genre user_genre searches ac ad ae af ag ai al am ao aq ar as at au aw ax az ba bb bd be bf bg bh bi bj bm bn bo br bs bt bw by bz ca cc cd cf cg ch ci ck cl cm cn co cr cu cv cw cx cy cz de dj dk dm do dz ec ee eg er es et eu fi fj fk fm fo fr ga gd ge gf gg gh gi gl gm gn gp gq gr gs gt gu gw gy hk hm hn hr ht hu id ie il im in io iq ir is it je jm jo jp ke kg kh ki km kn kp kr kw ky kz la lb lc li lk lr ls lt lu lv ly ma mc md me mg mh mk ml mm mn mo mp mq mr ms mt mu mv mw mx my mz na nc ne nf ng ni nl no np nr nu nz om pa pe pf pg ph pk pl pm pn pr ps pt pw py qa re ro rs ru rw sa sb sc sd se sg sh si sk sl sm sn so sr ss st su sv sx sy sz tc td tf tg th tj tk tl tm tn to tr tt tv tw tz ua ug uk us uy uz va vc ve vg vi vn vu wf ws ye yt za zm zw)

end