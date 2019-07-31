//
//  JCLUserLoginHeader.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/12/20.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLUserLoginHeader.h"

@implementation JCLUserLoginHeader
-(instancetype)init{
    if (self = [super init]){
        self.backgroundColor = JCL_Bg_COL;
        self.icon = [JCLKitObj JCLButton:self img:@"" size:34 target:self action:nil];
        self.icon.title = @"天使金融";
        self.icon.color = JCL_SelText_COL;
        self.icon.titleEdgeInsets = UIEdgeInsetsMake(0, 14, 0, 0);
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.icon.frame = CGRectMake(0, 0, self.width, self.height);
}
@end
