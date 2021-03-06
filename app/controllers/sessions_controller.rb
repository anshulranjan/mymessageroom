class SessionsController < ApplicationController
    
    def new
        if logged_in?
            flash[:alert] = "Please Logout to Login again"
            redirect_to current_user
        end
    
    end

    def create
        user = User.find_by(username: params[:session][:username].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            if(user.status == false)
                user.toggle!(:status)
            end
            flash[:notice] = "Logged in successfully"
            redirect_to user
        else
            flash.now[:alert] = "There was something wrong with your login details"
            render 'new'
        end
    end

    def destroy
        if(current_user.status == true)
            current_user.toggle!(:status)
        end
        session[:user_id] = nil
        flash[:notice] = "Logged out"
        redirect_to root_path
    end
  
end