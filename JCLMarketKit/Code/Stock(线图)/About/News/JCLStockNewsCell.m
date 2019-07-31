//
//  JCLStockNewsCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/29.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockNewsCell.h"

@interface JCLStockNewsCell()
@property (nonatomic, weak) UIView *bg;
@end

@implementation JCLStockNewsCell
+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style{
    static NSString *ID = @"StockNewsCell";
    JCLStockNewsCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLStockNewsCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCLBGRGB;
        self.bg = [JCLKitObj JCLView:self color:[UIColor whiteColor]];
        
        self.title = [JCLKitObj JCLLable:self font:15 color:nil alignment:0];
        self.time = [JCLKitObj JCLLable:self font:13 color:JCLRGBA(190, 190, 190, 1) alignment:2];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat s = 10;
    self.bg.frame = CGRectMake(0, 0, self.width, self.height - 2);
    self.title.frame = CGRectMake(s, 0, self.width, self.bg.height);
    self.time.frame = CGRectMake(0, 0, self.width - s, self.bg.height);
    
}
@end

