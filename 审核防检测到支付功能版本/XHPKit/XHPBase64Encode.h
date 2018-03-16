//
//  XHPBase64Encode.h
//  XHPKitExample
//
//  Created by zhuxiaohui on 2018/3/16.
//  Copyright © 2018年 it7090.com. All rights reserved.
//  GitHub:https://github.com/CoderZhuXH

#import <Foundation/Foundation.h>

@interface XHPBase64Encode : NSObject
/**
 NSData->Base64编码字符串

 @param data NSData
 @return Base64编码字符串
 */
+(NSString *)base64StrFromData:(NSData *)data;

/**
 Base64编码字符串->NSData

 @param base64Str Base64编码字符串
 @return NSData
 */
+(NSData *)dataFromBase64Str:(NSString *)base64Str;
@end
