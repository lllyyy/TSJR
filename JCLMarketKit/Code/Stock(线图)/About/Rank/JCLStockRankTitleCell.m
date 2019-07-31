//
//  JCLStockRankTitleCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/29.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockRankTitleCell.h"

@implementation JCLStockRankTitleCell
+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style{
    static NSString *ID = @"RankTitleCell";
    JCLStockRankTitleCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLStockRankTitleCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.text = [JCLKitObj JCLLable:self font:14 color:nil alignment:1];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.text.frame = self.bounds;
}
@end
