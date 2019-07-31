//
//  JCLStockIdxCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/11/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "JCLStockIdxCell.h"

@interface JCLStockIdxCell()
@property(nonatomic, weak) UIView *bg;
@end

@implementation JCLStockIdxCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JCL_Bg_COL;
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        self.code = [YSKitObj YSLable:self size:14 color:JCL_Text_COL alignment:1 style:0];
        self.price = [YSKitObj YSLable:self size:14 color:JCL_Text_COL alignment:1 style:0];
        self.range = [YSKitObj YSLable:self size:14 color:JCL_Text_COL alignment:1 style:0];
        self.scale = [YSKitObj YSLable:self size:14 color:JCL_Text_COL alignment:1 style:0];
        self.action = [JCLKitObj JCLButton:self img:@"向上折叠" size:14 target:self action:nil];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.action.frame = CGRectMake(self.width-self.height, 0, self.bg.height, self.bg.height);
    CGFloat x = 14, w = 0.25*(self.width-self.bg.height-x);
    self.code.frame = CGRectMake(x, 0, w, self.bg.height);
    self.price.frame = CGRectMake(self.code.maxX, 0, w, self.bg.height);
    self.range.frame = CGRectMake(self.price.maxX, 0, w, self.bg.height);
    self.scale.frame = CGRectMake(self.range.maxX, 0, w, self.bg.height);
}
@end
