class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            # TODO: send to some index
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.error.full_messages
            render :new
        end
    end

    def show
        @user = User.new(user_params)
        render :show
    end

    def destroy
        User.find_by_credentials(user_params).destroy
        redirect_to new_session_url
    end

    private 

    def user_params
        params.require(:user).permits(:username, :password)
    end
end
