//
//  NSDictionary+XHPayKit.m
//  XHPayKitExample
//
//  Created by zhuxiaohui on 2018/2/23.
//  Copyright © 2018年 it7090.com. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHPayKit

#import "NSDictionary+XHPayKit.h"

@implementation NSDictionary (XHPayKit)
-(NSString *)xh_jsonString{
    NSDictionary *dictionary = self;
    NSString * string=[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    return string;
}
@end
