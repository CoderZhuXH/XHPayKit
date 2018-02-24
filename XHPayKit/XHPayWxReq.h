//
//  XHPayWxReq.h
//  XHPayKitExample
//
//  Created by zhuxiaohui on 2018/2/24.
//  Copyright © 2018年 FORWARD. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHPayKit

#import <Foundation/Foundation.h>

//发起微信支付的消息模型
@interface XHPayWxReq : NSObject
/** 由用户微信号和AppID组成的唯一标识，发送请求时第三方程序必须填写，用于校验微信用户是否换号登录*/
@property (nonatomic, copy) NSString* openID;
/** 商家向财付通申请的商家id */
@property (nonatomic, copy) NSString *partnerId;
/** 预支付订单 */
@property (nonatomic, copy) NSString *prepayId;
/** 随机串，防重发 */
@property (nonatomic, copy) NSString *nonceStr;
/** 时间戳，防重发 */
@property (nonatomic, assign) UInt32 timeStamp;
/** 商家根据财付通文档填写的数据和签名 */
@property (nonatomic, copy) NSString *package;
/** 商家根据微信开放平台文档对数据做的签名 */
@property (nonatomic, copy) NSString *sign;
@end

