//
//  JCLMarketInfo.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/27.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLMarketInfo.h"

@implementation JCLMarketInfo
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JCL_Bg_COL;
        self.title = [YSKitObj YSLable:self size:14 color:JCL_Text_COL alignment:1 style:1];
        self.title.numberOfLines = 1;
        self.code = [YSKitObj YSLable:self size:18 color:JCL_Text_COL alignment:1 style:0];
        self.range = [YSKitObj YSLable:self size:13 color:JCL_Text_COL alignment:2 style:0];
        self.scale = [YSKitObj YSLable:self size:13 color:JCL_Text_COL alignment:0 style:0];
        [JCLKitObj RXTap:self target:self action:@selector(tapAction) number:1];
    }
    return self;
}
-(void)tapAction{ !self.tapActionBlock ? : self.tapActionBlock(); }

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat textS = 2.4;
    CGSize titleSize = [JCLKitObj JCLTextSize:@"jcl" font:self.title.font];
    CGSize codeSize = [JCLKitObj JCLTextSize:self.code.text font:self.code.font];
    CGSize rangeSize = [JCLKitObj JCLTextSize:self.range.text font:self.range.font];
    CGFloat topS = 0.5*(self.height - (titleSize.height + codeSize.height + rangeSize.height + 2*textS));
    
    self.title.frame = CGRectMake(0, topS, self.width, titleSize.height + textS);
    self.code.frame = CGRectMake(0, self.title.maxY, self.width, codeSize.height + textS);
    self.range.frame = CGRectMake(0, self.code.maxY, 0.5*(self.width) - textS, rangeSize.height + textS);
    self.scale.frame = CGRectMake(0.5*(self.width) + textS, self.code.maxY, 0.5*(self.width) - textS, rangeSize.height + textS);
}
@end
