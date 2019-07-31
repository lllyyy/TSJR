//
//  JCLStockF10Cell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/29.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockF10Cell.h"

@interface JCLStockF10Cell()
@property (nonatomic, weak) UIView *bg;
@property (nonatomic, weak) UIButton *img;
@end

@implementation JCLStockF10Cell
+ (instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style{
    static NSString *ID = @"StockF10Cell";
    JCLStockF10Cell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLStockF10Cell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCLBGRGB;
        self.bg = [JCLKitObj JCLView:self color:[UIColor whiteColor]];
        self.title = [JCLKitObj JCLLable:self font:15 color:nil alignment:0];
        self.text = [JCLKitObj JCLLable:self font:13 color:JCLRGBA(190, 190, 190, 1) alignment:0];
        self.img = [JCLKitObj JCLButton:self img:@"arrowl" size:11 target:self action:nil];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat h = 2;
    self.bg.frame = CGRectMake(0, 0, self.width, self.height-h);
    CGSize size = [JCLKitObj JCLTextSize:self.title.text spac:0 font:self.title.font width:self.width];
    CGFloat s = 10, y = 0.5*(self.bg.height - 2*size.height);
    self.title.frame = CGRectMake(s, 0, self.width, self.bg.height);
    self.text.frame = CGRectMake(s, self.title.maxY, self.width, size.height);
    self.img.frame = CGRectMake(self.width - self.bg.height, 0, self.bg.height, self.bg.height);
}
@end
