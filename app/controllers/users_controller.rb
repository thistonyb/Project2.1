class UsersController < ApplicationController

    get '/signup' do
      if Helpers.is_signed_in?(session)
        redirect to '/welcome'
      else
        erb :'/users/create_user'
      end
    end
    
    post '/signup' do 
        if !(params.has_value(""))
            user = User.create(params)
            session["user_id"] = user.id
            redirect to '/welcome'
        else
            redirect to '/signup'
        end
    end
    
end