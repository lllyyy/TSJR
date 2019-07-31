//
//  JCLTradeRecordCell.m
//  JCLFutures
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018年 邢昭俊. All rights reserved.
//

#import "JCLTradeRecordCell.h"

@implementation JCLTradeRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self ==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.name = [JCLKitObj JCLLable:self font:13*JCLWIDTH/375 color:JCLRGB(255, 255, 255) alignment:1];
        self.name.text =@"原油1903";
        self.name.frame = CGRectMake(0, 15*JCLWIDTH/375, JCLWIDTH/6, 29*JCLWIDTH/375);
        
//        self.trade_kind = [JCLKitObj JCLLable:self font:11*JCLWIDTH/375 color:JCLRGB(255, 255, 255) alignment:1];
//        self.trade_kind.textColor = JCLRISERGB;
//        self.trade_kind.frame = CGRectMake(0, 30*JCLWIDTH/375, JCLWIDTH/6, 14*JCLWIDTH/375);
        
        self.trade_direction = [JCLKitObj JCLLable:self font:14*JCLWIDTH/375 color:JCLRGB(255, 255, 255) alignment:1];
        self.trade_direction.text =@"卖开";
        self.trade_direction.frame = CGRectMake(JCLWIDTH/6, 15*JCLWIDTH/375, JCLWIDTH/6, 29*JCLWIDTH/375);
        
        self.trade_price = [JCLKitObj JCLLable:self font:14*JCLWIDTH/375 color:JCLRGB(255, 255, 255) alignment:1];
        self.trade_price.text =@"1000.00";
        self.trade_price.frame = CGRectMake(JCLWIDTH/6*2, 15*JCLWIDTH/375, JCLWIDTH/6, 29*JCLWIDTH/375);
        
        self.trade_number = [JCLKitObj JCLLable:self font:14*JCLWIDTH/375 color:JCLRGB(255, 255, 255) alignment:1];
        self.trade_number.text =@"1000";
        self.trade_number.frame = CGRectMake(JCLWIDTH/6*3, 15*JCLWIDTH/375, JCLWIDTH/6, 29*JCLWIDTH/375);
        
        self.trade_fee = [JCLKitObj JCLLable:self font:13*JCLWIDTH/375 color:JCLRGB(255, 255, 255) alignment:1];
        self.trade_fee.text =@"100.00";
        self.trade_fee.frame = CGRectMake(JCLWIDTH/6*4, 10*JCLWIDTH/375, JCLWIDTH/6-10*JCLWIDTH/375, 39*JCLWIDTH/375);
        
        
        
        self.trade_time = [JCLKitObj JCLLable:self font:11*JCLWIDTH/375 color:JCLRGB(255, 255, 255) alignment:1];
        self.trade_time.text =@"19:50:50";
        self.trade_time.frame = CGRectMake(self.trade_fee.maxX, 0*JCLWIDTH/375, JCLWIDTH/6+10*JCLWIDTH/375, 59*JCLWIDTH/375);
        UIView *line = [JCLKitObj JCLView:self color:JCL_Bg_COL];
        line.frame = CGRectMake(0, 59*JCLWIDTH/375, JCLWIDTH, 1);
    }
    
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
