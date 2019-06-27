class SubsController < ApplicationController
    def new
        @sub = Sub.new
    end

    def create
        @sub = Sub.new(sub_params)
        @sub.moderator_id = current_user.id
        if sub.save
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :new
        end
    end

    def index
        @subs = Sub.all
    end

    def show
        @sub = Sub.find_by(sub_params)
    end

    def edit
        @sub = current_user.subs.find_by(sub_params)
        if !@sub
            flash[:errors] = ['gtfo']
            logout
        else
            render :edit
        end
    end

    def update
        @sub = current_user.subs.find(params[:id])
        if !@sub
            flash[:errors] = ['gtfo']
            logout
        elsif @sub.update(sub_params)
            redirect_to sub_url(@sub)
        else
            render :edit
        end
    end


    def destroy
        @sub = current_user.subs.find(params[:id])
        if !@sub
            flash[:errors] = ['gtfo']
            logout
        else
            @sub.destroy
            redirect_to subs_url
        end
    end

    private

    def sub_params
        params.require(:sub).permit(:title, :description)
    end
end
