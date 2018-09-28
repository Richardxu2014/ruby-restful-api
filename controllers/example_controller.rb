
require 'application_controller'
require 'user'

# 前缀  /example
class ExampleController < ApplicationController
    # 完整的 url 是  /example/all
    get '/all' do 
        p '------ get /example/all ----'
        User[1].values.to_json
        
        { isSuccess: true, message: "操作成功"}.to_json
        
    end

    # 完整的 url 是  /example/add
    post '/add' do
        p '======== post /example/add ==================='
        body = eval(request.body.read)
        p body
         p body[:phone]
        {message: "add success"}.to_json
    end
end