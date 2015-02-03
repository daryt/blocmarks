class IncomingController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    # Take a look at these in your server logs
    # to get a sense of what you're dealing with.
    # puts "INCOMING PARAMS HERE: #{params}"

    # You put the message-splitting and business
    # magic here. 

    # Assuming all went well. 

    tags = params['Subject'].split(',')
    data = params['stripped-text'].split(",").map(&:strip)
    email = params['from'].strip
   
    if User.find_by(:email => email)
      @bookmark = Bookmark.new({name: data[0], url: data[1]})
      @bookmark.user = User.find_by(:email => email)
      @bookmark.topic_list.add(tags)
      @bookmark.save

      head 200
    end
      head 200
  end
end