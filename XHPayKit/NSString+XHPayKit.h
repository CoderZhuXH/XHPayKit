//
//  NSString+XHPayKit.h
//  XHPayKitExample
//
//  Created by zhuxiaohui on 2018/2/23.
//  Copyright © 2018年 it7090.com. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHPayKit

#import <Foundation/Foundation.h>

@interface NSString (XHPayKit)

@property (nonatomic, copy,readonly) NSDictionary *xh_dictionary;

@property (nonatomic, copy,readonly) NSString *xh_URLDecodedString;

@property (nonatomic, copy,readonly) NSString *xh_URLEncodedString;

-(BOOL)xh_containsString:(NSString *)string;

@end
