class PostsController < ApplicationController
     def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        @post.moderator_id = current_user.id
        if post.save
            redirect_to post_url(@post)
        else
            flash.now[:errors] = @post.errors.full_messages
            render :new
        end
    end

    def show
        @post = Post.find_by(post_params)
    end

    def edit
        @post = current_user.posts.find_by(post_params)
        if !@post
            flash[:errors] = ['gtfo']
            logout
        else
            render :edit
        end
    end

    def update
        @post = current_user.posts.find(params[:id])
        if !@post
            flash[:errors] = ['gtfo']
            logout
        elsif @post.update(post_params)
            redirect_to post_url(@post)
        else
            render :edit
        end
    end


    def destroy
        @post = current_user.posts.find(params[:id])
        if !@post
            flash[:errors] = ['gtfo']
            logout
        else
            @post.destroy
            redirect_to posts_url
        end
    end

    private

    def post_params
        params.require(:post).permit(:title, :description)
    end
end
