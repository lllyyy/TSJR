//
//  JCLLimitCell.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/4/5.
//  Copyright © 2017年 刘虎超. All rights reserved.
//

#import "JCLLimitCell.h"

@implementation JCLLimitCell

+ (instancetype)CellWithTableView:(UITableView *)tableView{
    
    static NSString *ID=@"JCLLimitCell";
    JCLLimitCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell=[[JCLLimitCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    self.nameLab=[LHCObject LHCLable:self size:16 Textcolor:JCLRGB(65, 72, 82) alignment:NSTextAlignmentLeft text:@"代码"];
    self.codeLab=[LHCObject LHCLable:self size:14 Textcolor:JCLRGB(168,168,168) alignment:NSTextAlignmentLeft text:@"名字"];
    self.label1=[LHCObject LHCLable:self size:16 Textcolor:JCLRGB(65, 72, 82) alignment:NSTextAlignmentCenter text:@"121"];
    self.label2=[LHCObject LHCLable:self size:16 Textcolor:JCLRGB(65, 72, 82) alignment:NSTextAlignmentCenter text:@"121"];
    self.label1.font=[UIFont fontWithName:@"DINPro-Medium" size:[LHCObject LHCFont:16]];
    self.label2.font=[UIFont fontWithName:@"DINPro-Medium" size:[LHCObject LHCFont:16]];
    self.line = [LHCObject LHCView:self backgroundColor:JCLRGB(217, 217, 217)];
    self.line.alpha   = 0.55;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.nameLab.frame  = CGRectMake(20, 3, 0.25*JCLWIDTH, self.height/2-3);
    self.codeLab.frame  = CGRectMake(20, self.height/2-3, 0.25*JCLWIDTH, self.height/2);
    self.label1.frame   = CGRectMake(JCLWIDTH/3, 0, JCLWIDTH/3-8, self.height);
    self.label2.frame   = CGRectMake(JCLWIDTH/3*2, 0,JCLWIDTH/3-8, self.height);
    
    self.line.frame  = CGRectMake(0, self.height-0.8, JCLWIDTH, 0.8);
}

@end
