//
//  JCLBillboardTableViewCell.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/7.
//  Copyright © 2017年 ruixue. All rights reserved.
//

#import "JCLBillboardTableViewCell.h"

@implementation JCLBillboardTableViewCell

+ (instancetype)CellWithTableView:(UITableView *)tableView
{
    static NSString *ID=@"billboardCell";
    JCLBillboardTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        cell=[[JCLBillboardTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    return self;
}

- (void)drawView{
    self.stockNameLab=[LHCObject LHCLable:self text:@"" size:[LHCObject LHCFont:16] Textcolor:JCLRGB(63, 71, 84) alignment:NSTextAlignmentLeft];
    
    self.stockCodeLab=[LHCObject LHCLable:self text:@"" size:[LHCObject LHCFont:14] Textcolor:JCLRGB(168, 168, 168) alignment:NSTextAlignmentLeft];
    self.roseLab=[LHCObject LHCLable:self text:@"" size:[LHCObject LHCFont:17] Textcolor:JCLRGB(46, 46, 46) alignment:NSTextAlignmentCenter];
    
    self.moneyLab=[LHCObject LHCLable:self text:@"" size:[LHCObject LHCFont:17] Textcolor:JCLRGB(46, 46, 46) alignment:NSTextAlignmentRight];
    
    self.line=[LHCObject LHCView:self backgroundColor:[UIColor darkGrayColor]];
    self.line.alpha=0.1;
    
    self.roseLab.font=[UIFont fontWithName:@"DINPro-Medium" size:[LHCObject LHCFont:17]];
    self.moneyLab.font=[UIFont fontWithName:@"DINPro-Medium" size:[LHCObject LHCFont:17]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.line.frame=CGRectMake(0, self.height-1, JCLWIDTH, 1);
    self.roseLab.frame         =   CGRectMake(0, 0, JCLWIDTH, self.height);
    self.moneyLab.frame        =   CGRectMake(0, 0, JCLWIDTH-20, self.height);
    self.stockNameLab.frame    =   CGRectMake(15, 5, JCLWIDTH, self.height/2);
    self.stockCodeLab.frame    =   CGRectMake(15, self.height/2, JCLWIDTH, self.height/2-8);
    
}

@end

@implementation JCLBillboardRank
+ (instancetype)CellWithTableView:(UITableView *)tableView
{
    static NSString *ID=@"billboardRankCell";
    JCLBillboardRank *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        cell=[[JCLBillboardRank alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    return self;
}

- (void)drawView{
    
  self.nameLab  =  [LHCObject LHCLable:self text:@"方正证券股份" size:[LHCObject LHCFont:15] Textcolor:JCLRGB(127, 130, 135) alignment:NSTextAlignmentLeft];
  self.numberLab =  [LHCObject LHCLable:self text:@"10" size:[LHCObject LHCFont:17] Textcolor:JCLRGB(64, 71, 81) alignment:NSTextAlignmentRight];
  self.numberLab.font=[UIFont fontWithName:@"DINPro-Medium" size:[LHCObject LHCFont:17]];
    
  self.line=[LHCObject LHCView:self backgroundColor:[UIColor darkGrayColor]];
  self.line.alpha=0.1;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.nameLab.frame    =  CGRectMake(15, 0, JCLWIDTH*0.65+10, self.height);
    self.numberLab.frame  =  CGRectMake(0, 0, JCLWIDTH-30, self.height);
    self.line.frame=CGRectMake(0, self.height-1, JCLWIDTH, 1);
}
@end
