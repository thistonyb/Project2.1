class RocksController < ApplicationController
    get '/rocks' do
        if Helper.is_signed_in(session)
            @rocks = Rock.all
            erb :'/rocks/rocks'
        else
            redirect to '/users/signin'
        end
    end
    



end