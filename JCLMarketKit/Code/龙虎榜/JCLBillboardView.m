//
//  JCLBillboardView.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/6.
//  Copyright © 2017年 ruixue. All rights reserved.
//

#import "JCLBillboardView.h"

@interface JCLBillboardView()

@end

@implementation JCLBillboardView

- (instancetype)init
{
    if(self=[super init])
    {
        [self drawView];
        self.backgroundColor=JCLRGB(240, 240, 240);
    }
    return self;
}

- (void)drawView{
    self.nameLabel=[LHCObject LHCLable:self text:@"股票名称" size:[LHCObject LHCFont:15] Textcolor:JCLRGB(46, 46, 46) alignment:NSTextAlignmentLeft];

    self.roseLabel=[LHCObject LHCLable:self text:@"涨幅" size:[LHCObject LHCFont:15] Textcolor:JCLRGB(46, 46, 46) alignment:NSTextAlignmentCenter];
    self.moneyLabel=[LHCObject LHCLable:self text:@"净买入额(元)" size:[LHCObject LHCFont:15] Textcolor:JCLRGB(46, 46, 46) alignment:NSTextAlignmentRight];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.nameLabel.frame    =   CGRectMake(20, 0, 120, self.height);
    self.roseLabel.frame    =   CGRectMake(0, 0, JCLWIDTH, self.height);
    self.moneyLabel.frame   =   CGRectMake(0, 0, JCLWIDTH-25, self.height);
}

- (void)setTitleArr:(NSArray *)titleArr
{
    _titleArr=titleArr;
    self.nameLabel.text=[NSString stringWithFormat:@"%@",_titleArr[0]];
    self.roseLabel.text=[NSString stringWithFormat:@"%@",_titleArr[1]];
    self.moneyLabel.text=[NSString stringWithFormat:@"%@",_titleArr[2]];
}

@end
