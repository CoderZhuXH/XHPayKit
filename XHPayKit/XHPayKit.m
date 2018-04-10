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

+(BOOL)isWxAppInstalled{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:XHP_WxUrlPrefix]];
}

+(BOOL)isAliAppInstalled{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:XHP_AlUrlPrefix]];
}

-(void)wxpayOrder:(XHPayWxReq *)req completed:(void(^)(NSDictionary *resultDict))completedBlock;{
    if(req == nil){
        XHPayKitLog(@"缺少payReq参数");
        return;
    }
    if(![self.class isWxAppInstalled]){
        XHPayKitLog(@"未安装微信");
        return;
    }
    self.wxAppid = req.openID;
    req.package = [req.package stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
    NSString * parameter = [NSString stringWithFormat:@"nonceStr=%@&package=%@&partnerId=%@&prepayId=%@&timeStamp=%d&sign=%@&signType=%@",req.nonceStr,req.package,req.partnerId,req.prepayId,(unsigned int)req.timeStamp,req.sign,@"SHA1"];
    NSString * openUrl = [NSString stringWithFormat:@"%@app/%@/pay/?%@",XHP_WxUrlPrefix,req.openID,parameter];
    if(completedBlock){
        self.completedBlock = [completedBlock copy];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];
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
        return;
    }
    NSDictionary *dict = @{@"fromAppUrlScheme":schemeStr,@"requestType":@"SafePay",@"dataString":orderStr};
    NSString *dictEncodeString = dict.xh_jsonString.xh_URLEncodedString;
    NSString *openUrl = [NSString stringWithFormat:@"%@%@%@",XHP_AlUrlPrefix,XHP_AlUrlClient,dictEncodeString];
    if(completedBlock){
        self.completedBlock = [completedBlock copy];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];
}

-(BOOL)handleOpenURL:(NSURL *)url{
    NSString *urlString = url.absoluteString.xh_URLDecodedString;
    if ([urlString xh_containsString:@"//safepay/"]){
        NSString *resultStr = [[urlString componentsSeparatedByString:@"?"] lastObject];
        resultStr = [resultStr stringByReplacingOccurrencesOfString:@"ResultStatus" withString:@"resultStatus"];
        NSDictionary *result = resultStr.xh_dictionary;
        NSDictionary *resultDict = result[@"memo"];
        if(self.completedBlock) self.completedBlock(resultDict);
        return YES;
    }
    if (self.wxAppid && [urlString xh_containsString:self.wxAppid] && [urlString xh_containsString:@"//pay/"]){
        NSArray *retArray =  [urlString componentsSeparatedByString:@"&"];
        NSInteger errCode = -1;
        NSString *errStr = @"普通错误";
        for (NSString *retStr in retArray) {
            if([retStr xh_containsString:@"ret="]){
                errCode = [[retStr stringByReplacingOccurrencesOfString:@"ret=" withString:@""] integerValue];
            }
        }
        if(errCode == 0){
            errStr = @"成功";
        }else if (errCode == -2){
            errStr = @"用户取消";
        }else if (errCode == -3){
            errStr = @"发送失败";
        }else if (errCode == -4){
            errStr = @"授权失败";
        }else if (errCode == -5){
            errStr = @"微信不支持";
        }
        NSDictionary *resultDict = @{@"errCode":@(errCode),@"errStr":errStr};
        if(self.completedBlock) self.completedBlock(resultDict);
        return YES;
    }
    return NO;
}
@end
