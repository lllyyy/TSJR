//
//  HQMarketHeader.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/8/17.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLNaviMenu.h"

@interface JCLNaviMenu()<UIScrollViewDelegate>
@property (nonatomic, weak) UIButton *his;
@end

@implementation JCLNaviMenu
-(instancetype)init{
    if (self = [super init]){
        self.backgroundColor = JCL_Bg_COL;
        self.scroll = [[UIScrollView alloc]init]; [self addSubview:self.scroll];
        self.scroll.backgroundColor = JCL_Cell_COL;
        self.scroll.delegate = self;
    }
    return self;
}

-(void)setArr:(NSArray *)arr{
    _arr = arr;
    
    self.scroll.frame = CGRectMake(0, 0, self.width, self.height-1.4);
    if (self.isLine) {
        self.layer.cornerRadius = 0.44*self.height;
        self.layer.borderWidth = 1.2;
        self.layer.borderColor = JCLRGB(206, 206, 206).CGColor;
        self.scroll.frame = CGRectMake(0, 0, self.width, self.height);
    }
    CGFloat w = self.width/arr.count;
    self.scroll.contentSize = CGSizeMake(w * arr.count, 0);
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [JCLKitObj JCLButton:self.scroll img:@"" size:14 target:self action:@selector(menuAction:)];
        button.title = obj; button.tag = idx;
        button.color = JCL_Text_COL;
        button.frame = CGRectMake(idx*w, 0, w, self.scroll.height);
        if (idx == 0) { self.his = button; }
    }];
    
    [self menuAction:self.his];
}

-(void)menuAction:(UIButton *)sender{
    if (self.isLine) {
        self.his.layer.borderWidth = 0;
        sender.layer.cornerRadius = 0.44*self.height;
        sender.layer.borderWidth = 1.2;
        sender.layer.borderColor = JCLRGB(206, 206, 206).CGColor;
    }
    self.his.color = JCL_Text_COL; sender.color = JCL_SelText_COL;

    self.his.enabled = YES; sender.enabled = NO;
    self.his = sender;
    !self.menuActionBlock ? : self.menuActionBlock(sender);
}
@end
