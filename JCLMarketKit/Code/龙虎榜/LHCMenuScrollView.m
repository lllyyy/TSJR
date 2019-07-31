//
//  LHCMenuScrollView.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/4/26.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "LHCMenuScrollView.h"

@interface LHCMenuScrollView()
@property (nonatomic, strong) UIView *indicatorView;
//选中按钮
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) NSMutableArray *btnArr;
@end

@implementation LHCMenuScrollView

- (instancetype)init
{
    if(self=[super init]){
        self.btnArr=[NSMutableArray arrayWithCapacity:0];
        self.indicatorView = [LHCObject LHCView:self backgroundColor:[UIColor redColor]];
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
        //这里按钮选中的字体颜色
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
       btn.frame=CGRectMake(idx*0.25*JCLWIDTH, 0, 0.25*JCLWIDTH, self.height-4);
        if(idx==0){
            self.selectedBtn.frame=btn.frame;
        }
    }];
    
    self.indicatorView.backgroundColor = [UIColor redColor];
    self.indicatorView.height          = 3;
    self.indicatorView.width      = [LHCObject LHCSize:self.selectedBtn.currentTitle font:[LHCObject LHCFont:16]].width;
    self.indicatorView.centerX    = self.selectedBtn.centerX;
    self.indicatorView.y=self.height-3;
    
}

- (void)titleClick:(UIButton *)sender{
    if([sender.currentTitle isEqualToString:@" "]){return;}
    //block回调
    self.ChangeBlock(sender.tag);
    self.selectedBtn.enabled      = YES;
    sender.enabled                = NO;
    self.selectedBtn              = sender;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width      = [LHCObject LHCSize:sender.currentTitle font:[LHCObject LHCFont:16]].width;
        self.indicatorView.centerX    = self.selectedBtn.centerX;
    }];
    
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
