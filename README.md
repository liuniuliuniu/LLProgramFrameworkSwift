# LLProgramFramework.Swift


## 本项目是一个拿来即用的Swift基础框架：框架结构如下，框架内部已经写了基于RXSwift的Demo 可以参考  具体使用可查看使用详情[RxSwift+Moya+ObjectMapper优雅的网络请求及模型转换](http://www.jianshu.com/p/0248e7104c39)


![LLProgramFramework.gif](https://github.com/liuniuliuniu/LLProgramFramework.Swift/blob/master/LLProgramFrameworkSwift.gif)


#### Update  9/22 Fix iOS 11 and iPhone X
#### Update  9/26 加入 Plugin 插件 拦截全局的网络请求

### 项目结构

* General 工具类综合
	* Category ------分类
	* CostumUI ------自定义UI控件
	* Helper   ------正则 提示框辅助类等
* Resources ------资源文件
* Sections  ------模块组
	* Main   
	* Home
	* Me
* Service ------网络请求库
* Macro  ------pch以及全局变量
* Vendors  ------手动集成第三方库
	* [LLFMDB](https://github.com/liuniuliuniu/LLFMDB)  ------ 个人二次封装的FMDB 一键缓存的数据库

###Cocoapod第三方库

* RxSwift  ------RxSwift 基础库
* RxCocoa  ------ 对 UIKit Foundation 进行 Rx 化
* Moya/RxSwift  ------   为RxSwift专用提供，对Alamofire进行封装的一个网络请求库
* ObjectMapper  ------ Json转模型之必备良品,很Swift
* Kingfisher  ------ 图片加载库 Swift版的SD
* SnapKit  ------  视图约束库
* FMDB  ------  轻量级的数据库
* MJRefresh  ------ 刷新库
* SVProgressHUD  ------ 提示HUD








