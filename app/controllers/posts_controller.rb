class PostsController < ApplicationController

	before_action :set_post, only: [:edit, :update, :destroy]

    def create
    	@post = current_user.posts.new(post_params)
    	if @post.save
            @post.create_activity key: 'post.created', owner: @post.user
    	    respond_to do |format|
                format.html {redirect_to user_path(@post.user.username), notice: "Postado"}
    	    end
    	else
    		 redirect_to user_path(@post.user.username), notice: "Erro ao criar o post." 
    	end
    end

    def edit
    end

    def update
        if @post.update(post_params)
            respond_to do |format|
               format.html {redirect_to user_path(@post.user.username), notice: "Post atualizado"}
            end
        else
             redirect_to post_path(@post), notice: "Error ao atualizar o post"
        end
    end

    def destroy
        @post.destroy
        respond_to do |format|
           format.html {redirect_to user_path(@post.user.username), notice: "Post excluído com sucesso."} 
        end
    end

    private

    def set_post
    	@post = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:content)
    end
end