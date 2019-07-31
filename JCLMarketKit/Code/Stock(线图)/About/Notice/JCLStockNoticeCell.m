//
//  JCLStockNoticeCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/29.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockNoticeCell.h"

@interface JCLStockNoticeCell()
@property(nonatomic, weak) UIView *line1;
@property(nonatomic, weak) UILabel *point;
@property(nonatomic, weak) UIView *line2;
@end

@implementation JCLStockNoticeCell
+ (instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style{
    static NSString *ID = @"StockNoticeCell";
    JCLStockNoticeCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLStockNoticeCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];

        self.line1 = [JCLKitObj JCLView:self color:JCLRGBA(251, 204, 162, 1)];
        self.point = [JCLKitObj JCLLable:self font:15 color:JCLRGBA(250, 153, 65, 1) alignment:0];
        self.line2 = [JCLKitObj JCLView:self color:JCLRGBA(251, 204, 162, 1)];

        self.time = [JCLKitObj JCLLable:self font:13 color:[UIColor whiteColor] alignment:1];
        self.time.backgroundColor = JCLRGBA(80, 196, 246, 1);
        self.time.layer.cornerRadius = 10;
        self.text = [JCLKitObj JCLLable:self font:14 color:nil alignment:0];
        self.textStyle = [JCLKitObj JCLLable:self font:12 color:JCLRGBA(195, 195, 195, 1) alignment:0];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.isHave) {
        self.line1.backgroundColor = [UIColor whiteColor];
    }
    CGSize size = [JCLKitObj JCLTextSize:self.time.text spac:0 font:self.time.font width:self.width];
    CGFloat s = 10, h = 1.4*size.height, y = 0.5*(self.height - 2*h);
    CGFloat pointWH = 14, pointY = 0.5*(h - pointWH) + y;
    
    self.point.frame = CGRectMake(s, pointY, pointWH, pointWH);
    self.point.backgroundColor = JCLRGBA(247, 152, 64, 1);
    self.point.layer.borderWidth = 3;
    self.point.layer.borderColor = JCLRGBA(251, 204, 162, 1).CGColor;
    self.point.layer.cornerRadius = 0.5*pointWH;
    CGFloat lineW = 1.4, lineX = 0.5*(pointWH - lineW) + s;
    self.line1.frame = CGRectMake(lineX, 0, lineW, pointY);
    self.line2.frame = CGRectMake(lineX, self.point.maxY, lineW, self.height - self.point.maxY);
    
    CGFloat timeX = self.point.maxX + 4;
    self.time.frame = CGRectMake(timeX, y, size.width, h);
    self.textStyle.frame = CGRectMake(self.time.maxX + 4, y, self.width, h);
    self.text.frame = CGRectMake(timeX, self.time.maxY+10, self.width - timeX - s, h);
}
@end
