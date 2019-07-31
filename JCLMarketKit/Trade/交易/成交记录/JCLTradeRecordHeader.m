//
//  JCLTradeRecordHeader.m
//  JCLFutures
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018年 邢昭俊. All rights reserved.
//

#import "JCLTradeRecordHeader.h"

@implementation JCLTradeRecordHeader

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self =[super initWithFrame:frame]) {
        
        NSArray *array = @[@"合约名称",@"买卖",@"成交价",@"成交量",@"手续费",@"成交时间"];
        for (int i=0; i<array.count; i++) {
            
            UILabel *label = [JCLKitObj JCLLable:self font:14*JCLWIDTH/375 color:JCLRGB(120, 121, 125) alignment:1];
            label.text = array[i];
            label.frame = CGRectMake(i*(JCLWIDTH/6), 0, JCLWIDTH/6, 30*JCLWIDTH/375);
        }
        
    }
    
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
