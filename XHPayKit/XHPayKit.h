//
//  XHPayKit.h
//  XHPayKitExample
//
//  Created by zhuxiaohui on 2018/2/23.
//  Copyright © 2018年 it7090.com. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHPayKit

//  版本:1.0.3
//  发布:2018.04.10

//  如果你在使用过程中出现bug,请及时以下面任意一种方式联系我，我会及时修复bug并帮您解决问题。
//  QQ交流群:537476189
//  Email:it7090@163.com
//  新浪微博:朱晓辉Allen
//  GitHub:https://github.com/CoderZhuXH
//  简书:https://www.jianshu.com/u/acf1a1f12e0f
//  掘金:https://juejin.im/user/59b50d3cf265da066d331a06

//  使用说明:https://github.com/CoderZhuXH/XHPayKit/blob/master/README.md

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XHPayWxReq.h"

//注意:
//1.先在微信、支付宝开放平台注册你的应用,并获得支付能力
//2.导入此库,并请将 weixin 、 alipay 字段添加到info.plist白名单
//3.添加自己APP URL Schemes,和微信回调URL Schemes,详见README文档

@interface XHPayKit : NSObject

+(instancetype)defaultManager;

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

/**
 拉起微信支付

 @param req 发起支付的消息模型
 @param completedBlock 结果回调
 */
-(void)wxpayOrder:(XHPayWxReq *)req completed:(void(^)(NSDictionary *resultDict))completedBlock;

/**
 拉起支付宝支付

 @param orderStr 支付签名,此签名由服务器签名订单后生成
 @param schemeStr 本app url scheme
 @param completedBlock 结果回调
 */
-(void)alipayOrder:(NSString *)orderStr fromScheme:(NSString *)schemeStr completed:(void(^)(NSDictionary *resultDict))completedBlock;

/**
 处理第三方支付跳回商户app携带的支付结果Url
 需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用
 @param url 支付结果Url
 @return 成功返回YES，失败返回NO
 */
-(BOOL)handleOpenURL:(NSURL *)url;

@end
