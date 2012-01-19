require 'rubygems'
require 'bundler/setup'

Bundler.require :default

module Server
  class Application < Sinatra::Base

    set :public_folder, File.dirname(__FILE__) + '/public'

    not_found do
      '404 not found'
    end

    get '/' do
      send_file [
        File.dirname(__FILE__),
        :public,
        'index.html'
      ].reject(&:nil?).join '/'
    end

    get '/archives' do
      redirect '/archives/'
    end

    get '/archives/' do
      send_file [
        File.dirname(__FILE__),
        :public,
        :archives,
        'index.html'
      ].reject(&:nil?).join '/'
    end

    get '/:slug/' do
      file = post_path params[:slug]

      File.exist?(file) ? send_file(file) : 404
    end

    get '/:slug' do
      redirect "/#{params[:slug]}/"
    end

    get '/:slug/index.html' do
      redirect "/#{params[:slug]}/"
    end

    get '/:slug/index.htm' do
      redirect "/#{params[:slug]}/"
    end

    get '/categories/:slug/' do
      file = category_path params[:slug]

      File.exist?(file) ? send_file(file) : 404
    end

    get '/categories/:slug' do
      redirect "/categories/#{params[:slug]}/"
    end

    get '/categories/:slug/index.html' do
      redirect "/categories/#{params[:slug]}/"
    end

    get '/categories/:slug/index.htm' do
      redirect "/categories/#{params[:slug]}/"
    end

    ['/page/1', '/page/1/'].each do |path|
      get path do
        redirect '/'
      end
    end

    get '/page/:page/' do
      file = [
        File.dirname(__FILE__),
        :public,
        :page,
        params[:page],
        'index.html'
      ].reject(&:nil?).join '/'

      File.exist?(file) ? send_file(file) : 404
    end

    private
    def category_path slug
      [
        File.dirname(__FILE__),
        :public,
        :categories,
        slug,
        'index.html'
      ].reject(&:nil?).join '/'
    end

    def post_path slug
      [
        File.dirname(__FILE__),
        :public,
        slug,
        'index.html'
      ].reject(&:nil?).join '/'
    end
  end
end

run Server::Application
