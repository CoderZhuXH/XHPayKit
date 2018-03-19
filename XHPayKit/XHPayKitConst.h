//
//  XHPayKitConst.h
//  XHPayKitExample
//
//  Created by zhuxiaohui on 2018/2/23.
//  Copyright © 2018年 it7090.com. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHPayKit

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef DEBUG
#define XHPayKitLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define XHPayKitLog(...)
#endif

#define XHP_AlUrlSign @"alipay"
#define XHP_AlUrlPrefix  [NSString stringWithFormat:@"%@%@",XHP_AlUrlSign,@"://"]
#define XHP_AlUrlClient  [NSString stringWithFormat:@"%@%@",XHP_AlUrlSign,@"client/?"]

#define XHP_WxUrlSign @"weixin"
#define XHP_WxUrlPrefix   [NSString stringWithFormat:@"%@%@",XHP_WxUrlSign,@"://"]



