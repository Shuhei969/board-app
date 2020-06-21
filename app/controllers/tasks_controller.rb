class TasksController < ApplicationController
    before_action :authenticate_user!

    def index
      @board = Board.find(params[:board_id])
      @tasks = @board.tasks
      
    end

    def new
      board = Board.find(params[:board_id])
      @task = board.tasks.build
      @user_id = current_user.id
    end

    def show
      @board = Board.find(params[:board_id])
      @task = Task.find(params[:id])
      @comments = @task.comments
    end

    def create
      board = Board.find(params[:board_id])
      @task = board.tasks.build(task_params)
      if @task.save
          redirect_to board_tasks_path(board), notice: 'タスクを追加しました'
      else
          flash.now[:error] = 'タスクを作成できませんでした'
          render :new
      end
    end

    private 
    def task_params
      params.require(:task).permit(:card_title, :card_content, :user_id, :deadline, :eyecatch)
    end
end