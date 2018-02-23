//
//  XHPayKit.h
//  XHPayKitExample
//
//  Created by zhuxiaohui on 2018/2/23.
//  Copyright © 2018年 it7090.com. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHPayKit

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//注意:
//使用前请将 weixin 、 alipay 字段添加到info.plist白名单

@interface XHPayKit : NSObject

+(instancetype)defaultManager;

/**
 是否安装微信

 @return 已安装YES,未安装NO
 */
+(BOOL)isWXAppInstalled;

/**
 是否安装支付宝

 @return 已安装YES,未安装NO
 */
+(BOOL)isAliAppInstalled;

/**
 拉起微信支付

 @param orderDict 支付参数,这些参数由服务器签名订单后生成(此字典必选包含这些参数@{@"appid":@"",@"partnerid":@"",@"prepayid":@"",@"noncestr":@"",@"timestamp":@"",@"package":@"",@"sign":@""})
 @param completedBlock 结果回调
 */
-(void)wxpayOrder:(NSDictionary *)orderDict completed:(void(^)(NSDictionary *resultDict))completedBlock;

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
