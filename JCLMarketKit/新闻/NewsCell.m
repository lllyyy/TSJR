//
//  NewsCell.m
//  JCLMarketKit
//
//  Created by apple on 2018/5/8.
//  Copyright © 2018年 邢昭俊. All rights reserved.
//

#import "NewsCell.h"
#import "NSDate+MMChat.h"
@implementation NewsCell


//+(instancetype)CellWithTableView:(UITableView *)tableView
//{
//    static NSString *ID=@"IdconsultCell2";
//    NewsCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
//    if(!cell){
//        cell=[[NewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
//    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    return cell;
//}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = JCL_Cell_COL;
//        self.titleLab = [LHCObject LHCLable:self size:17 Textcolor:[UIColor whiteColor] alignment:NSTextAlignmentLeft text:@""];
//
//        self.timeLab =   [LHCObject LHCLable:self size:14 Textcolor:JCLRGB(205, 205, 205) alignment:NSTextAlignmentLeft text:@""];
//
//        self.line = [LHCObject LHCView:self backgroundColor:JCLRGB(50, 50, 50)];
//        self.pic = [[UIImageView alloc]initWithFrame:CGRectMake(JCLWIDTH-135*JCLWIDTH/375, 25*JCLWIDTH/375, 120*JCLWIDTH/375, 80*JCLWIDTH/375)];
//        [self addSubview:self.pic];
        
        [self addSubview:self.titleLab];
        [self addSubview:self.titleLB];
        [self addSubview:self.timeLab];
        [self addSubview:self.line];
        [self addSubview:self.pic];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(JCLWIDTH-30-120-10);
        }];
        [self.pic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(70);
        }];
        [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-15);
            make.left.mas_equalTo(15);
            make.height.mas_equalTo(15);
        }];
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-15);
            make.left.mas_equalTo(self.titleLB.mas_right).offset(15);
            make.height.mas_equalTo(15);
        }];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    self.titleLab.frame=CGRectMake(15, [LHCObject height:12], JCLWIDTH-30-JCLWIDTH/3, 0);
//    [self.titleLab sizeToFit];
//    self.titleLab.numberOfLines=3;
//
//    self.timeLab.frame=CGRectMake(self.titleLab.x, self.height-26, JCLWIDTH, 26);
//
//    self.line.frame=CGRectMake(0, 0, JCLWIDTH, 0.7);
////    self.img.frame=CGRectMake(SCREEN_WIDTH/3*2+5, [LHCObject height:7], SCREEN_WIDTH/3-10, (SCREEN_WIDTH/3)*0.6);
////
////    self.img.centerY=self.height/2;
//}


-(UIImageView *)pic{
    if (!_pic) {
        _pic=[[UIImageView alloc]init];
        _pic.contentMode =  UIViewContentModeScaleAspectFill;
        _pic.layer.masksToBounds = YES;
    }
    return _pic;
}


-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.numberOfLines = 0;
        _titleLab.text=@"写在依稀回忆前：美联储3大重点抢先看";
    }
    return _titleLab;
}
-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.font = [UIFont systemFontOfSize:14];
        _timeLab.textColor = JCLAccountRGB;
        _timeLab.text = @"今天 15：11";
    }
    return _timeLab;
}
-(UILabel *)titleLB{
    if (!_titleLB) {
        _titleLB = [[UILabel alloc]init];
        _titleLB.font = [UIFont systemFontOfSize:14];
        _titleLB.textColor = JCLAccountRGB;
        _titleLB.text= @"新浪财经";
    }
    return _titleLB;
}
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
         _line.backgroundColor = JCL_Bg_COL;
    }
    return _line;
}

-(void)setData:(TSJRNewModel *)m{
    if (m.thumbs.count > 0) {
        [JCLFramework JCLWebImage:self.pic icon:m.thumbs[0]];
    }
  
 
    self.titleLab.text = [NSString stringWithFormat:@"%@",m.title];
    self.titleLB.text = [NSString stringWithFormat:@"%@",m.author];
    self.timeLab.text = [NSString stringWithFormat:@"%@",[JCLKitObj timeStampStringIn:m.timestamp].chatTimeInfo];
}

@end
