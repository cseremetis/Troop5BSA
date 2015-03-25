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
            if a.title == caption.strip
                $mutableCaption = Page.where(:title => caption).take
            end
        end
    end

    #home page
    get '/' do
        erb(:index)
    end

    #FAQs page
    get '/faqs' do
        @allFAQs = []
        @allFAQs = Page.where(:form_id => "FAQs")
        erb(:faqs)
    end

    #admin page used to add forms
    get '/admin33034112AZY774NNOO0' do
        #administrative page
        #used to add new forms to the website
        erb(:admin)
    end

    #super secret page 
    get '/superSecret' do
        system("say 'welcome to the super secret page'")
        erb(:superSecret)
    end

    #upcoming trips page
    get '/UpcomingTrips' do
        #makes an array of all upcoming trips to be shown on form
        @allTrips = []
        @allTrips = Page.where(:form_id => "Upcoming Trips")
        erb(:UpcomingTrips)
    end

    #master controller page
    get '/master33034112AZY774NNOO0' do
        #administrative page
        #used to iterate through and delete web forms
        @every = []
        @every = Page.all
        erb(:master)
    end

    #used to add a new caption
    #information is given in admin.erb
    post '/addPage' do

        #for administrative purposes
        #used to add new pages to the website
        @newCaption = Page.new
        @newCaption.title = params[:title].strip.upcase
        @newCaption.form_id = params[:form_id]
        @newCaption.notification = params[:description]
        @newCaption.pic = params[:pic]
        @newCaption.save

        redirect('/master33034112AZY774NNOO0')
    end

    #used to delete an existing caption
    #information is given in the search bar on master.erb
    post '/delete' do
        #searches the database for the unwanted caption
        find(params[:title].upcase)

        #deletes caption
        Page.delete($mutableCaption)

        redirect('/master33034112AZY774NNOO0')
    end

    #used to find information to pull onto edit.erb
    #information is given in the search bar on master.erb
    post '/edit' do

        #find given form title
        find(params[:title].upcase)

        erb(:edit) 
    end

    #used to edit an existing caption
    post '/change' do

        #updates existing caption
        $mutableCaption.title = params[:title].strip
        $mutableCaption.notification = params[:caption]
        $mutableCaption.pic = params[:pic]
        $mutableCaption.save 

        redirect('/master33034112AZY774NNOO0')
    end

    #when a user searches for a specific caption
    post '/search' do
        if params[:captionTitle].downcase.strip == "open sesame"
            redirect('/superSecret')
        elsif params[:captionTitle].downcase.strip == "faqs"
            redirect('/faqs')
        elsif params[:captionTitle].downcase.strip =="upcoming trips"
            redirect('/UpcomingTrips')
        else            
            find(params[:captionTitle].upcase.strip)
            erb(:searchCaption)
        end
    end
end




