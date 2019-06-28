class UsersController < ApplicationController

    get '/signup' do
      if Helpers.is_signed_in?(session)
        redirect to '/rocks'
      else
        erb :'users/create_user'
      end
    end  
    
end