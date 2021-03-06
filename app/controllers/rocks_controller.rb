class RocksController < ApplicationController
    
    get '/rocks/index' do
        user = Helpers.current_user(session)
        if user.nil?
            redirect to '/signin'    
        else
            @rocks = Rock.all
            erb :'/rocks/index'
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
        user = Helpers.current_user(session)
        if user.nil?
            redirect to '/signin'
        else
            @rocks = user.rocks.all
            erb :'/rocks/show_rocks'
        end
    end

    get '/rocks/:id' do
        if Helpers.is_signed_in?(session)
            @rock = Rock.find_by_id(params[:id])
            erb :'/rocks/edit_or_delete'
        else
            redirect to '/signin'
        end
    end

    get '/rocks/:id/edit' do
        if !Helpers.is_signed_in?(session)
            redirect to '/signin'
        end
        @rock = Rock.find_by_id(params[:id])
        if @rock.user == Helpers.current_user(session)
            erb :'/rocks/edit_rock'
        else
            redirect to '/signin'
        end
    end

    patch '/rocks/:id' do
        if !Helpers.is_signed_in?(session)
            redirect to '/signin'
        end
        @rock = Rock.find_by_id(params[:id])
        if params[:rock][:name].empty? || params[:rock][:description].empty? || params[:rock][:location].empty?
            redirect to "/rocks/#{@rock.id}/edit"
        end
        @rock.update(params[:rock])
        @rock.save
        redirect to '/rocks/show'
    end

    delete '/rocks/:id/delete' do
        if !Helpers.is_signed_in?(session)
            redirect to '/signin'
        end
        @rock = Rock.find_by_id(params[:id])
        if @rock.user == Helpers.current_user(session)
            @rock.delete
            redirect to '/rocks/show'
        end
    end
end