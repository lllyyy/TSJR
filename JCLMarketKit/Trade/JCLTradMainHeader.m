//
//  JCLTradMainHeader.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/17.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradMainHeader.h"

@interface JCLTradMainHeader()
@property (nonatomic, weak) UIView *line1;
@property (nonatomic, weak) UIView *line2;
@property (nonatomic, weak) UIView *line3;
@property (nonatomic, weak) UIView *line4;
@property (nonatomic, weak) UIView *line5;
@end

@implementation JCLTradMainHeader
-(instancetype)init{
    if (self = [super init]){
        self.backgroundColor = JCL_Cell_COL;
        self.line1 = [JCLKitObj JCLView:self color:JCL_Bg_COL];
        self.line2 = [JCLKitObj JCLView:self color:JCL_Bg_COL];
        self.line3 = [JCLKitObj JCLView:self color:JCL_Bg_COL];
        self.line4 = [JCLKitObj JCLView:self color:JCL_Bg_COL];
        self.line5 = [JCLKitObj JCLView:self color:JCL_Bg_COL];

        self.assets = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:0];
        self.marketVal = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:1];
        self.cash = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:1];
        self.arrears = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:1];
        self.frozen = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:1];
        self.draw = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:1];
        self.bar = [[JCLBarList alloc]init]; [self addSubview:self.bar];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat x = 14, h = self.height-18;
    
    CGFloat h1 = 0.25*h, h2 = 0.55*h, h3 = 0.2*h;
    self.assets.frame = CGRectMake(x, 0, self.width, h1);
    self.line1.frame = CGRectMake(0, self.assets.maxY, self.width, 1);
    CGFloat w = 0.5*self.width;
    self.marketVal.frame = CGRectMake(0, self.assets.maxY+1, w, h2/3);
    self.cash.frame = CGRectMake(self.marketVal.maxX, self.assets.maxY+1, w, h2/3);
    self.line2.frame = CGRectMake(0, self.cash.maxY, self.width, 1);

    self.arrears.frame = CGRectMake(0, self.marketVal.maxY+1, w, h2/3);
    self.frozen.frame = CGRectMake(self.marketVal.maxX, self.marketVal.maxY+1, w, h2/3);
    self.line3.frame = CGRectMake(0, self.frozen.maxY, self.width, 1);

    self.draw.frame = CGRectMake(0, self.arrears.maxY+1, w, h2/3);
    self.line4.frame = CGRectMake(0, self.draw.maxY, self.width, 7);

    self.bar.frame = CGRectMake(0, self.draw.maxY+10, self.width, h3);
    self.line5.frame = CGRectMake(0, self.bar.maxY, self.width, 7);
}
@end
