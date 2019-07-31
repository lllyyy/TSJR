//
//  JCLTradOpenCell.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/29.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradOpenCell.h"

@interface JCLTradOpenCell()
@property (nonatomic, weak) UIView *bg;
@end

@implementation JCLTradOpenCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCL_Bg_COL;
        self.bg = [JCLKitObj JCLView:self color:JCL_Bg_COL];
        self.icon = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:nil];
        self.text = [JCLKitObj JCLLable:self font:17 color:JCL_Text_COL alignment:0];
        self.subText = [JCLKitObj JCLLable:self font:13 color:JCLHexCol(@"#B9B9BC") alignment:0];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat lineH = 1;
    self.bg.frame = CGRectMake(0, 0, self.width, self.height - lineH);
    CGFloat wh = 0.66*self.height, y = 0.5*(self.bg.height-wh);
    self.icon.frame = CGRectMake(14, y, wh, wh);
    self.text.frame = CGRectMake(self.icon.maxX+10, y, self.width, 0.6*wh);
    self.subText.frame = CGRectMake(self.icon.maxX+10, self.text.maxY, self.width, 0.32*wh);
}
@end
