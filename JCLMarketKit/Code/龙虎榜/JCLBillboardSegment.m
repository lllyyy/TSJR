//
//  JCLBillboardSegment.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/6.
//  Copyright © 2017年 ruixue. All rights reserved.
//

#import "JCLBillboardSegment.h"

@interface JCLBillboardSegment()
@property(nonatomic,strong)UISegmentedControl *segment;
@end

@implementation JCLBillboardSegment

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        self.segment=[[UISegmentedControl alloc]init];
    }
    return self;
}

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray=titleArray;
    self.segment=[[UISegmentedControl alloc]initWithItems:titleArray];
    self.segment.tintColor=[UIColor darkGrayColor];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:[LHCObject LHCFont:14]],NSFontAttributeName,nil];
    [self.segment setTitleTextAttributes:dic forState:UIControlStateSelected];
    [self.segment setTitleTextAttributes:dic forState:UIControlStateNormal];
    [self addSubview:self.segment];
    [self.segment addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)setSelectIdx:(NSInteger)selectIdx
{
    _selectIdx=selectIdx;
    self.segment.selectedSegmentIndex=selectIdx;
}

- (void)segmentChange:(UISegmentedControl*)segment{
    self.block(segment);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.segment.frame=self.bounds;
}

@end
