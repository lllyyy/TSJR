//
//  JCLBusinessRankHeader.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/4/14.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLBusinessRankHeader.h"

@interface JCLBusinessRankHeader()
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UIView *bottomView;
@end

@implementation JCLBusinessRankHeader

- (instancetype)init
{
    if(self =[super init])
    {
        self.backgroundColor=JCLRGB(237, 237, 237);
        self.titleLab = [LHCObject LHCLable:self size:15 Textcolor:[UIColor blackColor] alignment:NSTextAlignmentLeft text:@""];
        self.topView=[LHCObject LHCView:self backgroundColor:JCLRGB(230, 230, 230)];
        self.bottomView=[LHCObject LHCView:self backgroundColor:JCLRGB(230, 230, 230)];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLab.frame=CGRectMake(20, 0, JCLWIDTH, self.height);
    self.topView.frame=CGRectMake(0, 0, JCLWIDTH, 0.6);
    self.bottomView.frame= CGRectMake(0, self.height-0.6, JCLWIDTH, 0.6);
}


@end
