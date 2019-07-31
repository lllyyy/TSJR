//
//  JCLStockDraw.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/8/28.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockDraw.h"

@implementation JCLStockDraw

-(instancetype)init{
    if (self == [super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSArray *icons = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"];
    CGFloat w = self.width/icons.count;
    [icons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:@selector(buttonAction:)];
        button.tag = idx;
        button.title = obj;
        button.color = [UIColor redColor];
        button.frame = CGRectMake(idx*w, 0, w, self.height);
    }];
}

-(void)buttonAction:(UIButton *)sender{
    !self.buttonActionBlock ? : self.buttonActionBlock(sender.tag);
}
@end
