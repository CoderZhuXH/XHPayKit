//
//  XHPWxReq.h
//  XHPKitExample
//
//  Created by zhuxiaohui on 2018/2/24.
//  Copyright © 2018年 it7090.com. All rights reserved.
//  GitHub:https://github.com/CoderZhuXH

#import <Foundation/Foundation.h>

//微信消息模型
@interface XHPWxReq : NSObject
/** 由用户微信号和AppID组成的唯一标识，发送请求时第三方程序必须填写，用于校验微信用户是否换号登录*/
@property (nonatomic, copy) NSString* openID;
/** 商家id */
@property (nonatomic, copy) NSString *partnerId;
/** 订单id */
@property (nonatomic, copy) NSString *prepayId;
/** 随机串，防重发 */
@property (nonatomic, copy) NSString *nonceStr;
/** 时间戳，防重发 */
@property (nonatomic, assign) UInt32 timeStamp;
/** 数据和签名 */
@property (nonatomic, copy) NSString *package;
/** 签名 */
@property (nonatomic, copy) NSString *sign;
@end

