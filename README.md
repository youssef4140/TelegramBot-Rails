# README

* The project uses Ruby 3.0.2 and Rails 7.0.4.3

* The project uses the following gems 

  -telegram-bot-ruby: A Ruby wrapper for Telegram's Bot API.
  -sidekiq: A background job processing library.

* Docker:

  To run the project using Docker, follow these steps:

   -Install Docker and Docker Compose on your machine.
   -Clone the repository to your local machine.
   -Navigate to the root directory of the project.
   -Start the Docker container by running the following command: docker-compose up.
   -Open your web browser and go to http://localhost:3000 to access the chat application.

* Note: You need to create a Telegram bot and obtain a token to use the Telegram API in the application.
  Replace the token in ChatPageController and telegram_listen_job.rb with your own token. 

* Summary:

This is a Ruby on Rails chat application that integrates with Telegram API. It allows users to send text messages and images to each other, and the messages are stored in the database. The application also listens to incoming messages from Telegram and saves them in the database.

* Main components of the project: 
-ChatPageController: This controller handles the main functionality of the application. It has four methods: by_user, index,    image_present, and send_message. The by_user method retrieves all messages from the database and groups them by user_id to display the chat history with the selected user.The index method retrieves all messages from the database and renders the main page of the application. The image_present method sends and saves the URL of an image sent by the user through Telegram. The send_message method sends a message (text or image) to a user through Telegram.

-index.html.erb: This is the main view of the application. It displays a list of users that have sent messages and allows the user to select a user to chat with. It also displays the chat history with the selected user and allows the user to send messages (text or image) to the selected user.

-by_user.html.erb: This view displays the chat history with the selected user and allows the user to send messages (text or image) to the selected user.

-telegram_listen_job.rb: This job listens to incoming messages from Telegram and saves them in the database.

# TelegramBot-Rails
