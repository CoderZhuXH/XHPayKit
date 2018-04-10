//
//  XHPKit.m
//  XHPKitExample
//
//  Created by zhuxiaohui on 2018/2/23.
//  Copyright © 2018年 it7090.com. All rights reserved.
//  GitHub:https://github.com/CoderZhuXH

#import "XHPKit.h"
#import "NSString+XHPKit.h"
#import "NSDictionary+XHPKit.h"


@interface XHPKit()
@property (nonatomic, copy) void(^completedBlock)(NSDictionary *resultDict);
@property (nonatomic, copy) NSString *wxAppid;
@end

@implementation XHPKit
+(instancetype)defaultManager{
    static dispatch_once_t onceToken;
    static XHPKit *instance;
    dispatch_once(&onceToken, ^{
        instance = [[XHPKit alloc] init];
    });
    return instance;
}

+(BOOL)isWxAppInstalled{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:XHP_WxUrlPrefix]];
}

+(BOOL)isAliAppInstalled{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:XHP_AlUrlPrefix]];
}

-(void)wxpOrder:(XHPWxReq *)req completed:(void(^)(NSDictionary *resultDict))completedBlock;{
    if(req == nil){
        XHPKitLog(@"缺少pReq参数");
        return;
    }
    if(![self.class isWxAppInstalled]){
        XHPKitLog(@"未安装微信");
        return;
    }
    self.wxAppid = req.openID;
    req.package = [req.package stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
    NSString * parameter = [NSString stringWithFormat:@"nonceStr=%@&package=%@&partnerId=%@&prepayId=%@&timeStamp=%d&sign=%@&signType=%@",req.nonceStr,req.package,req.partnerId,req.prepayId,(unsigned int)req.timeStamp,req.sign,@"SHA1"];
    NSString * openUrl = [NSString stringWithFormat:@"%@app/%@/%@/?%@",XHP_WxUrlPrefix,req.openID,XHP_DecryptStr(XHP_p),parameter];
    if(completedBlock){
        self.completedBlock = [completedBlock copy];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];
}

-(void)alipOrder:(NSString *)orderStr fromScheme:(NSString *)schemeStr completed:(void(^)(NSDictionary *resultDict))completedBlock{
    if(orderStr == nil){
        XHPKitLog(@"缺少orderStr参数");
        return;
    }
    if(schemeStr == nil){
        XHPKitLog(@"缺少schemeStr参数");
        return;
    }
    if(![self.class isAliAppInstalled]){
        XHPKitLog(@"未安装x宝");
        return;
    }
    NSDictionary *dict = @{@"fromAppUrlScheme":schemeStr,@"requestType":XHP_DecryptStr(XHP_SafeP),@"dataString":orderStr};
    NSString *dictEncodeString = dict.xh_jsonString.xh_URLEncodedString;
    NSString *openUrl = [NSString stringWithFormat:@"%@%@%@",XHP_AlUrlPrefix,XHP_AlUrlClient,dictEncodeString];
    if(completedBlock){
        self.completedBlock = [completedBlock copy];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];
}

-(BOOL)handleOpenURL:(NSURL *)url{
    NSString *urlString = url.absoluteString.xh_URLDecodedString;
    if ([urlString xh_containsString:[NSString stringWithFormat:@"//%@/",XHP_DecryptStr(XHP_safep)]]){
        NSString *resultStr = [[urlString componentsSeparatedByString:@"?"] lastObject];
        resultStr = [resultStr stringByReplacingOccurrencesOfString:@"ResultStatus" withString:@"resultStatus"];
        NSDictionary *result = resultStr.xh_dictionary;
        NSDictionary *resultDict = result[@"memo"];
        if(self.completedBlock) self.completedBlock(resultDict);
        return YES;
    }
    if (self.wxAppid && [urlString xh_containsString:self.wxAppid] && [urlString xh_containsString:[NSString stringWithFormat:@"//%@/",XHP_DecryptStr(XHP_p)]]){
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
