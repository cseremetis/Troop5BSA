#created February 4, 2015 by Christian Seremetis

require 'bundler'
Bundler.require 

require_relative './models/caption.rb'
require_relative './models/page.rb'

set :database, "sqlite3:page.db"
class App < Sinatra::Base

    #used when objects are to be deleted
    #finds the unwanted object by searching through the database
    #and looking for a match
    def find(caption)
        @every = Page.all

        #iterates through all tables in the database
        #to find the one with the given title value
        @every.each do |a|
            if a.title.downcase == caption.downcase.strip
                @mutableCaption = Page.where(:title => caption).take
            end
        end
    end

    get '/' do
        erb(:index)
    end

    get '/faqs' do
        @allFAQs = []
        @allFAQs = Page.where(:form_id => "FAQs")
        erb(:faqs)
    end

    get '/admin33034112AZY774NNOO0' do
        #administrative page
        #used to add new forms to the website
        erb(:admin)
    end

    get '/superSecret' do
        erb(:superSecret)
    end

    get '/UpcomingTrips' do
        #makes an array of all upcoming trips to be shown on form
        @allTrips = []
        @allTrips = Page.where(:form_id => "Upcoming Trips")
        erb(:UpcomingTrips)
    end

    get '/master33034112AZY774NNOO0' do
        #administrative page
        #used to iterate through and delete web forms
        @every = []
        @every = Page.all
        erb(:master)
    end

    post '/addPage' do

        #for administrative purposes
        #used to add new pages to the website
        @newCaption = Page.new
        @newCaption.title = params[:title].strip
        @newCaption.form_id = params[:form_id]
        @newCaption.notification = params[:description]
        @newCaption.save

        redirect('/master33034112AZY774NNOO0')
    end

    post '/delete' do
        #searches the database for the unwanted caption
        find(params[:title])

        #deletes caption
        Page.delete(@mutableCaption)

        redirect('/master33034112AZY774NNOO0')
    end

    post '/edit' do

        #find given form title
        find(params[:title])

        $changedCaption = @mutableCaption

        erb(:edit) 
    end

    post '/change' do

        #updates existing caption
        $changedCaption.title = params[:title]
        $changedCaption.notification = params[:caption]
        $changedCaption.save 

        redirect('/master33034112AZY774NNOO0')
    end

end





