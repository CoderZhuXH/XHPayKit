//
//  ViewController.m
//  XHPKitExample
//
//  Created by zhuxiaohui on 2018/2/28.
//  Copyright © 2018年 it7090.com. All rights reserved.
//  项目地址:https://github.com/CoderZhuXH/XHPayKit
//  README:https://github.com/CoderZhuXH/XHPayKit/blob/master/README.md

#import "ViewController.h"
#import "XHPKit.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    [self.view addSubview:self.tableView];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示:\n请替换支付参数为真实数据,\n便可进行实际支付" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];

    NSLog(@"付款\n%@",XHP_EncryptStr(@"付款"));
}

#pragma mark - tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if(indexPath.row == 0){//微信支付
        if(![XHPKit isWxAppInstalled]){
            NSLog(@"未安装微信");
            return;
        }
        
        //微信支付参数,下面7个参数,由后台签名订单后生成,并返回给客服端(与官方SDK一致)
        //注意:请将下面参数设置为你自己真实订单签名后服务器返回参数,便可进行实际支付
        //以下参数详细介绍见
        //微信官方文档:https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=9_12&index=2
        
        XHPWxReq *req = [[XHPWxReq alloc] init];
        req.openID = @"";//微信开放平台审核通过的应用APPID
        req.partnerId = @"";//商户号
        req.prepayId = @"";//交易会话ID
        req.nonceStr = @"";//随机串，防重发
        req.timeStamp = 1518156229;//时间戳，防重发
        req.package = @"";// 扩展字段,暂填写固定值Sign=WXPay
        req.sign = @"";//签名
        
        //传入订单模型,拉起微信支付
        [[XHPKit defaultManager] wxpOrder:req completed:^(NSDictionary *resultDict) {
            NSLog(@"支付结果:\n%@",resultDict);
            NSInteger code = [resultDict[@"errCode"] integerValue];
            if(code == 0){//支付成功
                
            }
        }];
        
    }else if (indexPath.row == 1){//支付宝支付
        
        if(![XHPKit isAliAppInstalled]){
            NSLog(@"未安装支付宝");
            return;
        }
        
        //支付宝订单签名,此签名由后台签名订单后生成,并返回给客户端(与官方SDK一致)
        //注意:请将下面值设置为你自己真实订单签名,便可进行实际支付
        NSString *orderSign = @"2018010801689398&biz_content=%7b%22timeout_express%22%3a%2230m%22%2c%22seller_id%22%3a%22pay%40qianzhan.com%22%2c%22product_code%22%3a%22QUICK_MSECURITY_PAY%22%2c%22total_amount%22%3a%220.01%22%2c%22subject%22%3a%2230%e5%a4%a9%e4%bd%bf%e7%94%a8%e6%9c%9f%e9%99%90%22%2c%22body%22%3a%2230%e5%a4%a9%e4%bd%bf%e7%94%a8%e6%9c%9f%e9%99%90%22%2c%22out_trade_no%22%3a%22data-180209-9913b1d3%22%7d&charset=utf-8&method=alipay.trade.app.pay&notify_url=https%3a%2f%2fappecV2.paipai123.com%2fapi%2fAlipay%2fAliPayNotify&sign_type=RSA2&timestamp=2018-02-23 10%3a54%3a15&version=1.0&sign=d4zihRv9g6OdzI7Tdh64iFarDajKUqcAGWzU9wB29g7X1w6NE5v9Zed2WwCNJFsZf%2fnwtgGQ24m5Ce4%2fxm2jzgyMO2NvRIWnnXO3sUKdBlGNEZeq034j3c3ZZ8L7p830TYRKecaxKt9%2bf%2fkCw67GN1%2bBwgPM1zdAB4xoD%2bqxrtJN79sCuc3xSaBojOWPm%2f9g0bQvd4VBP6ZzxLlbtVt0Yg5Nw2dY0gW4fiEJXfbPeCVW6gSa07bbEb%2fSbbWSgRJfNP%2f%2fi9jkM4Y9%2fLw3Jvj6wH792NUCieWvrIfl6BGiAY6PR0YKLM%2baskr6qkFX3D5H%2bTf6z%2bmf40bT8v74WaBnng%3d%3d";
        
        //传入支付宝订单签名 和 自己App URL Scheme,拉起支付宝支付
        [[XHPKit defaultManager] alipOrder:orderSign fromScheme:@"XHPKitExample" completed:^(NSDictionary *resultDict) {
            NSLog(@"支付结果:\n%@",resultDict);
            NSInteger status = [resultDict[@"resultStatus"] integerValue];
            if(status == 9000){//支付成功
                
            }
        }];
    }
}
#pragma mark - lazy
-(NSArray *)dataArray{
    if(!_dataArray){
        _dataArray = @[XHP_DecryptStr(XHP_WX_Str), XHP_DecryptStr(XHP_ZFB_Str)];
    }
    return _dataArray;
}
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
