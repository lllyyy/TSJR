//
//  JCLUserAboutHeader.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/15.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLUserAboutHeader.h"

@implementation JCLUserAboutHeader
-(instancetype)init{
    if (self = [super init]){
        self.backgroundColor = JCL_Bg_COL;
        self.icon = [JCLKitObj JCLImage:self];
        self.title = [JCLKitObj JCLLable:self font:16 color:JCL_Text_COL alignment:1];
        self.number = [JCLKitObj JCLLable:self font:13 color:JCL_Text_COL alignment:1];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize size1 = [JCLKitObj JCLTextSize:self.title.text font:self.title.font width:self.width];
    CGSize size2 = [JCLKitObj JCLTextSize:self.number.text font:self.number.font width:self.width];
    CGFloat imgWH = 0.36*self.height, y = 0.5*(self.height-(size1.height+size2.height+imgWH-8));
    self.icon.frame = CGRectMake(0.5*(self.width-imgWH), y, imgWH, imgWH);
    self.title.frame = CGRectMake(0, self.icon.maxY+2, self.width, size1.height);
    self.number.frame = CGRectMake(0, self.title.maxY-9, self.width, size2.height);
}
@end
