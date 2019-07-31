//
//  JCLTradCancelCell.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/10.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradCancelCell.h"

@interface JCLTradCancelCell()
@property (nonatomic, weak) UIView *bg;
@end

@implementation JCLTradCancelCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCL_Bg_COL;
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        self.time = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:1];
        self.code = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:1];
        self.price = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:1];
        self.vol = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:1];
        self.option = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:nil];
        self.option.backgroundColor = JCLHexCol(@"#DB3F2B"); self.option.layer.cornerRadius = 6;
        self.option.title = @"撤销";
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat lineH = 1.4;
    self.bg.frame = CGRectMake(0, 0, self.width, self.height - lineH);
    CGFloat w = 0.2*self.width;
    self.time.frame = CGRectMake(0, 0, w, self.bg.height);
    self.code.frame = CGRectMake(self.time.maxX, 0, w, self.bg.height);
    self.price.frame = CGRectMake(self.code.maxX, 0, w, self.bg.height);
    self.vol.frame = CGRectMake(self.price.maxX, 0, w, self.bg.height);
    
    CGSize size = [JCLKitObj JCLTextSize:self.option.title font:self.option.titleLabel.font];
    self.option.frame = CGRectMake(self.vol.maxX+10, 0.5*(self.bg.height-size.height-10), w-20, size.height+10);
}
@end
