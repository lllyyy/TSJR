//
//  JCLLimitHeader.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/4/5.
//  Copyright © 2017年 刘虎超. All rights reserved.
//

#import "JCLLimitHeader.h"
#import "JCLHeaderBgView.h"

@interface JCLLimitHeader()
@property (nonatomic,strong) UIButton *sender;
@property (nonatomic,strong) NSArray *textArr;
@property (nonatomic,strong) NSMutableArray *lableArr;
//蓄势  冲关 封板三个比例
@property (nonatomic,strong) UILabel *xsLab;
@property (nonatomic,strong) UILabel *cgLab;
@property (nonatomic,strong) UILabel *fbLab;
@end

@implementation JCLLimitHeader

- (instancetype)init
{
    if(self=[super init]){
        self.backgroundColor=[UIColor whiteColor];
        self.textArr=@[@"蓄势",@"冲关",@"封板"];
        self.lableArr=[NSMutableArray arrayWithCapacity:0];
        [self drawView];
        [self drawLine];
        
        self.xsLab=[LHCObject LHCLable:self size:13 Textcolor:JCLRGB(22, 22, 22) alignment:NSTextAlignmentCenter text:@""];
        self.xsLab.frame=CGRectMake(0, 48,JCLWIDTH/3/2, 20);
        
        self.cgLab=[LHCObject LHCLable:self size:13 Textcolor:JCLRGB(22, 22, 22) alignment:NSTextAlignmentCenter text:@""];
        self.cgLab.frame=CGRectMake(JCLWIDTH/3, 48,JCLWIDTH/3/2, 20);
        
        self.fbLab=[LHCObject LHCLable:self size:13 Textcolor:JCLRGB(22, 22, 22) alignment:NSTextAlignmentCenter text:@""];
        self.fbLab.frame=CGRectMake(2*JCLWIDTH/3, 48,JCLWIDTH/3/2, 20);
    }
    return self;
}

- (void)drawView{
    JCLHeaderBgView *bgView=[[JCLHeaderBgView alloc]init];
    bgView.frame            = CGRectMake(0, [LHCObject height:40]+105, JCLWIDTH, [LHCObject height:35]);
    bgView.backgroundColor  = JCLRGB(243, 243, 243);
    [self addSubview:bgView];
    
    NSArray *titleArr=@[@"名称",@"涨跌幅",@"现价"];
    //涨跌幅排序按钮
    for (NSInteger i        = 0; i<titleArr.count; i++) {
    UIButton  *btn=[LHCObject LHCButton:bgView Img:@"" Title:titleArr[i] backgroundColor:nil Target:self Action:@selector(sortClick:)];
    btn.tag                 = i;
    btn.color=[UIColor darkGrayColor] ;
    CGFloat W=JCLWIDTH/titleArr.count;
    btn.titleLabel.font=[UIFont systemFontOfSize:[LHCObject LHCFont:15]];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    if(i==0)
    {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.frame               = CGRectMake(20, 0, W-8, bgView.height);
    }else{
        btn.frame               = CGRectMake(i*W, 0, W-8, bgView.height);
    }}
    
    
    for (NSInteger i=0;i<self.textArr.count;i++){
        UILabel *textLab=[LHCObject LHCLable:self size:17 Textcolor:JCLRGB(22, 22, 22) alignment:NSTextAlignmentCenter text:self.textArr[i]];
        textLab.frame=CGRectMake(i*JCLWIDTH/3, 15, JCLWIDTH/3, 25);
        //提示
        UILabel *textLab2=[LHCObject LHCLable:self size:12 Textcolor:JCLRGB(22, 22, 22) alignment:NSTextAlignmentCenter text:@"今日/昨日"];
        textLab2.frame=CGRectMake(i*JCLWIDTH/3, 72, JCLWIDTH/6, 25);
        //提示
        UILabel *textLab3=[LHCObject LHCLable:self size:12 Textcolor:JCLRGB(22, 22, 22) alignment:NSTextAlignmentCenter text:@"同比增幅"];
        textLab3.frame=CGRectMake(JCLWIDTH/6+i*JCLWIDTH/3, 72,JCLWIDTH/6 , 25);
        NSLog(@"frame=%@",NSStringFromCGRect(textLab2.frame));
    }
}
//涨停板--跌停打开栏目
- (void)setTitleArr:(NSArray *)titleArr
{
    _titleArr               = titleArr;
    for(NSInteger i         = 0;i<_titleArr.count;i++){
    UIButton *btn=[LHCObject LHCButton:self Img:@"" Title:_titleArr[i] backgroundColor:nil Target:self Action:@selector(headerAction:)];
    btn.titleLabel.font=[UIFont systemFontOfSize:[LHCObject LHCFont:15]];
    btn.tag                 = i;
    btn.frame               = CGRectMake(8+JCLWIDTH/4*i, 108, JCLWIDTH/4-16, [LHCObject height:32]);
    btn.layer.cornerRadius  = 7;
    btn.layer.masksToBounds = YES;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[self imageWithColor:JCLRGB(246, 77, 84)] forState:UIControlStateDisabled];
    if(i==0){
    btn.enabled             = NO;
    self.sender             = btn;
    }}}

