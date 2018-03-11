//
//  XHPWxReq.h
//  XHPKitExample
//
//  Created by zhuxiaohui on 2018/2/24.
//  Copyright © 2018年 it7090.com. All rights reserved.
//  GitHub:https://github.com/CoderZhuXH

#import <Foundation/Foundation.h>

//以下参数详细介绍见
//微信官方文档:https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=9_12&index=2

//发起微信支付的消息模型
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
/** 扩展字段,暂填写固定值Sign=WXPay */
@property (nonatomic, copy) NSString *package;
/** 签名 */
@property (nonatomic, copy) NSString *sign;
@end
