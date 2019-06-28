class RocksController < ApplicationController
    
    get '/rocks/all' do
        user = Helpers.current_user(session)
        if user.nil?
            redirect to '/signin'    
        else
            @rocks = Rock.all
            erb :'/rocks/all_rocks'
        end
    end

    get '/rocks/new' do
        user = Helpers.current_user(session)
        if user.nil?
            redirect to '/signin'
        else
            erb :'/rocks/create_rock'
        end
    end

    post '/rocks/new' do
        user = Helpers.current_user(session)
        if user.nil?
            redirect to '/signin'
        elsif params[:rock][:name].empty? || params[:rock][:description].empty? || params[:rock][:location].empty?
            redirect to '/rocks/new'
        else
            user.rocks.new({name: params[:rock][:name], description: params[:rock][:description], location: params[:rock][:location]})
            user.save
        end
        redirect to '/rocks/show'
    end

    get '/rocks/show' do

    end


    



end