//block回调  self.sortaction(1) 0升序 1降序
- (void)sortClick:(UIButton *)sender{
//    self.selectBtn.image    = @"";
//    sender.selected         = !sender.selected;
//    self.selectBtn          = sender;
//    if (self.selectBtn.selected == YES) {
//      self.selectBtn.image            = @"xia";
//      self.sortaction(1);
//    }else{
//      self.selectBtn.image            = @"shang";
//      self.sortaction(0);
//    }
}
//蓄势冲关封板三个比例
- (void)setNumberArr:(NSArray *)numberArr
{
    _numberArr=numberArr;
    if(_numberArr.count){
        self.xsLab.text=[NSString stringWithFormat:@"%@",_numberArr[0]];
        self.cgLab.text=[NSString stringWithFormat:@"%@",_numberArr[1]];
        self.fbLab.text=[NSString stringWithFormat:@"%@",_numberArr[2]];
    }
}

- (void)setDataArr:(NSArray *)dataArr
{
    [self.lableArr enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL * _Nonnull stop) {
        [label removeFromSuperview];
    }];
    [self.lableArr removeAllObjects];
    _dataArr=dataArr;
    for (NSInteger i=0;i<3;i++){
        UILabel *textLab=[LHCObject LHCLable:self size:13 Textcolor:JCLRGB(22, 22, 22) alignment:NSTextAlignmentRight text:@""];
        if(_dataArr.count){
          if([_dataArr[2*i+1] floatValue]==0.00)
          {
          textLab.text=@"--";
          }else{
           textLab.text=[NSString stringWithFormat:@"%.2lf%%",([_dataArr[2*i] floatValue]-[_dataArr[2*i+1] floatValue])/[_dataArr[2*i+1] floatValue]*100.0];
           textLab.textColor=[LHCObject Newprice:textLab.text Price:@"0.00"];
            if([textLab.text floatValue]>0.00){
                textLab.text=[NSString stringWithFormat:@"%@↑",textLab.text];
            }else{
                textLab.text=[NSString stringWithFormat:@"%@↓",textLab.text];
            }
              if([textLab.text floatValue]==0.00){
                  textLab.text=[NSString stringWithFormat:@"0.00%%"];
              }
          }
        }
        [self.lableArr addObject:textLab];
        //添加最上层按钮
        UIButton *btn=[LHCObject LHCButton:self Img:@"" Title:@"" backgroundColor:nil Target:self Action:@selector(btnAction:)];
        btn.tag=i;
        btn.frame=CGRectMake(JCLWIDTH/3*i, 0, JCLWIDTH/3, 100);
    }
}

- (void)btnAction:(UIButton *)sender{
    self.topaction(sender.tag);
}

- (void)headerAction:(UIButton *)sender{
    self.sender.enabled     = YES;
    sender.enabled          = NO;
    self.sender             = sender;
    self.action(sender.tag);
}

- (void)drawLine{
    
    UIView *bgView2=[LHCObject LHCView:self backgroundColor:JCLRGB(243, 243, 243)];
    bgView2.frame=CGRectMake(0, 100, JCLWIDTH, 5);
    
    UIView *line1=[LHCObject LHCView:self backgroundColor:JCLRGBA(220, 220, 220,0.8)];
    line1.frame=CGRectMake(0, 0, JCLWIDTH, 0.8);
    
    
    UIView *line2=[LHCObject LHCView:self backgroundColor:JCLRGBA(220, 220, 220,0.8)];
    line2.frame=CGRectMake(0, 100, JCLWIDTH, 0.8);
    
    UIView *line3=[LHCObject LHCView:self backgroundColor:JCLRGBA(220, 220, 220,0.8)];
    line3.frame=CGRectMake(0, 105, JCLWIDTH, 0.8);
    
    for(NSInteger i=0;i<3;i++) {
        UIView *line=[LHCObject LHCView:self backgroundColor:JCLRGBA(220, 220, 220,0.7)];
        line.frame=CGRectMake(JCLWIDTH/3*i, 18, 1, 75);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.lableArr enumerateObjectsUsingBlock:^(UILabel *lab, NSUInteger idx, BOOL * _Nonnull stop) {
        lab.frame=CGRectMake(0, 48,JCLWIDTH/3*(idx+1)-2 , 20);
    }];
}

//绘制背景View
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect             = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context    = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image          = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
