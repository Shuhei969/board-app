class CommentsController < ApplicationController
    def new
      task = Task.find(params[:task_id])
      @comment = task.comments.build
      @user_id = current_user.id
    end

    def create
      task = Task.find(params[:task_id])
      @user_id = current_user.id
      @comment = task.comments.build(comment_params)
      if @comment.save
        redirect_to board_task_path(task.board_id,task), notice: 'コメントを追加'
      else
        flash.now[:error] = '更新できませんでした'
        render :new
      end
    end

    private
    def comment_params
        params.require(:comment).permit(:content, :user_id)
    end
end