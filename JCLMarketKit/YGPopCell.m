//
//  YGMenuCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/6/6.
//  Copyright © 2017年 邢昭俊. All rights reserved.

#import "YGPopCell.h"

@interface YGPopCell()
@property (nonatomic, weak) UIView *bg;
@end


@implementation YGPopCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCLBGRGB;
        self.bg = [JCLKitObj JCLView:self color:[UIColor whiteColor]];
        self.text = [JCLKitObj JCLLable:self font:14 color:nil alignment:1];
        self.select = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:nil];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat lineH = 1.4;
    self.bg.frame = CGRectMake(0, 0, self.width, self.height - lineH);
    self.text.frame = self.bg.frame;
    self.select.frame = CGRectMake(self.width-self.bg.height, 0, self.bg.height, self.bg.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
