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
@property (nonatomic, strong) NSMutableArray *vals;
@property (nonatomic, weak) UIView *line;
@end

@implementation JCLNaviMenu
-(instancetype)init{
    if (self = [super init]){
        self.backgroundColor = JCL_Bg_COL;
        self.scroll = [[UIScrollView alloc]init]; [self addSubview:self.scroll];
        self.scroll.backgroundColor = JCL_Cell_COL;
        self.scroll.delegate = self;
        self.vals = [[NSMutableArray alloc]init];
        self.line = [JCLKitObj JCLView:self color:JCL_SelText_COL];
    }
    return self;
}

-(void)setArr:(NSArray *)arr{
    _arr = arr;
    
    if (self.vals.count && arr.count) {
        [self.vals enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.title = arr[idx];
        }];
    } else {
        self.scroll.frame = CGRectMake(0, 0, self.width, self.height-1);
        CGFloat w = self.width/arr.count;
        self.scroll.contentSize = CGSizeMake(w * arr.count, 0);
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = [JCLKitObj JCLButton:self.scroll img:@"" size:14 target:self action:@selector(menuAction:)];
            button.title = obj; button.tag = idx;
            button.color = JCL_Text_COL;
            button.frame = CGRectMake(idx*w, 0, w, self.scroll.height);
            if (idx == self.idx) { self.his = button; }
        }];
        
        [self menuAction:self.his];
    }
}

-(void)menuAction:(UIButton *)sender{
    if (self.isLine) {
        CGFloat w = self.width/self.arr.count;
        self.line.frame = CGRectMake(sender.tag*w+0.5*(w - 66), self.scroll.height-1, 66, 1);
    }
    self.his.color = JCL_Text_COL; sender.color = JCL_SelText_COL;

    self.his.enabled = YES; sender.enabled = NO;
    self.his = sender;
    !self.menuActionBlock ? : self.menuActionBlock(sender);
}
@end
