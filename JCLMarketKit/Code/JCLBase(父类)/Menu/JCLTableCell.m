//
//  JCLTableCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2016/11/4.
//  Copyright © 2016年 ruixue. All rights reserved.
//

#import "JCLTableCell.h"

@interface JCLTableCell()
@property (nonatomic , weak) UIView *bg;
@end

@implementation JCLTableCell
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"cell1";
    JCLTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLTableCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCL_Cell_COL;
        self.bg = [JCLKitObj JCLView:self color:JCL_Line_COL];
        self.title = [JCLKitObj JCLLable:self font:13 color:JCL_Text_COL alignment:1];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat h = 1;
    self.bg.frame = CGRectMake(0, self.height - h, self.width, h);
    self.title.frame = CGRectMake(0, 0, self.width, self.height - h);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.title.textColor = selected ? JCL_SelText_COL : JCL_Text_COL;
}
@end
