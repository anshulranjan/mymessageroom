class MessagesController < ApplicationController
    before_action :require_user
    
    def create
        @message = Message.new(message_params)
        @message.user_id = current_user.id
        @message.chatroom_id = params[:chatroom_id]
        if @message.save
            redirect_to chatroom_path(params[:chatroom_id])
        else
            redirect_to root_path
        end
    end
    
    private
    
    def message_params
        params.require(:message).permit(:body)
    end
end