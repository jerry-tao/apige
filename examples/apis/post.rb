Apige.run do
  post = {:id => "bfed8b96-87a0-429d-ac4c-47f2b281b047",
          :title => "My First Post",
          :image => "http://image.example.com/example.jpg",
          :author => "Jerry Tao",
          :pub_date => "2017-4-1",
          :summary => "This is my first post."}

  post_simple = {"id": "6d78672f-85a3-44b9-a110-2356754a49c1", "title": "My First Post", "summary": "This is my first post."}
  comment = {content:"Good for you.", date:"2017-4-2"}

  ## Api scope
  get '/' do
    title 'Service Info'
    desc 'This is service description api.'
    # All return value will generate json default. Custom it in templates.
    {version: '1.0', doc: 'http://doc.example.com', home: 'http://home.example.com', icon: 'http://icon.example.com'}
  end

  ## Group Scope
  group 'Helper Api' do
    desc 'This is some helper api'
    meta responser: 'Jerry' # Meta is used for custom info, available in api, group and resources scope.
    get '/status' do
      title 'Service Status'
      desc 'This is service status api.'
      {status: 'OK'}
    end
  end

  ## Resources Scope
  resources 'Post' do
    desc 'Used for resources post'
    get '/posts' do
      desc ''
      params :page
      [post_simple]
    end

    get '/posts/:id' do
      required :id
      post
    end

    post '/posts' do
      params :title, :content, :image, :author, :pub_date, :summary # Params could include required or not, doesn't matter.
      required :title, :content
      post
    end
    put '/posts/:id' do
      params :title, :content, :image, :author, :pub_date, :summary
      required :id
      post
    end

    delete '/posts/:id' do
      required :id
      post
    end
  end

  ## Put it together
  group 'Post related api' do
    resources 'Comment' do
      get '/posts/:post_id/comments' do
        required :post_id
        [comment]
      end
    end
  end
end
