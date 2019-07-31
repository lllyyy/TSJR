//
//  JCLTradOpenPop.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/12/8.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradOpenPop.h"

@interface JCLTradOpenPop()
@property (nonatomic, weak) UILabel *text1;
@property (nonatomic, weak) UILabel *text2;
@end

@implementation JCLTradOpenPop

-(instancetype)init{
    if(self = [super init]) {
        self.backgroundColor = JCLHexCol(@"#2E313A");
        self.layer.cornerRadius = 14;
        
        self.text1 = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:0];
        self.text1.text = @"请登录到西苑资本官网，使用网页交易。\n 建议在pc上面进行下单交易。";
        
        self.text2 = [JCLKitObj JCLLable:self font:14 color:JCLHexCol(@"#9A9B9D") alignment:0];
        self.text2.text = @"西苑资本交易网址。\nhttps://corclearingretail-demo.automatedfinancial.com/secure_login.html";
        
        self.submit = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:nil];
        self.submit.title = @"点击复制链接";
        self.submit.layer.cornerRadius = 12;
        self.submit.layer.borderWidth = 1;
        self.submit.layer.borderColor = JCLHexCol(@"#9A9B9D").CGColor;
        self.submit.color = JCLHexCol(@"#9A9B9D");
        
        self.diss = [JCLKitObj JCLButton:self img:@"关闭按钮" size:15 target:self action:nil];
        
        [self.submit tapActionBlock:^{
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            [pasteboard setString:@"https://corclearingretail-demo.automatedfinancial.com/secure_login.html"];
            pasteboard ? [JCLFramework JCLProgressHUD:@"链接已复制"] : [JCLFramework JCLProgressHUD:@"链接复制失败"];
        }];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat x = 24, s = 4;
    CGSize size1 = [JCLKitObj JCLTextSize:self.text1.text font:self.text1.font width:self.width-2*x];
    CGSize size2 = [JCLKitObj JCLTextSize:self.text2.text font:self.text2.font width:self.width-2*x];
    CGSize size3 = [JCLKitObj JCLTextSize:self.submit.title font:self.text2.font];

    CGFloat y = 0.5*(self.height-(size1.height+size2.height+size3.height+4*s));
    self.text1.frame = CGRectMake(x, y, self.width-2*x, size1.height);
    self.text2.frame = CGRectMake(x, self.text1.maxY+s, self.width-2*x, size2.height);
    self.submit.frame = CGRectMake(0.5*(self.width-(size3.width+x)), self.text2.maxY+s, size3.width+x, size3.height+2*s);
    
    self.diss.frame = CGRectMake(0, self.height, self.width, 66);
}
@end
