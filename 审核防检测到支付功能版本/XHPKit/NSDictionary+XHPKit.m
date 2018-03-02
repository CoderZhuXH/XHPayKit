//
//  NSDictionary+XHPKit.m
//  XHPKitExample
//
//  Created by zhuxiaohui on 2018/2/23.
//  Copyright © 2018年 it7090.com. All rights reserved.
//  GitHub:https://github.com/CoderZhuXH

#import "NSDictionary+XHPKit.h"

@implementation NSDictionary (XHPKit)
-(NSString *)xh_jsonString{
    NSDictionary *dictionary = self;
    NSString * string=[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    return string;
}
@end
