class ApplicationController < ActionController::Base
    # Create a method called current_user in your ApplicationController to make current user data available to all controllers. It will return the first user from the database.
    before_action : current_user
    private
    def current_user
      @current_user ||= User.first
    end
    helper_method :current_user    
end
