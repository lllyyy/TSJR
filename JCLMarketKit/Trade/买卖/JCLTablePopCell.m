//
//  JCLStockRankDateCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/18.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTablePopCell.h"

@interface JCLTablePopCell()

@end

@implementation JCLTablePopCell
+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style{
    static NSString *ID = @"RankDateCell";
    JCLTablePopCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLTablePopCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCL_Line_COL;
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        self.time = [JCLKitObj JCLLable:self font:13 color:JCL_Text_COL alignment:0];
        self.icon = [JCLKitObj JCLButton:self img:@"" size:12 target:self action:nil];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.bg.frame = CGRectMake(0, 0, self.width, self.height - 1);
    self.time.frame = CGRectMake(20, 0, self.width, self.bg.height);
    self.icon.frame = CGRectMake(self.width - self.bg.height, 0, self.bg.height, self.bg.height);
}
@end
