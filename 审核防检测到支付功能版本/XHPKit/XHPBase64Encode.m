//
//  XHPBase64Encode.m
//  XHPKitExample
//
//  Created by zhuxiaohui on 2018/3/16.
//  Copyright © 2018年 it7090.com. All rights reserved.
//  GitHub:https://github.com/CoderZhuXH

#import "XHPBase64Encode.h"

@implementation XHPBase64Encode
+(NSString *)base64StrFromData:(NSData *)data{
    return [self encode:(const uint8_t*) data.bytes length:data.length];
}

+(NSData *)dataFromBase64Str:(NSString *)base64Str{
    if (![base64Str isKindOfClass:[NSString class]]) {
        return nil;
    }
    return [self decode:[base64Str cStringUsingEncoding:NSASCIIStringEncoding] length:base64Str.length];
}


static char decodingTable[128];

#define ArrayLength(x) (sizeof(x)/sizeof(*(x)))

+ (void)initialize{

    char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    if (self == [XHPBase64Encode class]){
        memset(decodingTable, 0, ArrayLength(decodingTable));

        for (NSInteger i = 0; i < ArrayLength(encodingTable); i++){
            decodingTable[encodingTable[i]] = i;
        }
    }
}

+ (NSString*) encode:(const uint8_t*) input length:(NSInteger) length{
    char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t * output = (uint8_t*)data.mutableBytes;
    for (NSInteger i = 0; i < length; i += 3){
        NSInteger value = 0;
        for (NSInteger j = i; j < (i + 3); j++){
            value <<= 8;
            if (j < length){
                value |= (0xFF & input[j]);
            }
        }
        NSInteger index = (i / 3) * 4;
        output[index + 0] =                    encodingTable[(value >> 18) & 0x3F];
        output[index + 1] =                    encodingTable[(value >> 12) & 0x3F];
        output[index + 2] = (i + 1) < length ? encodingTable[(value >> 6)  & 0x3F] : '=';
        output[index + 3] = (i + 2) < length ? encodingTable[(value >> 0)  & 0x3F] : '=';
    }
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

+ (NSData*)decode:(const char*) string length:(NSInteger) inputLength{
    if ((string == NULL) || (inputLength % 4 != 0)) {
        return nil;
    }
    while (inputLength > 0 && string[inputLength - 1] == '=') {
        inputLength--;
    }
    
    NSInteger outputLength = inputLength * 3 / 4;
    NSMutableData* data = [NSMutableData dataWithLength:outputLength];
    uint8_t* output = data.mutableBytes;
    
    NSInteger inputPoint = 0;
    NSInteger outputPoint = 0;
    while (inputPoint < inputLength){
        char i0 = string[inputPoint++];
        char i1 = string[inputPoint++];
        char i2 = inputPoint < inputLength ? string[inputPoint++] : 'A';
        char i3 = inputPoint < inputLength ? string[inputPoint++] : 'A';
        output[outputPoint++] = (decodingTable[i0] << 2) | (decodingTable[i1] >> 4);
        if (outputPoint < outputLength){
            output[outputPoint++] = ((decodingTable[i1] & 0xf) << 4) | (decodingTable[i2] >> 2);
        }
        if (outputPoint < outputLength){
            output[outputPoint++] = ((decodingTable[i2] & 0x3) << 6) | decodingTable[i3];
        }
    }
    return data;
}
@end
