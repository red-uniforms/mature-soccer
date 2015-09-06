class NoticesController < ApplicationController
  before_action :find_cup

  def show
  	@notice = @cup.notices.find(params[:id])
  end

  def new
  	@notice = @cup.notices.new
  end

  def edit
  	@notice = @cup.notices.find(params[:id])
  end

  def create
  	@notice = @cup.notices.new(notice_params)

  	if @notice.save
    	redirect_to notices_cup_path, :cup_url => @cup.cup_url
    else
    	render 'new'
    end
  end

  def update
  	@notice = @cup.notices.find(params[:id])

  	if @notice.update(notice_params)
  		redirect_to @notice
  	else
  	  render 'edit'
  	end
  end

  def destroy
  	@notice = @cup.notices.find(params[:id])
  	@notice.destroy

  	redirect_to notices_path
  end

private
	def notice_params
 	  params.require(:notice).permit(:title, :text)
 	end

  def find_cup
    if session[:cup_id]
      @cup = Cup.find(session[:cup_id])
    else
      # add flash?
      redirect_to users_path
    end
  end

end