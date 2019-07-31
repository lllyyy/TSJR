//
//  JCLTradEntrustCell.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/10.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradEntrustCell.h"

@interface JCLTradEntrustCell()
@property (nonatomic, weak) UIView *bg;
@end

@implementation JCLTradEntrustCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCL_Bg_COL;
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        self.bs = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:1];
        self.bs.layer.cornerRadius = 6;
        self.code = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:0];
        self.time = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:2];
        
        self.priceW = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:0];
        self.numW = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:0];
        self.priceC = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:0];
        self.numC = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:0];
        self.order = [JCLKitObj JCLLable:self font:14 color:nil alignment:1];
        self.order.backgroundColor = JCLHexCol(@"#D4D5D4"); self.order.layer.cornerRadius = 6;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat lineH = 1.4;
    self.bg.frame = CGRectMake(0, 0, self.width, self.height - lineH);
    CGFloat x = 14, y = 10, h = (self.bg.height-2*y);
    CGSize size = [JCLKitObj JCLTextSize:@"4444" font:self.bs.font];
    CGFloat codeH = 0.4*h;
    self.bs.frame = CGRectMake(x, y+0.5*(codeH-size.height-y), size.width+y, size.height+y);
    self.code.frame = CGRectMake(self.bs.maxX+x, y, self.width, codeH);
    self.time.frame = CGRectMake(0, y, self.width-x, codeH);
    
    CGFloat infoH = 0.6*h;
    self.order.frame = CGRectMake(self.width-(size.width+y)-x, self.code.maxY+0.5*(infoH-size.height+y), size.width+y, size.height+y);
    CGFloat infoW = self.order.x-2*x;
    self.priceW.frame = CGRectMake(x, self.code.maxY, 0.5*infoW, 0.5*infoH);
    self.numW.frame = CGRectMake(x, self.priceW.maxY, 0.5*infoW, 0.5*infoH);
    self.priceC.frame = CGRectMake(self.priceW.maxX, self.code.maxY, 0.5*infoW, 0.5*infoH);
    self.numC.frame = CGRectMake(self.priceW.maxX, self.priceW.maxY, 0.5*infoW, 0.5*infoH);
}
@end
