//
//  JCLStockReportCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/29.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockReportCell.h"

@interface JCLStockReportCell()
@property (nonatomic, weak) UIView *bg;
@end

@implementation JCLStockReportCell
+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style{
    static NSString *ID = @"StockReportCell";
    JCLStockReportCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLStockReportCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCL_Bg_COL;
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        self.title = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:0];
        self.level = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:1];
        self.time = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:2];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat s = 14;
    self.bg.frame = CGRectMake(0, 0, self.width, self.height - 1.4);
    self.title.frame = CGRectMake(s, 0, self.width - 2*s - 50, self.bg.height);
    self.level.frame = CGRectMake(0, 0, self.width, self.bg.height);
    self.time.frame = CGRectMake(0, 0, self.width - s, self.bg.height);
}
@end
