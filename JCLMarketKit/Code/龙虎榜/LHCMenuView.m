//
//  LHCMenuView.m
//  封装MenuView
//
//  Created by  on 2017/2/20.
//  Copyright © 2017年 . All rights reserved.
//

#import "LHCMenuView.h"

#import "LHCObject.h"
@interface LHCMenuView()
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,assign)CGFloat Lineheight;
@property(nonatomic,assign)UIColor *color;
@property (nonatomic, strong) UIView *titlesView;
@property (nonatomic, strong) UIView *indicatorView;
@property(nonatomic,assign)NSInteger idx;
@end

@implementation LHCMenuView


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self drawView];
}

+ (LHCMenuView *)MenuViewTitleArray:(NSArray *)array SelectLineHeight:(CGFloat)height SelectLineColor:(UIColor *)color Selectidx:(NSUInteger)idx Blcok:(MenuChangeBlock)block
{
        LHCMenuView *menuView=[[LHCMenuView alloc]init];
        menuView.titleArray = array;
        menuView.Lineheight = height;
        menuView.color      = color;
        menuView.idx        = idx;
        menuView.block      = block;
        return menuView;
}
    
- (void)drawView
{
    //标签栏整体
    UIView *titlesView=[[UIView alloc]init];
    titlesView.width              = self.width;
    titlesView.height             = self.height;
    titlesView.y                  = 0;
    [self addSubview:titlesView];
    self.titlesView               = titlesView;
    //底部的lineView
    self.lineView=[[UIView alloc]init];
    [titlesView addSubview:self.lineView];
    self.lineView.frame                    = CGRectMake(0, self.height-1, self.width, 1);
    if(self.Lineheight==4.1 || self.Lineheight==0)
    {
    self.lineView.hidden                   = YES;
    }
    self.lineView.backgroundColor=[UIColor lightGrayColor];
    self.lineView.alpha                    = 0.2;
    for(NSInteger i               = 0;i<self.titleArray.count;i++)
    {
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag                       = i;
    btn.titleLabel.font=[UIFont systemFontOfSize:[LHCObject LHCFont:16]];
    btn.height                    = titlesView.height;
    btn.width                     = titlesView.width/self.titleArray.count;
    btn.x                         = i*titlesView.width/self.titleArray.count;
    [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
    //这里按钮选中的字体颜色
    [btn setTitleColor:self.color forState:UIControlStateDisabled];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    if(self.isBgImg){
        self.lineView.hidden=YES;
        [btn setBackgroundImage:[UIImage imageNamed:@"bjt"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"sjbj"] forState:UIControlStateDisabled];
        btn.imageView.backgroundColor = [UIColor whiteColor];
    }
        
    [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    [titlesView addSubview:btn];
    if(i==self.idx)
    {
    btn.enabled                   = NO;
    self.selectedBtn              = btn;
    //让按钮内部的label根据文字内容来计算尺寸
    [btn.titleLabel sizeToFit];
    //底部的红色指示器
    self.indicatorView = [[UIView alloc]init];
    self.indicatorView.backgroundColor = self.color;
    self.indicatorView.height          = self.Lineheight;
    self.indicatorView.y               = titlesView.height-self.indicatorView.height;
    self.indicatorView.width      = [LHCObject LHCSize:self.selectedBtn.currentTitle font:[LHCObject LHCFont:16]].width;
    self.indicatorView.centerX    = self.selectedBtn.centerX;
    }}
    [titlesView addSubview:self.indicatorView];
}

//按钮点击事件
- (void)titleClick:(UIButton *)sender
{
    self.selectedBtn.enabled      = YES;
    sender.enabled                = NO;
    self.selectedBtn              = sender;
    //blcok点击相应
    self.block(sender);
    [UIView animateWithDuration:0.25 animations:^{
    self.indicatorView.width      = [LHCObject LHCSize:sender.currentTitle font:[LHCObject LHCFont:16]].width;
    self.indicatorView.centerX    = self.selectedBtn.centerX;
    }];
}
@end
