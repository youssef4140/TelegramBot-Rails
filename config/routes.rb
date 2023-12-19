Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post '/send_message', to: 'chat_page#send_message', as: 'send_message'
  root "chat_page#index"
  get 'chat_page/index'
  get 'chat_page/by_user', to: 'chat_page#by_user', as: 'by_user'
  
end
