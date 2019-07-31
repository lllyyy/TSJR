//
//  JCLStockRankDateCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/18.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockRankDateCell.h"

@interface JCLStockRankDateCell()

@end

@implementation JCLStockRankDateCell
+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style{
    static NSString *ID = @"RankDateCell";
    JCLStockRankDateCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLStockRankDateCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCLBGRGB;
        self.bg = [JCLKitObj JCLView:self color:[UIColor whiteColor]];
        self.time = [JCLKitObj JCLLable:self font:15 color:nil alignment:1];
        self.icon = [JCLKitObj JCLButton:self img:@"" size:12 target:self action:nil];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.bg.frame = CGRectMake(0, 0, self.width, self.height - 1.4);
    self.time.frame = CGRectMake(0, 0, self.width - 14, self.bg.height);
    self.icon.frame = CGRectMake(self.width - self.bg.height, 0, self.bg.height, self.bg.height);
}
@end
