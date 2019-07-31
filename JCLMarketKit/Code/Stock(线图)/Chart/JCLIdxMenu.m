//
//  JCLIdxMenu.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/6/15.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLIdxMenu.h"

@implementation JCLIdxMenu
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 6; self.layer.borderWidth = 1; self.layer.borderColor = JCLRGBA(216, 216, 216, 1).CGColor;
    }
    return self;
}

-(void)setArr:(NSArray *)arr{
    _arr = arr;
    
    CGFloat w = self.width/2, h = self.height/5;
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *info = [JCLKitObj JCLButton:self img:@"" size:13 target:self action:@selector(action:)];
        CGFloat x = w *(idx % 2), y = h *(idx / 2); info.tag = idx; info.title = obj; info.color = [UIColor blackColor];
        info.frame = CGRectMake(x, y, w, h);
    }];
}

-(void)action:(UIButton *)sender{ !self.actionBlock ? : self.actionBlock(sender.tag); }
@end
