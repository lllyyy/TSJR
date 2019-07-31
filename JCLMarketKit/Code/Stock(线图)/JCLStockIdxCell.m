//
//  JCLStockIdxCell.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/20.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockIdxCell.h"

@interface JCLStockIdxCell()
@property(nonatomic, weak) UIView *bg;
@end

@implementation JCLStockIdxCell
-(instancetype)init{
    if (self = [super init]){
        self.backgroundColor = JCL_Bg_COL;
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        
        JCLNaviMenu *menu = [[JCLNaviMenu alloc]init]; [self addSubview:menu];
        menu.isLine = YES;
        self.menu = menu;
        
        JCLTimeChart *time = [[JCLTimeChart alloc]init]; [self addSubview:time];
        self.time = time;

        self.code = [YSKitObj YSLable:self size:14 color:JCL_Text_COL alignment:0 style:0];
        self.price = [YSKitObj YSLable:self size:14 color:JCL_Text_COL alignment:0 style:0];
        self.range = [YSKitObj YSLable:self size:14 color:JCL_Text_COL alignment:0 style:0];
        self.scale = [YSKitObj YSLable:self size:14 color:JCL_Text_COL alignment:0 style:0];
        self.vol = [YSKitObj YSLable:self size:14 color:JCL_Text_COL alignment:0 style:0];

        self.rise = [YSKitObj YSLable:self size:14 color:JCL_Text_COL alignment:0 style:0];
        self.flat = [YSKitObj YSLable:self size:14 color:JCL_Text_COL alignment:0 style:0];
        self.fall = [YSKitObj YSLable:self size:14 color:JCL_Text_COL alignment:0 style:0];

        self.price.text = @"--"; self.range.text = @"--"; self.scale.text = @"--";
        self.rise.text = @"--"; self.flat.text = @"--"; self.fall.text = @"--";
        
        self.action = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:nil];
    }
    return self;
}

-(void)setIsDetails:(BOOL)isDetails{
    _isDetails = isDetails;
    self.bg.frame = CGRectMake(0, 0, self.width, self.height-1);
    if (isDetails) {
        self.menu.frame = CGRectMake(0, 0, self.width-self.menu.height, 40);

        self.action.frame = CGRectMake(self.width-self.menu.height, 0, self.menu.height, self.menu.height);
        CGFloat s = 6;
        self.time.frame = CGRectMake(s, self.menu.maxY + s, 0.6*self.width, self.bg.height - self.menu.maxY - 2*s);
        CGFloat h = self.time.height/7;
        self.code.frame = CGRectMake(self.time.maxX+s, self.time.y, self.width, h);
        self.price.frame = CGRectMake(self.time.maxX+s, self.code.maxY, self.width, h);
        self.range.frame = CGRectMake(self.time.maxX+s, self.price.maxY, self.width, h);
        self.vol.frame = CGRectMake(self.time.maxX+s, self.range.maxY, self.width, h);
        self.rise.frame = CGRectMake(self.time.maxX+s, self.vol.maxY, self.width, h);
        self.flat.frame = CGRectMake(self.time.maxX+s, self.rise.maxY, self.width, h);
        self.fall.frame = CGRectMake(self.time.maxX+s, self.flat.maxY, self.width, h);
    } else {
        self.action.frame = CGRectMake(self.width-self.height, 0, self.bg.height, self.bg.height);
        CGFloat x = 14, w = 0.25*(self.width-self.bg.height-x);
        self.code.frame = CGRectMake(x, 0, w, self.bg.height);
        self.price.frame = CGRectMake(self.code.maxX, 0, w, self.bg.height);
        self.range.frame = CGRectMake(self.price.maxX, 0, w, self.bg.height);
        self.scale.frame = CGRectMake(self.range.maxX, 0, w, self.bg.height);
    }
}
@end
