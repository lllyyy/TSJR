//
//  JCLStockHotHead.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/12.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockHotHead.h"

@interface JCLStockHotHead()
@property(nonatomic, weak) UIView *bg;
@property(nonatomic, weak) UIView *line;
@end

@implementation JCLStockHotHead
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JCLBGRGB;
        self.bg = [JCLKitObj JCLView:self color:[UIColor whiteColor]];
        self.line = [JCLKitObj JCLView:self.bg color:[UIColor redColor]];
        self.text = [JCLKitObj JCLLable:self.bg font:14 color:nil alignment:0];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat lineH     = 1;
    self.bg.frame     = CGRectMake(0, lineH, self.width, self.height - 2*lineH);
    CGFloat h         = 0.7*self.bg.height, y = 0.5*(self.height - h);
    self.line.frame   = CGRectMake(14, y, 4, self.height/2);
    self.line.centerY = self.height/2;
    self.text.frame   = CGRectMake(self.line.maxX + 8, 0, self.width, self.bg.height);
}
@end
