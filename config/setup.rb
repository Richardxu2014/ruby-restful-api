require 'bundler/setup'

model_path = File.expand_path '../../models', __FILE__
controller_path = File.expand_path '../../controllers', __FILE__
$LOAD_PATH.unshift(model_path,controller_path)

ENVIRONMENT = ENV["RACK_ENV"] || 'development'
p ENVIRONMENT

require 'settingslogic'
class Settings < Settingslogic
    source File.expand_path('../application.yml', __FILE__)
    namespace ENVIRONMENT
end    

require 'sequel'
require 'mysql2'
require 'redis'
require 'logger'

DB = Sequel.connect(
  adapter: :mysql2, 
  host: Settings.mysql.host, 
  port: Settings.mysql.port,
  user: Settings.mysql.user, 
  password: Settings.mysql.password, 
  database: Settings.mysql.database, 
  max_connections: 10, 
  logger: Logger.new('logs/db.log', 'daily'),  # 数据库访问日志
  encoding: 'utf8', 
)

$redis = Redis.new(
	host: Settings.redis.host, 
	port: Settings.redis.port, 
	auth_pass: Settings.redis.auth_pass, 
)

$rabbit = Bunny.new(
  host: Settings.rubbitMQ.host, 
  vhost: Settings.rubbitMQ.vhost, 
  user: Settings.rubbitMQ.user,  
  password: Settings.rubbitMQ.password, 
  automatically_recover: false
)

$logger = Logger.new('logs/service.log', 'daily') # 微服务日志
$logger.level = Logger::DEBUG
$logger.datetime_format = '%Y-%m-%d %H:%M:%S'
$logger.info("ENV= #{ENVIRONMENT} server start .....")