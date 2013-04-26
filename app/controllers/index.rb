get '/' do
  @valid_user = true
  erb :index
end

get '/signup' do
  erb :signup #take them to their user page
end

post '/signup' do
  puts "saving new profile...."
  @user = User.new(params)
  @user.save if @user.errors.full_messages.length == 0
  @valid_user = true
  session[:user_id] = @user.id
  erb :index
end


post '/logout' do
  puts "cleared"
  session.clear
  erb :index
end

post '/login' do
  @user = User.authenticate(params[:username], params[:password])
  if @user
    puts "Logging in."
    session[:user_id] = @user.id
    erb :user_home
  else
    @valid_user = false
    erb :index
  end
end

get '/users/:user_id/posts' do
  @user_id = params[:user_id]
  @user = User.find(@user_id)
  puts @user
  erb :user_public
end

get '/posts/:post_id' do
  @post_id = params[:post_id]
  @post = Post.find(@post_id)
  erb :post
end

get '/submit_post' do
  puts "working"
  erb :submit_post
end

post '/submit_post' do
  puts "submitting post..."
  tags_array = params[:tags].split(", ")
  tags_array.each do |tag|
    Tag.create(name: tag)
  end
  @new_post = Post.create(:title => params[:title], :content => params[:content], :user_id => session[:user_id])
  tags_array.each do |tag|
    @new_post.tags << Tag.where("name = ?", tag).first
  end
  @user = User.find(session[:user_id])
  erb :user_home
end
