//
//  XHPKitConst.h
//  XHPKitExample
//
//  Created by zhuxiaohui on 2018/2/23.
//  Copyright © 2018年 it7090.com. All rights reserved.
//  GitHub:https://github.com/CoderZhuXH

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef DEBUG
#define XHPKitLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define XHPKitLog(...)
#endif

#define XHP_AlUrlSign XHP_DecryptStr(XHP_alip)
#define XHP_AlUrlPrefix  [NSString stringWithFormat:@"%@%@",XHP_AlUrlSign,@"://"]
#define XHP_AlUrlClient  [NSString stringWithFormat:@"%@%@",XHP_AlUrlSign,@"client/?"]

#define XHP_WxUrlSign XHP_DecryptStr(XHP_wx)
#define XHP_WxUrlPrefix   [NSString stringWithFormat:@"%@%@",XHP_WxUrlSign,@"://"]

//此宏用来解密字符串
#define XHP_DecryptStr(Str) [XHPDESEncryption decryptUseDES:Str]
//此宏用来加密字符串
#define XHP_EncryptStr(Str) [XHPDESEncryption encryptUseDES:Str]

/**以下为编码后常量字符串-不要修改,其真实含义请查看README文档*/
/**请使用 XHP_DecryptStr(Str)宏 来读取 下面编码字符串真实值 */

#define XHP_ZFB_Str @"/rn5lmtL9xBhl7pICTTeog=="

#define XHP_ZF_Str @"Hh2HYBtRrqo="

#define XHP_FK_Str @"jRp4OoAGcpY="

#define XHP_WX_Str @"jicW3N4muT0="

#define XHP_alip @"VPV1g0Ss1b4="

#define XHP_wx @"V5HStfIGOso="

#define XHP_p @"apbK36sJjkM="

#define XHP_SafeP @"0mz3t48qNFI="

#define XHP_safep @"Z6O7pjD4hcA="
