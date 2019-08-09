module ApplicationHelper
    
    include StripeCreate #Stripe 作成部分

    def default_meta_tags
    {
        reverse: true,
        title: "StarListz",
        description: "曲への気持ち、聴く理由にフォーカスしたプレイリストを売り買いできるサービスです。",
        keywords: "starlistz,プレイリスト,曲,気持ち",
        canonical: request.original_url,
        og: {
        title: :title,
        type: "website",
        url: request.original_url,
        image: "#{asset_path "Logo.png"}",
        site_name: "StarListz",
        description: :description,
        locale: 'ja_JP'
        }
    }
    end
    
    #Stripe 認証ページのURLを編集 
    def stripe_url_header(current_user)
        return stripe_url_edit(current_user)
    end
    
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
    
    #本人確認されているか判定
    def is_identity?(user)
        if user.nil?
          return false
        else
          if user.identity == 'verified'
            return true
          else
            return false
          end
        end
    end
    
    # 〇文字以上は...で表示する
    def trun_str(str, strLen)
        if str.nil?
            return
        else
            return str.truncate(strLen)
        end
    end
    
    # targetが削除済みか判定
    def is_delete(target)
        if target.deleted_at.nil?
            return false
        else
            return true
        end
    end
    
    #プレイリストが公開されているかどうか
    def is_release_list?(list)
        if list.status == "release"
            return true
        else
            return false
        end
    end
end
