//
//  JCLHotspot.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/23.
//  Copyright © 2017年 刘虎超. All rights reserved.
//

#import "JCLHotspotCell.h"

@implementation JCLHotspotCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    return self;
}

+ (instancetype)CellWithTableView:(UITableView *)tableView{
    static NSString *ID=@"hotspotCell123";
    JCLHotspotCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
      cell=[[JCLHotspotCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)drawView{
    self.nameLab                 = [LHCObject LHCLable:self size:17 Textcolor:[UIColor blackColor] alignment:NSTextAlignmentLeft text:@"板块名"];
    UIView *line=[LHCObject LHCView:self backgroundColor:JCLRGB(240, 240, 240)];
    line.frame                   = CGRectMake(0, 0, JCLWIDTH, 1);
    self.rangeLab                = [LHCObject LHCLable:self size:16 Textcolor:[UIColor blackColor] alignment:NSTextAlignmentCenter text:@"1.05%"];
    self.stockrangelLab          = [LHCObject LHCLable:self size:15 Textcolor:[UIColor blackColor] alignment:NSTextAlignmentRight text:@"1.05%"];
    self.stocknameLab            = [LHCObject LHCLable:self size:16 Textcolor:[UIColor blackColor] alignment:NSTextAlignmentRight text:@"1.05%"];
    self.riseLab                 = [LHCObject LHCLable:self size:11 Textcolor:[UIColor whiteColor] alignment:NSTextAlignmentCenter text:@""];
    self.flatLab                 = [LHCObject LHCLable:self size:11 Textcolor:[UIColor whiteColor] alignment:NSTextAlignmentCenter text:@""];
    self.fallLab                 = [LHCObject LHCLable:self size:11 Textcolor:[UIColor whiteColor] alignment:NSTextAlignmentCenter text:@""];

    self.rangeLab.font           = [UIFont fontWithName:@"DINPro-Medium" size:[LHCObject LHCFont:17]];
    self.stockrangelLab.font     = [UIFont fontWithName:@"DINPro-Medium" size:[LHCObject LHCFont:15]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.nameLab.frame           = CGRectMake(25, 0, 0.5*JCLWIDTH, [LHCObject height:60]);
    self.rangeLab.frame          = CGRectMake(0.25*JCLWIDTH+5, 0, 0.25*JCLWIDTH, [LHCObject height:60]);
    self.stocknameLab.frame      = CGRectMake(0, 5, JCLWIDTH-15, ([LHCObject height:60]-5)/2);
    self.stockrangelLab.frame    = CGRectMake(0, [LHCObject height:60]/2-5, JCLWIDTH-15, [LHCObject height:60]/2);
}

- (void)setArray:(NSArray *)array
{
    _array                       = array;
    if(_array.count>10)
    {
    self.nameLab.text            = [NSString stringWithFormat:@"%@",_array[0]];
    self.stocknameLab.text       = _array[11];
    //板块的涨跌幅以及颜色
    NSString *price              = [NSString stringWithFormat:@"%.2lf", [array[2] floatValue]];
    NSString *cloce              = [NSString stringWithFormat:@"%@",_array[4]];
    
    if([price floatValue]==0.00){
        self.rangeLab.text=@"--";
        self.rangeLab.textColor=[UIColor blackColor];
    }else{
        self.rangeLab.text=[NSString stringWithFormat:@"%.2lf%%",([price floatValue]-[cloce floatValue])/[cloce floatValue]*100];
        self.rangeLab.textColor=[LHCObject Newprice:price Price:cloce];
    }
    //领先股票的涨跌幅
    NSString *price1=[NSString stringWithFormat:@"%.2lf", [_array[13] floatValue]];
    NSString *cloce1             = [NSString stringWithFormat:@"%@",_array[15]];
    self.stockrangelLab.text=[NSString stringWithFormat:@"%.2lf%%",([price1 floatValue]-[cloce1 floatValue])/[cloce1 floatValue]*100];
    self.stockrangelLab.textColor=[LHCObject Newprice:price1 Price:cloce1];
    if([self.stockrangelLab.text floatValue]<=0.00)
    {
        self.stockrangelLab.text=@"--";
        self.stocknameLab.text=@"--";
        self.stockrangelLab.textColor=[UIColor blackColor];
    }

        //涨
    self.riseLab.text            = [NSString stringWithFormat:@"%@",_array[8]];
        //平
    self.flatLab.text            = [NSString stringWithFormat:@"%@",_array[10]];
        //跌
    self.fallLab.text            = [NSString stringWithFormat:@"%@",_array[9]];

    self.riseLab.backgroundColor = JCLRGB(242, 72, 85);
    self.flatLab.backgroundColor = JCLRGB(212, 212, 212);
    self.fallLab.backgroundColor = JCLRGB(9, 201, 144);

    float length=[self.riseLab.text floatValue]+[self.flatLab.text floatValue]+[self.fallLab.text floatValue];
    if(length==0){
    self.riseLab.frame           = CGRectMake(0.5*JCLWIDTH, [LHCObject height:60]/3, 0, 20);
            
    self.flatLab.frame           = CGRectMake(self.riseLab.maxX,self.riseLab.y, 0, 20);
            
    self.fallLab.frame           = CGRectMake(self.flatLab.maxX,self.riseLab.y,0, 20);
        }else{
    self.riseLab.frame           = CGRectMake(0.5*JCLWIDTH, [LHCObject height:60]/3, 0.25*JCLWIDTH*([self.riseLab.text floatValue]/length), 20);

    self.flatLab.frame           = CGRectMake(self.riseLab.maxX,self.riseLab.y, 0.25*JCLWIDTH*([self.flatLab.text floatValue]/length), 20);

    self.fallLab.frame           = CGRectMake(self.flatLab.maxX,self.riseLab.y, 0.25*JCLWIDTH*([self.fallLab.text floatValue]/length), 20);
   }

    if([LHCObject LHCSize:_array[8] font:11].width+1.5>self.riseLab.width)
    {
        self.riseLab.text=@"";
    }

    if([LHCObject LHCSize:_array[10] font:11].width+1.5>self.flatLab.width)
    {
        self.flatLab.text=@"";
    }

    if([LHCObject LHCSize:_array[9] font:11].width+1.5>self.fallLab.width)
    {
        self.fallLab.text=@"";
    }
    }
}
@end
