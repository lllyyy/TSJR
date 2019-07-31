//
//  JCLOptionalCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/24.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLMarketOptionCell.h"

@interface JCLMarketOptionCell()
@property (nonatomic, weak) UIView *bg;
@end

@implementation JCLMarketOptionCell
+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style{
    static NSString *ID = @"OptionCell";
    JCLMarketOptionCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLMarketOptionCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCL_Bg_COL;
        
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        self.name = [JCLKitObj JCLLable:self font:15 color:JCL_Text_COL alignment:0];
        self.code = [YSKitObj YSLable:self size:13 color:JCLRGBA(186, 186, 186, 1) alignment:0 style:0];

        self.price = [YSKitObj YSLable:self size:16 color:JCL_Text_COL alignment:1 style:0];
        self.riseFall = [YSKitObj YSLable:self size:16 color:JCL_Text_COL alignment:1 style:0];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat lineH = 1;
    self.bg.frame = CGRectMake(0, 0, self.width, self.height - lineH);
    
    CGFloat x = 14, y = 10, w = self.width/3, h = 0.5*(self.bg.height - 2*y);
    self.name.frame = CGRectMake(x, y, w-x, h);
    self.code.frame = CGRectMake(x, self.name.maxY, w-x, h);
    self.price.frame = CGRectMake(self.name.maxX, 0, w, self.bg.height);
    CGSize size = [JCLKitObj JCLTextSize:@"44.44%" font:self.riseFall.font];
    CGFloat sizeW = size.width+x, sizeH = size.height+y;
    self.riseFall.frame = CGRectMake(self.width-sizeW-x, 0.5*(self.bg.height-sizeH), sizeW, sizeH);
}
@end
