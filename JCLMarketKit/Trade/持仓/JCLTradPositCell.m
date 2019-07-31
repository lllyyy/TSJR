//
//  JCLTradPositCell.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/10.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradPositCell.h"

@interface JCLTradPositCell()
@property (nonatomic, weak) UIView *bg;
@end

@implementation JCLTradPositCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCL_Bg_COL;
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[JCLKitObj JCLImgCol:JCL_Bg_COL]];
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        self.code = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:1];
        self.range = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:1];
        self.vol = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:1];
        self.price = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:1];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat lineH = 1.4;
    self.bg.frame = CGRectMake(0, 0, self.width, self.height - lineH);
    CGFloat w = 0.25*self.width;
    self.code.frame = CGRectMake(0, 0, w, self.bg.height);
    self.range.frame = CGRectMake(self.code.maxX, 0, w, self.bg.height);
    self.vol.frame = CGRectMake(self.range.maxX, 0, w, self.bg.height);
    self.price.frame = CGRectMake(self.vol.maxX, 0, w, self.bg.height);
    
    for (UIView *subView in self.subviews) {
        if([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]){
            for (UIButton *btn in subView.subviews) {
                if ([btn isKindOfClass:[UIButton class]]) {
                    if ([btn.titleLabel.text isEqualToString:@"撤单"]) {
                        [btn setTitle:@"撤单" forState:UIControlStateNormal];
                    }
                    if([btn.titleLabel.text isEqualToString:@"止盈止损"]){
                        [btn setTitle:@"止盈止损" forState:UIControlStateNormal];
                    }
                    btn.titleLabel.font = [JCLKitObj JCLFont:13];
                    btn.layer.borderColor = JCL_Cell_COL.CGColor;
                    btn.backgroundColor = JCL_Cell_COL;
                    btn.layer.borderWidth = 10;
                    btn.height = self.bg.height;
                }
            }
        }
    }
}
@end
