//
//  JCLMarketEditOptionCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/24.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLMarketEditOptionCell.h"

@interface JCLMarketEditOptionCell()
@property (nonatomic, weak) UIView *bg;
@end

@implementation JCLMarketEditOptionCell
+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style{
    static NSString *ID = @"EditOptionCell";
    JCLMarketEditOptionCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLMarketEditOptionCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCL_Line_COL;
        
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        self.name = [JCLKitObj JCLLable:self font:15 color:JCL_Text_COL alignment:0];
        self.code = [YSKitObj YSLable:self size:13 color:JCLRGBA(186, 186, 186, 1) alignment:0 style:0];
        
        self.select = [JCLKitObj JCLButton:self img:@"buxuan" size:14 target:self action:@selector(selectAction:)];
       // self.stick = [JCLKitObj JCLButton:self img:@"zhiding" size:14 target:self action:@selector(stickAction)];
    }
    return self;
}

-(void)selectAction:(UIButton *)sender{ sender.selected = !sender.selected; !self.selectActionBlock ? : self.selectActionBlock(sender); }
-(void)stickAction{ !self.stickActionBlock ? : self.stickActionBlock(); }

-(void)layoutSubviews{
    [super layoutSubviews];

    CGFloat lineH = 1.4;
    self.bg.frame = CGRectMake(0, 0, self.width, self.height - lineH);
    self.select.frame = CGRectMake(0, 0, 0.12*self.width, self.bg.height);
    
    CGFloat y = 10, w = self.width/2, h = 0.5*(self.bg.height - 2*y);
    self.name.frame = CGRectMake(self.select.maxX - 10, y, w, h);
    self.code.frame = CGRectMake(self.select.maxX - 10, self.name.maxY, w, h);
    
    self.stick.frame = CGRectMake(self.width - self.bg.height - 10, 0, self.bg.height, self.bg.height);
}
@end
