//
//  JCLHeaderBgView.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/28.
//  Copyright © 2017年 刘虎超. All rights reserved.
//

#import "JCLHeaderBgView.h"

@interface JCLHeaderBgView()
@property (nonatomic,strong) NSMutableArray *labArr;
@end

@implementation JCLHeaderBgView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        self.labArr=[NSMutableArray arrayWithCapacity:0];
        self.backgroundColor=JCLRGB(240, 240, 240);
    }
    return self;
}

- (void)setTitleArr:(NSArray *)titleArr
{
    _titleArr=titleArr;
    for (NSInteger i=0;i<_titleArr.count;i++)
    {
        UILabel *textLab=[LHCObject LHCLable:self size:14 Textcolor:[UIColor darkGrayColor] alignment:NSTextAlignmentCenter text:_titleArr[i]];
        [self.labArr addObject:textLab];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews]; 
    [self.labArr enumerateObjectsUsingBlock:^(UILabel *lab, NSUInteger idx, BOOL * _Nonnull stop) {
        lab.frame=CGRectMake(idx*JCLWIDTH/_titleArr.count, 0, JCLWIDTH/_titleArr.count-0.1, self.height);
    }];
}

- (void)setupHeaderArray:(NSArray *)array{
    UILabel *nameLab=[LHCObject LHCLable:self size:14 Textcolor:JCLRGB(102, 102, 102) alignment:NSTextAlignmentLeft text:array[0]];
    UILabel *timeLab=[LHCObject LHCLable:self size:14 Textcolor:JCLRGB(102, 102, 102) alignment:NSTextAlignmentLeft text:array[1]];
    UILabel *priceLab=[LHCObject LHCLable:self size:14 Textcolor:JCLRGB(102, 102, 102) alignment:NSTextAlignmentRight  text:array[2]];
    
    nameLab.frame=CGRectMake(20, 0, JCLWIDTH, [LHCObject height:35]);
    timeLab.frame=CGRectMake(0.5*JCLWIDTH+10, 0, JCLWIDTH, [LHCObject height:35]);
    priceLab.frame=CGRectMake(0, 0, JCLWIDTH-38, [LHCObject height:35]);
}

@end
