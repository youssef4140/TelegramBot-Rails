require 'telegram/bot'
class TelegramListenJob < ApplicationJob
  # include Sidekiq::Job
  queue_as :default

  def perform(*args)
    if Rails.cache.read('telegram_listen_job_has_run').nil?
      #replace token with your own
      token = '6209842775:AAEYa6OjRdy6C3NJssQR6oa_woxAFVMvnQ4'
      Telegram::Bot::Client.run(token) do |bot|
        bot.listen do |message|
          
          if message.photo.present?
            bot.api.send_message(chat_id: message.chat.id, text: "You sent an image!")
            file_id = message.photo.last.file_id
            user_id = message.from.id
            file = bot.api.get_file(file_id: file_id)
            file_path = file['result']['file_path']
            image_url = "https://api.telegram.org/file/bot#{token}/#{file_path}"
            Message.create(image_url: image_url, first_name: message.from.first_name, user_name: message.from.username, user_id: message.from.id.to_i)
          elsif message.text.present?
            Message.create(text: message.text, first_name: message.from.first_name, user_name: message.from.username, user_id: message.from.id.to_i)
          end
         
        end
      end
      Rails.cache.write('telegram_listen_job_has_run', true)
    end
  end
end

