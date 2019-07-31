//
//  JCLMarketRankCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/27.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLMarketRankCell.h"

@interface JCLMarketRankCell()
@property (nonatomic, weak) UIView *bg;
@end

@implementation JCLMarketRankCell
+ (instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style{
    static NSString *ID = @"MarketRankCell";
    JCLMarketRankCell *cell = [table dequeueReusableCellWithIdentifier:ID];
   // if (cell == nil) {
        cell = [[JCLMarketRankCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
  //  }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCL_Bg_COL;
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        self.title = [JCLKitObj JCLLable:self font:15 color:JCL_Text_COL alignment:0];
        self.code = [YSKitObj YSLable:self size:13 color:JCLRGBA(186, 186, 186, 1) alignment:0 style:0];
        self.price = [YSKitObj YSLable:self size:16 color:JCL_Text_COL alignment:2 style:0];
        self.range = [YSKitObj YSLable:self size:16 color:JCL_Text_COL alignment:2 style:0];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat lineH = 1.4;
    self.bg.frame = CGRectMake(0, 0, self.width, self.height - lineH);
    
    CGFloat x = 14, y = 10, w = 0.5*(self.width - x), h = 0.5*(self.bg.height - 2*y);
    self.title.frame = CGRectMake(x, y, w, h);
    self.code.frame = CGRectMake(x, self.title.maxY, w, h);
    self.price.frame = CGRectMake(self.code.maxX, 0, 0.5*(w - x), self.bg.height);
    self.range.frame = CGRectMake(self.price.maxX, 0, 0.5*(w - x), self.bg.height);
}
@end
