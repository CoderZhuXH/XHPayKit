//
//  XHPWxReq.h
//  XHPKitExample
//
//  Created by zhuxiaohui on 2018/2/24.
//  Copyright © 2018年 it7090.com. All rights reserved.
//  GitHub:https://github.com/CoderZhuXH

#import <Foundation/Foundation.h>

@interface XHPWxReq : NSObject
/** 微信开放平台审核通过的应用APPID*/
@property (nonatomic, copy) NSString* openID;
/** 商户号 */
@property (nonatomic, copy) NSString *partnerId;
/** 交易会话ID */
@property (nonatomic, copy) NSString *prepayId;
/** 随机串，防重发 */
@property (nonatomic, copy) NSString *nonceStr;
/** 时间戳，防重发 */
@property (nonatomic, assign) UInt32 timeStamp;
/** 扩展字段 */
@property (nonatomic, copy) NSString *package;
/** 签名 */
@property (nonatomic, copy) NSString *sign;
@end
