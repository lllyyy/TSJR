//
//  LHCNewMenuView.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/6/20.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "LHCNewMenuView.h"

@interface LHCNewMenuView()
//选中按钮
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) NSMutableArray *btnArr;
@end

@implementation LHCNewMenuView

- (instancetype)init
{
    if(self=[super init]){
        self.backgroundColor = [UIColor whiteColor];
        self.btnArr=[NSMutableArray arrayWithCapacity:0];
        self.showsHorizontalScrollIndicator=NO;
    }
    return self;
}

- (void)setTitleArr:(NSArray *)titleArr
{
    _titleArr = titleArr;
    for(NSInteger i               = 0;i<self.titleArr.count;i++)
    {
        UIButton *btn=[LHCObject LHCButton:self Img:nil Title:self.titleArr[i] backgroundColor:[UIColor whiteColor] Target:self Action:@selector(titleClick:) ];
        btn.tag                       = i;
        btn.titleLabel.font=[UIFont systemFontOfSize:[LHCObject LHCFont:16]];
        [btn setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"anniu_select"] forState:UIControlStateDisabled];
        [btn setBackgroundImage:[UIImage imageNamed:@"anniu_nor1"] forState:UIControlStateNormal];
        //这里按钮选中的字体颜色
        btn.backgroundColor=[UIColor whiteColor];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btnArr addObject:btn];
        if(i==0){
            btn.enabled                   = NO;
            self.selectedBtn              = btn;
            //让按钮内部的label根据文字内容来计算尺寸
            [btn.titleLabel sizeToFit];
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.btnArr enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        btn.frame=CGRectMake(7+(idx*(0.25*JCLWIDTH)), 5, 0.25*JCLWIDTH-15, self.height-10);
        if(idx==0){
           self.selectedBtn.frame=btn.frame;
        }
    }];
}

- (void)titleClick:(UIButton *)sender{
    if([sender.currentTitle isEqualToString:@" "]){return;}
    //block回调
    self.ChangeBlock(sender.tag);
    self.selectedBtn.enabled      = YES;
    sender.enabled                = NO;
    self.selectedBtn              = sender;
    
    if(self.titleArr.count>4){
        CGRect  rect = sender.frame;
        CGFloat midX = CGRectGetMidX(rect);
        CGFloat offset = 0;
        CGFloat contentWidth = self.contentSize.width;
        CGFloat halfWidth = CGRectGetWidth(self.bounds) / 2.0;
        
        if (midX < halfWidth) {
            offset = 0;
        } else if (midX > contentWidth - halfWidth) {
            offset = contentWidth - 2 * halfWidth;
        } else {
            offset = midX - halfWidth;
        }
        [self setContentOffset:CGPointMake(offset, 0) animated:YES];
    }
}

@end

