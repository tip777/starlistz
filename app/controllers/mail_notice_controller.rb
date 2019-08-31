class MailNoticeController < ApplicationController

    def index
        if current_user.nil?
          redirect_to new_user_session_path
          
        else
          @user = current_user
          user_mailNotice = @user.mail_notice
          if user_mailNotice.nil?
            @user.create_mail_notice
            @mail_notice = @user.mail_notice
          else
            @mail_notice = user_mailNotice
          end
          
        end
        
      end
      
      def update
        reject_pageh if current_user.nil?
        
        @mail_notice = current_user.mail_notice
        
        if @mail_notice.update(mailnotice_params)
            redirect_to users_playlist_path(current_user), notice: "メール通知を変更しました"
        else
          render 'index'
        end
    
      end
      
      private
    
      def mailnotice_params
        params.require(:mail_notice).permit(:news_letter, :list_sold)
      end
    
end
