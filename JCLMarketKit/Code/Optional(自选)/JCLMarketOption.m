//
//  JCLMarketOption.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/24.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLMarketOption.h"

@interface JCLMarketOption()
@property (nonatomic, weak) UIButton *delete;
@end

@implementation JCLMarketOption
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JCL_Cell_COL;
        self.select = [JCLKitObj JCLButton:self img:@"buxuan" size:14 target:self action:@selector(selectAction:)];
        self.select.title = @"全选"; self.select.color = JCL_Text_COL;
        [self.select setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 8, 0.0, 0.0)];
        self.delete = [JCLKitObj JCLButton:self img:@"delete" size:14 target:self action:@selector(deleteAction)];
        self.delete.backgroundColor = [UIColor redColor]; self.delete.title = @"删除";
        [self.delete setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 8, 0.0, 0.0)];
        self.delete.layer.cornerRadius = 6;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = iPhone6Plus ? 0.156*self.width : 0.18*self.width;
    self.select.frame = CGRectMake(8, 0, w, self.height);
    CGFloat x = self.width - w - 14, h = 0.7*self.height, y = 0.5*(self.height - h);
    self.delete.frame = CGRectMake(x, y, w, h);
}

-(void)selectAction:(UIButton *)sender{ sender.selected = !sender.selected; !self.selectActionBlock ? : self.selectActionBlock(sender); }
-(void)deleteAction{ !self.deleteActionBlock ? : self.deleteActionBlock(); }
@end
