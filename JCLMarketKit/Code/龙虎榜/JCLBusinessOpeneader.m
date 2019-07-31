//
//  JCLBusinessOpeneader.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/4/14.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLBusinessOpeneader.h"

@implementation JCLBusinessOpeneader

- (instancetype)init
{
    if(self=[super init]){
        self.backgroundColor=[UIColor whiteColor];
        self.textLab = [LHCObject LHCLable:self size:15 Textcolor:[UIColor blackColor] alignment:NSTextAlignmentLeft text:@""];
        self.img=[LHCObject LHCImage:self Image:@"xialhb"];
        self.bg=[[JCLBillboardView alloc]init];
        self.bg.titleArr=@[@"股票名称",@"现价",@"涨跌幅"];
        [self addSubview:self.bg];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat H=[LHCObject height:50];
    self.textLab.frame=CGRectMake(15, 0, JCLWIDTH-80, H);
    self.textLab.centerY=H/2;
    self.img.frame=CGRectMake(JCLWIDTH-45, 0, 20, 20);
    self.img.centerY=H/2;
    
   UIView *bottomView=[LHCObject LHCView:self backgroundColor:JCLRGB(230, 230, 230)];
    bottomView.frame=CGRectMake(0, 0, JCLWIDTH, 0.8);
    self.bg.frame=CGRectMake(0, H, JCLWIDTH,self.height-H);
}

@end
