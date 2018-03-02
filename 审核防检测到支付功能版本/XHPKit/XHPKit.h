//
//  XHPKit.h
//  XHPKitExample
//
//  Created by zhuxiaohui on 2018/2/23.
//  Copyright © 2018年 it7090.com. All rights reserved.
//  GitHub:https://github.com/CoderZhuXH

//  如果你在使用过程中出现bug,请及时以下面任意一种方式联系我，我会及时修复bug并帮您解决问题。
//  QQ交流群:537476189
//  Email:it7090@163.com
//  新浪微博:朱晓辉Allen
//  GitHub:https://github.com/CoderZhuXH
//  简书:https://www.jianshu.com/u/acf1a1f12e0f
//  掘金:https://juejin.im/user/59b50d3cf265da066d331a06


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XHPWxReq.h"


@interface XHPKit : NSObject

+(instancetype)defaultManager;

/**
 是否安装微信

 @return 已安装YES,未安装NO
 */
+(BOOL)isWxAppInstalled;

/**
 是否安装xx宝

 @return 已安装YES,未安装NO
 */
+(BOOL)isAliAppInstalled;

/**
 微信

 @param req 消息模型
 @param completedBlock 结果回调
 */
-(void)wxpOrder:(XHPWxReq *)req completed:(void(^)(NSDictionary *resultDict))completedBlock;

/**
 某宝

 @param orderStr 签名
 @param schemeStr 本app url scheme
 @param completedBlock 结果回调
 */
-(void)alipOrder:(NSString *)orderStr fromScheme:(NSString *)schemeStr completed:(void(^)(NSDictionary *resultDict))completedBlock;

/**
 处理微信,某宝跳回商户app携带的结果Url
 需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用
 @param url 结果Url
 @return 成功返回YES，失败返回NO
 */
-(BOOL)handleOpenURL:(NSURL *)url;

@end
