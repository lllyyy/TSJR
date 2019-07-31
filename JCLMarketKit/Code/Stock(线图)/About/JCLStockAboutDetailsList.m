//
//  JCLStockAboutDetailsList.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/1.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockAboutDetailsList.h"
#import <WebKit/WebKit.h>

@interface JCLStockAboutDetailsList ()<WKUIDelegate, WKNavigationDelegate>
@end

@implementation JCLStockAboutDetailsList
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navi.middle.title = self.name;
    WKWebView *web = [[WKWebView alloc] init];
    web.backgroundColor = JCL_Bg_COL;
    web.navigationDelegate = self;
    web.UIDelegate = self;
    [self.view addSubview:web];
    web.frame = CGRectMake(0, 64, JCLWIDTH, JCLHEIGHT - 64);
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    //[JCLSVProgressHUD showHUD];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
   // [JCLSVProgressHUD dimissHUD];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
  //  [JCLSVProgressHUD showErrorHud:@"网络不畅，请稍后尝试!!!!"];
}

@end
