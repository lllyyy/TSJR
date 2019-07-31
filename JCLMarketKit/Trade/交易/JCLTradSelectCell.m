//
//  JCLTradSelectCell.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/14.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradSelectCell.h"

@interface JCLTradSelectCell()
@property (nonatomic, weak) UIView *bg;
@property (nonatomic, weak) UIButton *icon;
@end

@implementation JCLTradSelectCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCL_Bg_COL;
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        self.text = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:0];
        self.icon = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:nil];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat lineH = 1.4;
    self.bg.frame = CGRectMake(0, 0, self.width, self.height - lineH);
    self.text.frame = CGRectMake(14, 0, self.width, self.bg.height);
    self.icon.frame = CGRectMake(self.width-self.bg.height, 0, self.bg.height, self.bg.height);
}
@end
