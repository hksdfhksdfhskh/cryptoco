class ApplicationController < ActionController::Base
  layout :layout

  private

    def layout
      if devise_controller?
        'devise'
      else
        'application'
      end
    end

end
