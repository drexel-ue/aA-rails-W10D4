class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            # TODO: send to some index
            login(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def show
        @user = User.find(params[:id])
        render :show
    end

    def destroy
        User.find_by_credentials(user_params).destroy
        redirect_to new_session_url
    end

    private 

    def user_params
        params.require(:user).permit(:username, :password)
    end
end
