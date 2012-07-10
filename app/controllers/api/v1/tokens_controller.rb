class Api::V1::TokensController < ApplicationController
  skip_before_filter :verify_authenticity_token

  respond_to :json

  def create
    email = params[:email]
    password = params[:password]
    if request.format != :json
      render :status => 406, :json => { :error => "The request must be json" }
      return
    end

    if email.nil? || password.nil?
      render :status => 400, :json => { :error => "The request must contain credentials" }
      return
    end

    @user = User.find_by(:email => email.downcase)

    if @user.nil?
      logger.info "User #{email} failed signin, user cannot be found"
      render :status => 401, :json => { :error => "Access Denied" }
      return
    end

    @user.ensure_authentication_token!

    if !@user.valid_password?(password)
      logger.info "User #{email} failed signin, password '#{password}' invalid"
      render :status => 401, :json => { :error => "Access Denied" }
      return
    else
      render :status => 200, :json => { :token => @user.authentication_token }
    end
  end

  def destroy
    @user = User.find_by(:authentication_token => params[:id])
    if @user.nil?
      logger.info "Token '#{params[:id]}' not found"
      render :status => 404, :json => { :error => "Invalid token" }
      return
    else
      @user.reset_authentication_token!
      render :status => 200, :json => { :token => params[:id] }
    end
  end
end
