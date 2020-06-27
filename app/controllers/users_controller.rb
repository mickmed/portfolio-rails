# frozen_string_literal: true

class UsersController < ApplicationController
  # before_action :set_user, only: %i[show edit update destroy]
  before_action :authorize_request, except: :create
  skip_before_action :verify_authenticity_token

  def index
    @users = User.all
    render json: {users:@users}
  end

 
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  def create
    
      @user = User.new(user_params)
    
      if @user.save
        @token = encode({user_id: @user.id, username: @user.username});
        puts 'token', @token
        render json: {user: @user, token: @token}, status: :created
        # render json: {user:@user}
      else
        render json: @user.errors, status: :unprocessable_entity
      end
   
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end


end
