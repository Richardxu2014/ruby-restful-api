
require 'json'

# 公共 Controller
class ApplicationController < Sinatra::Application
    set :show_exceptions, :after_handler

    def authenticate!   
      # 验证用户是否有权限
      p request.params
      logger.info "权限验证"
    
    end  

    # 前置方法
    before do
      p request.accept 
      authenticate!
    end


    get '/' do 

      p '------ get / ----'
      { isSuccess: true, message: "操作成功" }.to_json
    end
    
    # 404异常返回 
    not_found do
      { message: "not_found" }
    end

    error do
      p 'Sorry there was a nasty error - ' 
      'Sorry there was a nasty error - ' + env['sinatra.error'].message 
    end

    # 400到510异常返回
    error 400..510 do
      'Boom error - ' + env['sinatra.error'].message
    end
    
end