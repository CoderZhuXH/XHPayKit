//
//  XHPayKit.m
//  XHPayKitExample
//
//  Created by zhuxiaohui on 2018/2/23.
//  Copyright © 2018年 it7090.com. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHPayKit

#import "XHPayKit.h"
#import "NSString+XHPayKit.h"
#import "NSDictionary+XHPayKit.h"
#import "XHPayKitConst.h"

@interface XHPayKit()
@property (nonatomic, copy) void(^completedBlock)(NSDictionary *resultDict);
@property (nonatomic, copy) NSString *wxAppid;
@end

@implementation XHPayKit
+(instancetype)defaultManager{
    static dispatch_once_t onceToken;
    static XHPayKit *instance;
    dispatch_once(&onceToken, ^{
        instance = [[XHPayKit alloc] init];
    });
    return instance;
}

+(BOOL)isAliAppInstalled{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:AliUrlPrefix]];
}

+(BOOL)isWxAppInstalled{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:WxUrlPrefix]];
}

-(void)alipayOrder:(NSString *)orderStr fromScheme:(NSString *)schemeStr completed:(void(^)(NSDictionary *resultDict))completedBlock{
    if(orderStr == nil){
        XHPayKitLog(@"缺少orderStr参数");
        return;
    }
    if(schemeStr == nil){
        XHPayKitLog(@"缺少schemeStr参数");
        return;
    }
    if(![self.class isAliAppInstalled]){
        XHPayKitLog(@"未安装支付宝");
        NSDictionary *resultDict = @{@"code":@(-1000),@"msg":@"未安装支付宝"};
        if(completedBlock) completedBlock(resultDict);
        return;
    }
    NSDictionary *dict = @{@"fromAppUrlScheme":schemeStr,@"requestType":@"SafePay",@"dataString":orderStr};
    NSString *dictEncodeString = dict.xh_jsonString.xh_URLEncodedString;
    NSString *openUrl = [NSString stringWithFormat:@"%@%@%@",AliUrlPrefix,@"alipayclient/?",dictEncodeString];
    if(completedBlock){
        self.completedBlock = [completedBlock copy];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];
}

-(void)wxpayOrder:(NSDictionary *)orderDict completed:(void(^)(NSDictionary *resultDict))completedBlock{
    if(orderDict == nil){
        XHPayKitLog(@"缺少orderDict参数");
        return;
    }
    if(![self.class isWxAppInstalled]){
        XHPayKitLog(@"未安装微信");
        NSDictionary *resultDict = @{@"code":@(-1000),@"msg":@"未安装微信"};
        if(completedBlock) completedBlock(resultDict);
        return;
    }
    NSArray *keys = orderDict.allKeys;
    if(![keys containsObject:@"appid"]){
        XHPayKitLog(@"orderDict中缺少appid");
        return;
    }
    if(![keys containsObject:@"partnerid"]){
        XHPayKitLog(@"orderDict中缺少partnerid");
        return;
    }
    if(![keys containsObject:@"prepayid"]){
        XHPayKitLog(@"orderDict中缺少prepayid");
        return;
    }
    if(![keys containsObject:@"noncestr"]){
        XHPayKitLog(@"orderDict中缺少noncestr");
        return;
    }
    if(![keys containsObject:@"timestamp"]){
        XHPayKitLog(@"orderDict中缺少timestamp");
        return;
    }
    if(![keys containsObject:@"package"]){
        XHPayKitLog(@"orderDict中缺少package");
        return;
    }
    if(![keys containsObject:@"sign"]){
        XHPayKitLog(@"orderDict中缺少sign");
        return;
    }
    
    NSString *wxAppid  = [orderDict objectForKey:@"appid"];
    self.wxAppid = wxAppid;
    NSString * partnerId = [orderDict objectForKey:@"partnerid"];
    NSString * prepayId = [orderDict objectForKey:@"prepayid"];
    NSString * nonceStr = [orderDict objectForKey:@"noncestr"];
    NSString * timeStamp = [orderDict objectForKey:@"timestamp"];
    NSString * package = [orderDict objectForKey:@"package"];
    package = [package stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
    NSString * sign = [orderDict objectForKey:@"sign"];
    NSString * parameter = [NSString stringWithFormat:@"nonceStr=%@&package=%@&partnerId=%@&prepayId=%@&timeStamp=%@&sign=%@&signType=%@",nonceStr,package,partnerId,prepayId,timeStamp,sign,@"SHA1"];
    NSString * openUrl = [NSString stringWithFormat:@"%@app/%@/pay/?%@",WxUrlPrefix,wxAppid,parameter];
    if(completedBlock){
        self.completedBlock = [completedBlock copy];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];
}
-(BOOL)handleOpenURL:(NSURL *)url{
    NSString *urlString = url.absoluteString.xh_URLDecodedString;
    if ([urlString rangeOfString:@"//safepay/"].location != NSNotFound){
        NSString *resultStr = [[urlString componentsSeparatedByString:@"?"] lastObject];
        NSDictionary *result = resultStr.xh_dictionary;
        NSDictionary *resultDict = result[@"memo"];
        if(self.completedBlock) self.completedBlock(resultDict);
        return YES;
    }
    if ([urlString rangeOfString:self.wxAppid].location != NSNotFound){
        NSArray *retArray =  [urlString componentsSeparatedByString:@"&"];
        NSInteger retCode = -1;
        NSString *msg = @"普通错误";
        for (NSString *retStr in retArray) {
            if([retStr containsString:@"ret="]){
                retCode = [[retStr stringByReplacingOccurrencesOfString:@"ret=" withString:@""] integerValue];
            }
        }
        if(retCode == 0){
            msg = @"成功";
        }else if (retCode == -2){
            msg = @"用户取消";
        }else if (retCode == -3){
            msg = @"发送失败";
        }else if (retCode == -4){
            msg = @"授权失败";
        }else if (retCode == -5){
            msg = @"微信不支持";
        }
        NSDictionary *resultDict = @{@"code":@(retCode),@"msg":msg};
        if(self.completedBlock) self.completedBlock(resultDict);
        return YES;
    }
    return NO;
}
@end
