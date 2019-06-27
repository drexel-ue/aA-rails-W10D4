class SessionsController < ApplicationController
    def new
        
    end

    def create
        user = User.find_by_credentials(params[:user][:username], params[:user][:password])
        if user
            login(user)
            redirect_to # TODO: 
        else
            flash.now[:errors] = ['you done goofed']
            render new_session_url
        end
    end

    def destroy
        logout
    end
end
