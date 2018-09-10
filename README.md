# Ruby-RESTful-API

## 基于 sinatra 的简单 ruby restful api

用到以下第三方组件：
* sinatra   [使用手册](http://sinatrarb.com/intro-zh.html)

* sequel：  数据库ORM框架 [使用手册](http://sequel.jeremyevans.net/rdoc/files/README_rdoc.html) 

* mysql2

* redis 

## 目录结构

```
├── config
│   ├── application.yml # 各种配置数据
│   └── setup.rb        # 初始化程序
├── config.ru           # 启动脚本
├── Gemfile
├── Gemfile.lock
├── logs                # 日志文件夹 
│   ├── db.log
│   └── service.log
├── main.rb            # 路由已经业务逻辑
├── models
│   └── user.rb        # 模型文件夹（数据库表对应模型）
└── README.md
```

## 启动说明

``` shell
$ bundle install

# * 启动命令 
# -p ：指定端口
# -w : 指定启动线程数
# -e : 运行环境（默认development）production test
# -d ：守护进程模式   

$ puma -p 9293  -w 4 -e test -d

```


