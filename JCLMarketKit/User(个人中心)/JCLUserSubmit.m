//
//  JCLUserUpdateFooter.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/15.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLUserSubmit.h"

@implementation JCLUserSubmit
-(instancetype)init{
    if (self = [super init]){
        self.backgroundColor = JCL_Bg_COL;
        self.submit = [JCLKitObj JCLButton:self img:@"" size:15 target:self action:nil];
        self.submit.backgroundColor = JCLHexCol(@"#BE9E62");
        self.submit.layer.cornerRadius = 4;
        self.more = [JCLKitObj JCLButton:self img:@"" size:15 target:self action:nil];
        self.more.backgroundColor = JCLHexCol(@"#BE9E62");
        self.more.layer.cornerRadius = 4;
        
        self.regist = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:nil];
        self.regist.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.forget = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:nil];
        self.forget.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = [JCLKitObj JCLTextSize:@"基金" font:self.forget.titleLabel.font];
    CGFloat x = 14, y = 20, h = size.height+y;
    self.submit.frame = CGRectMake(x, y, self.width-2*x, 45*JCLWIDTH/375);
    NSString *device = [UIDevice currentDevice].model;
    if ([device isEqualToString:@"iPad"]) {
        self.submit.frame = CGRectMake(x, y, self.width-2*x, 30);
    }
    if (self.isLogin) {
        self.regist.frame = CGRectMake(x, self.submit.maxY, self.width-2*x, h);
        self.forget.frame = CGRectMake(0.5*self.width, self.submit.maxY, 0.5*self.width-x, h);
    }
    if (self.isMore) {
        CGFloat w = 0.5*(self.width-3*x);
        self.submit.frame = CGRectMake(x, y, w, self.height-2*h);
        self.more.frame = CGRectMake(self.submit.maxX+x, y, w, self.height-2*h);
    }
}
@end

