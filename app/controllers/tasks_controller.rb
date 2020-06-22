class TasksController < ApplicationController
    before_action :authenticate_user!

    def index
      @board = Board.find(params[:board_id])
      @tasks = @board.tasks.order('id DESC')
      
    end

    def new
      board = Board.find(params[:board_id])
      @task = board.tasks.build
      @task_user_id = current_user.id
    end

    def show
      @board = Board.find(params[:board_id])
      @task = Task.find(params[:id])
      @comments = @task.comments
    end

    def create
      board = Board.find(params[:board_id])
      @task = board.tasks.build(task_params)
      @task_user_id = current_user.id
      if @task.save
          redirect_to board_tasks_path(board), notice: 'タスクを追加しました'
      else
          flash.now[:error] = 'タスクを作成できませんでした'
          render :new
      end
    end

    def edit
      @board = Board.find(params[:board_id])
      @task = Task.find(params[:id])
      @task_user_id = current_user.id
    end

    def update
      @board = Board.find(params[:board_id])
      @task = Task.find(params[:id])
      @task_user_id = current_user.id
      if @task.update(task_params)
        redirect_to root_path, notice: '変更を保存しました'
      else
        flash.now[:error] = '変更が保存できませんでした'
        render :edit
      end
    end

    def destroy
      @board = Board.find(params[:board_id])
      task = Task.find(params[:id])
      task.destroy!
      redirect_to board_tasks_path(@board), notice: '削除に成功しました'
    end

    private 
    def task_params
      params.require(:task).permit(:card_title, :card_content, :user_id, :deadline, :eyecatch)
    end
end