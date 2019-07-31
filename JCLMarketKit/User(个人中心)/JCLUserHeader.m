//
//  JCLUserInfoHeader.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/16.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLUserHeader.h"

@interface JCLUserHeader()
@property (nonatomic, weak) UIView *bg;
@end

@implementation JCLUserHeader
-(instancetype)init{
    if (self = [super init]){
        self.backgroundColor = JCL_Bg_COL;
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        self.icon = [JCLKitObj JCLImage:self];
        self.name = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:0];
        self.text = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:0];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat x = 10, y = 14;
    self.bg.frame = CGRectMake(0, 0, self.width, self.height-0.009*JCLHEIGHT-1);
    CGFloat wh = self.bg.height-2*y;
    self.icon.frame = CGRectMake(x, y, wh, wh);
    self.icon.layer.cornerRadius = 0.5*wh;
    self.name.frame = CGRectMake(self.icon.maxX+x, y, self.width-(self.icon.maxX+2*x), 0.5*self.icon.height);
    self.text.frame = CGRectMake(self.icon.maxX+x, self.name.maxY, self.name.width, 0.5*self.icon.height);
}
@end
