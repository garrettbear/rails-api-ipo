class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]


  def findUser
    @email = params[:email]
    @email_string = @email.to_str
    @user = User.find_by_email(@email_string)
    puts @email.to_str == "jesser360@gmail.com"
    puts @email.to_str
    puts type(@email)
    puts type(@email_string)
    puts "USER"
    puts @user
    if @user
      puts "USER EXISTS"
      render json: @user
    else
      puts "NO USER"
      render :nothing => true, :status => 204
    end
  end
  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.fetch(:user,{}).permit(:name, :user_permissions, :email, :password_digest,:group_id)
    end
end
