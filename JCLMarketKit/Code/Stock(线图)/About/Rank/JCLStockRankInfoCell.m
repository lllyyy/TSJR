//
//  JCLStockRankInfoCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/29.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockRankInfoCell.h"

@implementation JCLStockRankInfoCell
+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style{
    static NSString *ID = @"RankInfoCell";
    JCLStockRankInfoCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLStockRankInfoCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.netBuy = [JCLKitObj JCLLable:self font:13 color:[UIColor whiteColor] alignment:0];
        self.title = [JCLKitObj JCLLable:self font:13 color:nil alignment:0];
        self.buyPrice = [JCLKitObj JCLLable:self font:13 color:nil alignment:0];
        self.sellPrice = [JCLKitObj JCLLable:self font:13 color:nil alignment:0];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat s = 10, w = self.width - 2*s;
    CGSize size = [JCLKitObj JCLTextSize:self.netBuy.text font:self.netBuy.font];
    CGFloat textS = 2, y = 0.5*(self.height - 2*size.height - 2*textS - 1.4*size.height);
    self.netBuy.frame = CGRectMake(s, y, self.buyWidth, 1.4*size.height);
    self.title.frame = CGRectMake(s, self.netBuy.maxY + textS, w, size.height);
    self.buyPrice.frame = CGRectMake(s, self.title.maxY + textS, 0.5*w, size.height);
    self.sellPrice.frame = CGRectMake(self.buyPrice.maxX, self.title.maxY + textS, 0.5*w, size.height);
}
@end
