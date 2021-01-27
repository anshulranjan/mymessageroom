class ChatroomsController < ApplicationController
    
    before_action :require_user, only: [:new, :edit, :update, :destroy, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    
    def show
      @chatroom = Chatroom.find(params[:id])
      @message = Message.new
      @message.chatroom_id = @chatroom.id
      @messages = @chatroom.messages.custom_display
    end
    
    def index
        @chatroom = Chatroom.order("created_at DESC").paginate(page: params[:page], per_page: 15)
        @users = User.all
    end
  
    def new
        @chatroom = Chatroom.new
    end
    
    def edit
        @chatroom = Chatroom.find(params[:id])
    end
    
    def update
        @chatroom = Chatroom.find(params[:id])
        if @chatroom.update(chatroom_params)
          flash[:notice] = "Your account information was successfully updated"
          redirect_to @chatroom
        else
          render 'edit'
        end
    end
    
    def create
        @chatroom = Chatroom.new(chatroom_params)
        @chatroom.user = current_user
        if @chatroom.save
          flash[:notice] = "The Chatroom #{@chatroom.title} have been created"
          redirect_to @chatroom
        else
          render 'new'
        end
    end
      
    def destroy
        @chatroom = Chatroom.find(params[:id])
        @chatroom.destroy
        flash[:notice] = "Chatroom has been successfully deleted"
        redirect_to root_path
    end
      
      
      
    private
      
    private
      def chatroom_params
        params.require(:chatroom).permit(:title, :user_id)
      end
      
      def require_same_user
        if current_user != Chatroom.find(params[:id]).user && !current_user.admin?
          flash[:alert] = "You can only edit or delete your own chatrooms"
          redirect_to root_path
        end
      end

end
