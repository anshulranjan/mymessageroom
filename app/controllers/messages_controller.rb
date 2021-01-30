class MessagesController < ApplicationController
    before_action :require_user
    
    def create
        @message = Message.new(message_params)
        @message.user_id = current_user.id
        @message.chatroom_id = params[:chatroom_id]
        if @message.save
            SendMessageJob.perform_later(@message)
        else
            flash[:alert] = "You cannot send blank message"
            redirect_to chatroom_path(params[:chatroom_id])
        end
    end
    
    private
    
    def message_params
        params.require(:message).permit(:body)
    end
    
    def message_render(message)
        render(partial: 'message', locals:{message: message , sender: true})
    end
    
    
end