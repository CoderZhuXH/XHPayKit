//
//  NSString+XHPKit.h
//  XHPKitExample
//
//  Created by zhuxiaohui on 2018/2/23.
//  Copyright © 2018年 it7090.com. All rights reserved.
//  GitHub:https://github.com/CoderZhuXH

#import <Foundation/Foundation.h>

@interface NSString (XHPKit)

@property (nonatomic, copy,readonly) NSDictionary *xh_dictionary;

@property (nonatomic, copy,readonly) NSString *xh_URLDecodedString;

@property (nonatomic, copy,readonly) NSString *xh_URLEncodedString;

-(BOOL)xh_containsString:(NSString *)string;

@end
