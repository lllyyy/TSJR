//
//  XLDStockNavigation.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2016/11/25.
//  Copyright © 2016年 ruixue. All rights reserved.
//

#import "XLDStockNavigation.h"

@interface XLDStockNavigation()
@property (nonatomic, weak) UIView *bg;
@property (nonatomic, weak) UIButton *diss;
@end

@implementation XLDStockNavigation
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JCL_Bg_COL;
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        self.diss = [JCLKitObj JCLButton:self img:@"返回" size:14 target:self action:@selector(dissAction)];
        self.textLab = [JCLKitObj JCLLable:self font:18 color:[UIColor whiteColor] alignment:1];
        self.textLab.numberOfLines = 1;
        self.priceLab = [JCLKitObj JCLLable:self font:15 color:[UIColor whiteColor] alignment:1];
        self.rangeLab = [JCLKitObj JCLLable:self font:16 color:[UIColor whiteColor] alignment:1];
        self.scaleLab = [JCLKitObj JCLLable:self font:16 color:[UIColor whiteColor] alignment:1];
        self.numberLab = [JCLKitObj JCLLable:self font:13 color:[UIColor whiteColor] alignment:1];
        self.moneyLab = [JCLKitObj JCLLable:self font:13 color:[UIColor whiteColor] alignment:1];
    }
    return self;
}
-(void)dissAction{ self.dissActionBlock(); }

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.bg.frame = CGRectMake(0, 0, self.width, self.height-1);
    CGFloat y = 0, s = 10;
    self.diss.frame = CGRectMake(0, y, self.height - y, self.bg.height);
    
    CGSize textSize = [JCLKitObj JCLStrSize:self.textLab.text font:self.textLab.font];
    if (textSize.width > 0.5*self.width) {
        textSize.width = 0.5*self.width;
    }
    self.textLab.frame = CGRectMake(self.diss.maxX, y, textSize.width, self.bg.height);
    CGSize priceSize = [JCLKitObj JCLStrSize:self.priceLab.text font:self.priceLab.font];
    self.priceLab.frame = CGRectMake(self.textLab.maxX+s, y, priceSize.width, self.bg.height);
    self.rangeLab.frame = CGRectMake(self.priceLab.maxX, y, priceSize.width + s, self.bg.height);
    self.scaleLab.frame = CGRectMake(self.rangeLab.maxX, y, priceSize.width + s, self.bg.height);
    
    CGSize numberSize = [JCLKitObj JCLStrSize:@"量: 4444.44亿" font:self.numberLab.font];
    self.numberLab.frame = CGRectMake(self.priceLab.maxX+s, y, numberSize.width, self.bg.height);
    self.moneyLab.frame = CGRectMake(self.numberLab.maxX, y, numberSize.width + s, self.bg.height);
}
@end
