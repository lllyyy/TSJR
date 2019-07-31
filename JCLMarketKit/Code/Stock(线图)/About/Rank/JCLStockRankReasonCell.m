//
//  JCLStockRankReasonCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/29.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockRankReasonCell.h"
@interface JCLStockRankReasonCell()
@property(nonatomic, weak) UIView *bg;
@end

@implementation JCLStockRankReasonCell
+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style{
    static NSString *ID = @"RankReasonCell";
    JCLStockRankReasonCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLStockRankReasonCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.bg = [JCLKitObj JCLView:self color:JCLRGBA(254, 244, 232, 1)];
        self.text = [JCLKitObj JCLLable:self font:14 color:JCLRGBA(250, 178, 89, 1) alignment:1];
        self.bg.layer.borderWidth = 1; self.bg.layer.borderColor = JCLRGBA(252, 188, 109, 1).CGColor; self.bg.layer.cornerRadius = 0.8;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat h = 0.7*self.height, y = 0.5*(self.height - h), s = 14;
    CGSize size = [JCLKitObj JCLTextSize:self.text.text font:self.text.font width:self.width - 4*s];
    CGFloat w = size.width > self.width - 4*s ? self.width - 4*s : size.width, x = 0.5*(self.width - w);
    
    self.text.frame=CGRectMake(0, y+3, w, h);
    self.text.centerX=self.centerX;
    self.bg.frame=self.text.frame;
    
}
@end
