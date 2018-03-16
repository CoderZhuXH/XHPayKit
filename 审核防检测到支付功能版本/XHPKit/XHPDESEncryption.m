//
//  XHPDESEncryption.m
//  XHPKitExample
//
//  Created by zhuxiaohui on 2018/3/16.
//  Copyright © 2018年 it7090.com. All rights reserved.
//  GitHub:https://github.com/CoderZhuXH

#import "XHPDESEncryption.h"
#import <CommonCrypto/CommonCrypto.h>
#import "XHPBase64Encode.h"

#define XHPDESEncryptionKey @"it7090.com"

@implementation XHPDESEncryption

+(NSString *)encryptUseDES:(NSString *)plainText{
    return [self encryptUseDES:plainText key:XHPDESEncryptionKey];
}

+(NSString *)decryptUseDES:(NSString*)cipherText {
    return [self decryptUseDES:cipherText key:XHPDESEncryptionKey];
}

+(NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key{
    NSData *data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
    size_t numBytesEncrypted = 0;
    NSString *DESkey = key;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [DESkey UTF8String], kCCBlockSizeDES,
                                          iv,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [XHPBase64Encode base64StrFromData:[NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted]];
    }
    
    free(buffer);
    return nil;
}

+(NSString *)decryptUseDES:(NSString*)cipherText key:(NSString *)key{
    NSData *cipherData = [XHPBase64Encode dataFromBase64Str:cipherText];
    NSUInteger dataLength = [cipherData length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
    size_t numBytesDecrypted = 0;
    NSString *DESkey = key;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [DESkey UTF8String], kCCBlockSizeDES,
                                          iv,
                                          [cipherData bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [[NSString alloc] initWithData:[NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted] encoding:NSUTF8StringEncoding];
    }
    
    free(buffer);
    return nil;
}

@end
