//
//  QuotationSearchCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2016/11/20.
//  Copyright © 2016年 ruixue. All rights reserved.
//

#import "JCLMarketSearchCell.h"

@interface JCLMarketSearchCell()
@property (nonatomic, weak) UIView *bg;
@end

@implementation JCLMarketSearchCell
+ (instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style{
    static NSString *ID = @"cell";
    JCLMarketSearchCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLMarketSearchCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCL_Bg_COL;
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        
        self.title = [JCLKitObj JCLLable:self font:15 color:JCL_Text_COL alignment:0];
        self.code = [YSKitObj YSLable:self size:13 color:JCLRGBA(186, 186, 186, 1) alignment:0 style:0];
        self.option = [JCLKitObj JCLButton:self img:@"未添加" size:14 target:self action:@selector(addAction:)];
        self.option.selectedImg = @"已添加";
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.bg.frame = CGRectMake(0, 0, self.width, self.height - 1);
    CGFloat x = 14, w = self.width-self.bg.height-x;
    CGSize nameS = [JCLKitObj JCLStrSize:self.title.text font:self.title.font];
    CGSize codeS = [JCLKitObj JCLStrSize:self.code.text font:self.code.font];
    CGFloat y = 0.5*(self.bg.height-(nameS.height+codeS.height+2));
    self.title.frame = CGRectMake(x, y, w, nameS.height);
    self.code.frame = CGRectMake(x, self.title.maxY+2, w, codeS.height);
    self.option.frame = CGRectMake(self.width - self.bg.height, 0, self.bg.height, self.bg.height);
}

-(void)addAction:(UIButton *)sender{ !self.addActionBlock ? : self.addActionBlock(sender); }
@end
