//
//  JCLWapList.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/15.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLWapList.h"
#import <WebKit/WebKit.h>

@interface JCLWapList ()<WKUIDelegate, WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *web;
@property (nonatomic, weak) CALayer *progress;
@end

@implementation JCLWapList
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navi.middle.title = self.name;
    
    UIButton *back = [JCLKitObj JCLButton:self.navi img:@"" size:16 target:self action:@selector(backAction)];
    back.frame = CGRectMake(0, 20, 44, 44);
    UIButton *close = [JCLKitObj JCLButton:self.navi img:@"关闭" size:16 target:self action:nil];
    close.frame = CGRectMake(back.maxX, 20, 44, 44);
    [close tapActionBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    WKWebView *web = [[WKWebView alloc] init]; [self.view addSubview:web];
    web.backgroundColor = [UIColor whiteColor];
    web.navigationDelegate = self; web.UIDelegate = self;
    web.frame = CGRectMake(0, JCLNAVI, JCLWIDTH, JCLSCROLL);
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [web addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    self.web = web;
    
    UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 3)];
    progress.backgroundColor = [UIColor clearColor];
    [self.view addSubview:progress];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 3);
    layer.backgroundColor = [UIColor orangeColor].CGColor;
    [progress.layer addSublayer:layer];
    self.progress = layer;
}
-(NSString *)base64FromJson:(NSMutableDictionary *)dicM{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicM options:NSJSONWritingPrettyPrinted error:NULL];
    return [jsonData base64EncodedStringWithOptions:0];
}

-(void)backAction{
    if (self.web.canGoBack) {
        [self.web goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma 追踪加载过程
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progress.opacity = 1;
        //不要让进度条倒着走...有时候goback会出现这种情况
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
            return;
        }
        self.progress.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[@"new"] floatValue], 3);
        if ([change[@"new"] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progress.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progress.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
   // [SVProgressHUD showWithStatus:@"正在加载中，敬耐心等待!!!!"];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    [SVProgressHUD dismiss];
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [SVProgressHUD dismiss];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [SVProgressHUD showWithStatus:@"网络不畅，请返回重新尝试!!!!"];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if ([webView.URL.absoluteString hasPrefix:@"https://itunes.apple.com"]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)dealloc {
    [self.web removeObserver:self forKeyPath:@"estimatedProgress"];
}
@end

