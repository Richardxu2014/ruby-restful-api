
require 'application_controller'
require 'user'

# 前缀  /example
class ExampleController < ApplicationController
    helpers ExampleHelper

    # 完整的 url 是  /example/all
    get '/all' do 
        p '------ get /example/all ----'
        # User[1].values.to_json
        p getUser(1)  # helpe 中的方法

        { isSuccess: true, message: "操作成功" }.to_json
    end

    # 完整的 url 是  /example/add
    post '/add' do
        p '======== post /example/add ==================='
        body = eval(request.body.read)
        p body
        p body[:phone]

        send_queue_message('add_queue', body)
        {message: "add success"}.to_json
    end
end