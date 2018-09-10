require 'sinatra'
require 'json'
require 'user'


def authenticate!   
    # 验证用户是否有权限
  p request.params

  logger.info "权限验证"
end  


class App < Sinatra::Application
  
  before do
    p request.accept 
    authenticate!
  end
  
  get '/' do
    err = false
    # do some thing
    # p User[1].values

    halt 500, '错误信息!' if err  

    User[1].values.to_json
    # {name: "张三", age: 28}.to_json
  end


  post '/api/add' do
    body = eval(request.body.read)
    p body
    # do some thing
    # User.add

    {message: "add success"}.to_json
  end


# curl -l -H "Content-type: application/json" -X POST -d '{"phone":"13521389587","password":"test"}' http://localhost:9293/api/movies/add

end

