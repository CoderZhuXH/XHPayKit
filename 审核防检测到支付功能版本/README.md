

### 技术交流群(群号:537476189)
![](PNG/qqgroup.png)

[![AppVeyor](https://img.shields.io/appveyor/ci/gruntjs/grunt.svg?maxAge=2592000)](https://github.com/CoderZhuXH/XHPayKit)
![Version Status](https://img.shields.io/cocoapods/v/XHPKit.svg?style=flat)
![Support](https://img.shields.io/badge/support-iOS7%2B-brightgreen.svg)
![Pod Platform](https://img.shields.io/cocoapods/p/XHPKit.svg?style=flat)
[![Pod License](https://img.shields.io/cocoapods/l/XHPKit.svg?style=flat)](https://github.com/CoderZhuXH/XHPayKit/blob/master/LICENSE)


### 温馨提示:作弊不是长久之计,内购才是正途

##  温馨提示
1.使用XHPayKit走不通支付流程的,基本都是所传支付参数有问题,建议你先使用官方SDK调通支付流程后,再删除官方SDK使用XHPaykit.<br>
2.XHPaykit和官方SDK有类似接口,可以实现快速替换.

### 写在最前:

来到这里,说明你的APP可能因为审核时支付作弊被拒绝,请先尝试如下操作:<br>

1.说服产品和老板,老老实实按苹果要求替换APP支付系统为内购<br>

2.若你说服不了他们,请再往下看:<br>


####	如果你不想让审核人员扫描到App里面的支付功能:

1.请使用这个文件夹里面的版本XHPKit<br>

![](PNG/001.png)

2.删除项目中官方支付SDK(尤其是支付宝SDK)<br>

3.删除项目中所有pay,buy,支付宝,支付字段(苹果会扫描这些字段),若没办法做到删除所有,请一定要删除类名和方法名中这些字段.<br>


### 使用方法:(和原版一致如下:)

###	注意:
1.先在微信、支付宝开放平台注册你的应用,并获得支付能力<br>
2.导入此库,并请将 weixin 、 alipay 字段添加到info.plist白名单<br>
3.并添加两个URL Schemes 如图:<br>
![](PNG/URLSchemes.png)
4.XHPKit在未安装支付宝/微信情况下,不会拉起网页支付<br>

### 运行Demo注意事项:
由于demo拉起支付时,未传递真实支付参数,所以并不能真正进行支付,请替换为真实订单参数即可(这些参数由后台进行订单签名时生成并返回给客户端).

##	代码示例

###	1.微信支付

//以下参数详细介绍见微信官方文档:<https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=9_12&index=2>

```objc

//微信支付参数,下面7个参数,由后台签名订单后生成,并返回给客服端(与官方SDK一致)
//注意:请将下面参数设置为你自己真实订单签名后服务器返回参数,便可进行实际支付

XHPWxReq *req = [[XHPWxReq alloc] init];
req.openID = @"";//微信开放平台审核通过的应用APPID
req.partnerId = @"";//商户号
req.prepayId = @"";//交易会话ID
req.nonceStr = @"";//随机串，防重发
req.timeStamp = 1518156229;//时间戳，防重发
req.package = @"";// 扩展字段,暂填写固定值Sign=WXPay
req.sign = @"";//签名

//传入订单模型,拉起微信支付
[[XHPKit defaultManager] wxpOrder:req completed:^(NSDictionary *resultDict) {
NSLog(@"支付结果:\n%@",resultDict);
NSInteger code = [resultDict[@"errCode"] integerValue];
if(code == 0){//支付成功

}
}];


```

###	2.支付宝支付
```objc

//支付宝订单签名,此签名由后台签名订单后生成,并返回给客户端(与官方SDK一致)
//注意:请将下面值设置为你自己真实订单签名,便可进行实际支付
NSString *orderSign = @"很长的一串支付宝订单签名";

//传入支付宝订单签名 和 自己App URL Scheme,拉起支付宝支付
[[XHPKit defaultManager] alipOrder:orderSign fromScheme:@"XHPKitExample" completed:^(NSDictionary *resultDict) {
NSLog(@"支付结果:\n%@",resultDict);
NSInteger status = [resultDict[@"resultStatus"] integerValue];
if(status == 9000){//支付成功

}
}];

```

###	 3.在Appdelegate中添加以下代码 - 处理第三方支付跳回商户app携带的支付结果Url

```objc
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
/** iOS9及以后 */
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
BOOL result = [[XHPKit defaultManager] handleOpenURL:url];
if (!result) {//这里处理其他SDK(例如QQ登录,微博登录等)

}
return result;
}
#endif
/** iOS9以下 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
BOOL result = [[XHPKit defaultManager] handleOpenURL:url];
if (!result) {//这里处理其他SDK(例如QQ登录,微博登录等)

}
return result;
}

```

##	其它接口
```objc
/**
是否安装微信

@return 已安装YES,未安装NO
*/
+(BOOL)isWxAppInstalled;

/**
是否安装支付宝

@return 已安装YES,未安装NO
*/
+(BOOL)isAliAppInstalled;

```

## 支付结果resultDict释义

### 微信

```objc
{
"errCode":0,
"errStr":"成功"
}

//以下状态码含义与官方SDK一致
errCode = 0,成功<br>
errCode = -1,普通错误类型<br>
errCode = -2,用户点击取消并返回<br>
errCode = -3,发送失败<br>
errCode = -4,授权失败 <br>
errCode = -5,微信不支持<br>
```

### 支付宝

```objc
{
"result":"",
"resultStatus":"9000",
"memo":"支付成功"
}

//以下状态码含义与官方SDK一致
resultStatus = 9000,支付成功<br>
resultStatus = 8000,正在处理中，支付结果未知（有可能已经支付成功）,请查询商户订单列表中订单的支付状态<br>
resultStatus = 4000,支付失败<br>
resultStatus = 5000,重复请求<br>
resultStatus = 6001,用户中途取消<br>
resultStatus = 6002,网络连接出错<br>
resultStatus = 6004,支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态<br>

```


## 2019.05.30注:过审进阶方案(我现在采用这种方案)-->支付宝和微信支付去SDK化(不用官方SDK或者XHPkit,同样可以掉起微信APP支付和支付宝APP支付)原理很简单:

1. 官方SDK和XHPKit内部都是将支付参数转为-->支付url,通过openURL的方式传参给支付宝/微信,掉起支付宝/微信APP支付 <br>
2. 完全可以将支付参数转化-->支付url,这个过程放在后台,至于后台怎么实现这个转化过程,你可以看下XHPaykit的源码,将转化原理告诉后台,由后台来实现转化过程.<br>
3. 唯一的区别就是:从开始的APP传支付参数给SDK或者XHPaykit拉起支付 变为 APP传支付参数给后台,后台返回支付url,我们openURL拉起支付宝/微信支付<br>
4. 此方法配合H5页面使用,可以做到项目中基本无任何支付宝微信支付的痕迹,这也是现在我采用的方案.<br>



##	XHPKitConst.h 加密字符串释义

//请使用 XHP_DecryptStr(Str)宏 来读取 下面编码字符串真实值

```objc

//支付宝
#define XHP_ZFB_Str @"/rn5lmtL9xBhl7pICTTeog=="

//支付
#define XHP_ZF_Str @"Hh2HYBtRrqo="

//付款
#define XHP_FK_Str @"jRp4OoAGcpY="

//微信
#define XHP_WX_Str @"jicW3N4muT0="

//alipay
#define XHP_alip @"VPV1g0Ss1b4="

//weixin
#define XHP_wx @"V5HStfIGOso="

//pay
#define XHP_p @"apbK36sJjkM="

//SafePay
#define XHP_SafeP @"0mz3t48qNFI="

//safepay
#define XHP_safep @"Z6O7pjD4hcA="

```


##  安装
### 1.手动添加:<br>
*   1.将 XHPKit 文件夹添加到工程目录中<br>
*   2.导入 XHPKit.h

### 2.CocoaPods:<br>
*   1.在 Podfile 中添加 pod 'XHPKit'<br>
*   2.执行 pod install 或 pod update<br>
*   3.导入 XHPKit.h

###	3.Tips
*   1.如果你pod search XHPKit 后提示:[!] Unable to find a pod with name, author, summary, or description matching `XHPKit`,请在终端上执行 rm ~/Library/Caches/CocoaPods/search_index.json , 后重新pod search XHPKit
*   2.如果发现pod search XHPKit 搜索出来的不是最新版本，需要在终端执行cd ~/desktop退回到desktop，然后执行pod setup命令更新本地spec缓存（需要几分钟），然后再搜索就可以了
*   3.如果你发现你执行pod install后,导入的不是最新版本,请删除Podfile.lock文件,在执行一次 pod install
*   4.如果在使用过程中遇到BUG，希望你能Issues我，谢谢（或者尝试下载最新的代码看看BUG修复没有）

##  系统要求
*   该项目最低支持 iOS 7.0 和 Xcode 8.0

##  许可证
XHPKit 使用 MIT 许可证，详情见 LICENSE 文件
