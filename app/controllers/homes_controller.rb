class HomesController < ApplicationController
    def index
        
    end

    def sign_in_user
        user = User.find_by_email(params[:email])
        if user.valid_password?(params[:password])
            sign_in user
            flash[:notice] = "User loggedin sucessfully"
            redirect_to root_path()
        else
            flash[:alert] = "Invalid username or password"
            redirect_to sign_in_form_path()
        end
    end

    def sign_up_user
      @user = User.new(sign_up_params)
      if @user.save
        flash[:notice] = "You have sucessfully signed up"
        redirect_to sign_in_form_path()
      else
        flash[:alert] = "Error saving user"
        respond_to do |format|
           format.html{render "sign_up_form"}  
        end
      end
    end

    def sign_in_form
    
    end

    def sign_up_form
     @user = User.new
    end

    private

    def sign_up_params
       params.require(:user).permit(:full_name,:mobilenumber,:email,:password,:password_confirmation)
    end
end
