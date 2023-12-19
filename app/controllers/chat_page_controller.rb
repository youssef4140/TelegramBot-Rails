require 'telegram/bot'
class ChatPageController < ApplicationController
    def index 
        @messages = Message.all
        TelegramListenJob.perform_later
    end

    #send and save image URL
    def image_present
        #replace token with your own
        token = '6209842775:AAEYa6OjRdy6C3NJssQR6oa_woxAFVMvnQ4'
        client = Telegram::Bot::Client.new(token)  
        image = params[:image]
        user_id = params[:user_id]
        content_type = image.content_type
        response = client.api.send_photo(chat_id: user_id, photo: Faraday::UploadIO.new(image.path, content_type)) 
        file_id = response['result']['photo'].last['file_id']
        file = client.api.get_file(file_id: file_id)
        file_path = file['result']['file_path']
        image_url = "https://api.telegram.org/file/bot#{token}/#{file_path}"
        Message.create(image_url: image_url, first_name: 'bot', user_name: 'botson', user_id: user_id)
        redirect_to by_user_path(user_id: user_id)
    end

    #send message (text or image)
    def send_message
        #replace token with your own
        token = '6209842775:AAEYa6OjRdy6C3NJssQR6oa_woxAFVMvnQ4'
        message_text = params[:message_text]
        user_id = params[:user_id]
        image = params[:image]
        client = Telegram::Bot::Client.new(token)  
        if message_text.present?
            if image.present?
                image_present
            end
            client.api.send_message(chat_id: user_id, text: message_text)
            message = Message.create(text: message_text, user_id: user_id, first_name: 'bot', user_name: 'botson')
            redirect_to by_user_path(user_id: user_id)  
        elsif image.present? 
            image_present
        end
    end
    
    def by_user
        @messages = Message.all
        @user_id = @messages.group_by( &:user_id)
    end

end
