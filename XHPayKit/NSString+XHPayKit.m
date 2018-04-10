//
//  NSString+XHPayKit.m
//  XHPayKitExample
//
//  Created by zhuxiaohui on 2018/2/23.
//  Copyright © 2018年 it7090.com. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHPayKit

#import "NSString+XHPayKit.h"

@implementation NSString (XHPayKit)
-(NSDictionary *)xh_dictionary{
    NSString *jsonString = self;
    NSData *JSONData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
}

-(NSString *)xh_URLEncodedString{
    NSString *string = self;
    NSString *encodedString = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)string,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    return encodedString;
}
-(NSString *)xh_URLDecodedString{
    NSString *string = self;
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)string, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

-(BOOL)xh_containsString:(NSString *)string{
    if(string == nil) return NO;
    return [self rangeOfString:string].location != NSNotFound;
}
@end
