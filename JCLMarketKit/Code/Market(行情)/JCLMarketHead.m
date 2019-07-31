//
//  QuotationTableHeader.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/9/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "JCLMarketHead.h"

@interface JCLMarketHead()
@property (nonatomic, weak) UIView *bg;
@end

@implementation JCLMarketHead
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JCL_Bg_COL;
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        
        self.title = [JCLKitObj JCLButton:self img:@"zhankai" size:14 target:self action:@selector(infoAction:)];
        self.title.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.title.color = JCL_Text_COL;
        [self.title setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 4, 0.0, 0)];
        
        self.more = [JCLKitObj JCLButton:self img:@"下一页" size:26 target:self action:nil];
        self.more.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat topS = 0, buttomS = 2, spacing = 14;
    self.bg.frame = CGRectMake(0, topS, self.width, self.height - topS - buttomS);
    self.title.frame = CGRectMake(spacing, 0, 0.7*self.bg.width, self.bg.height);
    self.more.frame = CGRectMake(self.title.maxX, 0, 0.3*self.bg.width - 2*spacing, self.bg.height);
}

-(void)infoAction:(UIButton *)sender{ sender.selected = !sender.selected; !self.infoActionBlock ? : self.infoActionBlock(sender); }
@end
