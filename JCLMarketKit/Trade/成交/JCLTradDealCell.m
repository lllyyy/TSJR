//
//  JCLTradDealCell.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/10.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradDealCell.h"

@interface JCLTradDealCell()
@property (nonatomic, weak) UIView *bg;
@property (nonatomic, weak) UIView *line;
@end

@implementation JCLTradDealCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCL_Bg_COL;
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        self.bg.layer.cornerRadius = 4;
        self.bs = [JCLKitObj JCLLable:self.bg font:14 color:JCL_Text_COL alignment:1];
        self.bs.layer.cornerRadius = 6;
        self.code = [JCLKitObj JCLLable:self.bg font:14 color:JCL_Text_COL alignment:0];
        
        self.time = [JCLKitObj JCLLable:self.bg font:14 color:JCL_Text_COL alignment:0];
        self.price = [JCLKitObj JCLLable:self.bg font:14 color:JCL_Text_COL alignment:0];
        self.num = [JCLKitObj JCLLable:self.bg font:14 color:JCL_Text_COL alignment:0];
        self.money = [JCLKitObj JCLLable:self.bg font:14 color:JCL_Text_COL alignment:0];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat x = 14, y = 14, h = (self.bg.height-2*y);
    self.bg.frame = CGRectMake(x, 0, self.width-2*x, self.height - y);
    CGSize size = [JCLKitObj JCLTextSize:@"4444" font:self.bs.font];
    CGFloat bsH = size.height+6;
    self.bs.frame = CGRectMake(x, 0.5*(h/4-bsH)+y, size.width+10, bsH);
    self.code.frame = CGRectMake(self.bs.maxX+10, y, self.width, h/4);
    
    self.time.frame = CGRectMake(x, self.code.maxY, self.width, h/4);
    CGFloat w = (self.bg.width-2*x)/3;
    self.price.frame = CGRectMake(x, self.time.maxY, w, h/2);
    self.num.frame = CGRectMake(self.price.maxX, self.time.maxY, w, h/2);
    self.money.frame = CGRectMake(self.num.maxX, self.time.maxY, w, h/2);
}
@end
