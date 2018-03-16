//
//  XHPDESEncryption.h
//  XHPKitExample
//
//  Created by zhuxiaohui on 2018/3/16.
//  Copyright © 2018年 it7090.com. All rights reserved.
//  GitHub:https://github.com/CoderZhuXH

#import <Foundation/Foundation.h>

@interface XHPDESEncryption : NSObject

/** DES加密,采用默认key */
+ (NSString *)encryptUseDES:(NSString *)plainText;

/** DES解密,采用默认key */
+ (NSString *)decryptUseDES:(NSString*)cipherText;

/**
 DES加密

 @param plainText 普通字符串
 @param key key
 @return 加密后字符串
 */
+(NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key;

/**
 DES解密

 @param cipherText 加密字符串
 @param key key
 @return 解密后字符串
 */
+(NSString *)decryptUseDES:(NSString*)cipherText key:(NSString *)key;

@end
