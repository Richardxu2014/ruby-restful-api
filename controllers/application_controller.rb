
require 'json'
require 'blank'

# 公共 Controller
class ApplicationController < Sinatra::Application
    set :show_exceptions, :after_handler

    def authenticate!   
      # 验证用户是否有权限
      p request.params
      logger.info "参数为空" if request.params.blank?
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

    # Work queues 工作队列模式发送消息
    # queue_name: 队列名菜
    # message: json类型数据
    def send_queue_message(queue_name, message)
      $rabbit.start
      channel = $rabbit.create_channel
      queue = channel.queue(queue_name, durable:true)
      queue.publish(message, persistent: true)
      logger.info "Sent message: '#{message}' to queue: #{queue_name}"
      $rabbit.close
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