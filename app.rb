require 'sinatra'
require 'thin'
require 'csv'
require 'date'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/post.db")

class Post
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :content, Text
  property :created_at, DateTime
end

# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models
DataMapper.finalize # (class로 정의한 것) 데이터 베이스를 테이블 생성으로 마무리한다.
# create_database
# automatically create the post table
Post.auto_upgrade! # post라는 table을 자동으로 upgrade


get '/' do
    erb :index
end

get '/create' do
    @title = params[:title]
    @content = params[:content]
    
    # CSV.open('board.csv', 'a+') do |csv|
    #     csv << [@title, @content, Time.now.to_s]
    # end
    Post.create(        #insert into 역할
        title: @title,
        content: @content
    )
    
    erb :create
end


