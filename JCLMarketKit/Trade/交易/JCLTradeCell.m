//
//  JCLTradeCell.m
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/8.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradeCell.h"

@interface JCLTradeCell()

@end

@implementation JCLTradeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCL_Bg_COL;
        self.bg = [JCLKitObj JCLView:self color:JCL_Bg_COL];
        self.lab1 = [JCLKitObj JCLLable:self font:13 color:JCL_Text_COL alignment:1];
        self.lab2 = [JCLKitObj JCLLable:self font:13 color:JCL_Text_COL alignment:1];
        self.lab3 = [JCLKitObj JCLLable:self font:13 color:JCL_Text_COL alignment:1];
        self.lab4 = [JCLKitObj JCLLable:self font:13 color:JCL_Text_COL alignment:1];
        self.lab5 = [JCLKitObj JCLLable:self font:13 color:JCL_Text_COL alignment:1];
        self.lab6 = [JCLKitObj JCLLable:self font:13 color:JCL_Text_COL alignment:1];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.bg.frame = CGRectMake(0, 0, self.width, self.height-1.4);
    CGFloat w =self.orderIndex==0?self.width/5:self.width/5;
    self.lab1.frame = CGRectMake(0, 0, w, self.bg.height);
    self.lab2.frame = CGRectMake(self.lab1.maxX, 0, w, self.bg.height);
    self.lab3.frame = CGRectMake(self.lab2.maxX, 0, w, self.bg.height);
    self.lab4.frame = CGRectMake(self.lab3.maxX, 0, w, self.bg.height);
    self.lab5.frame = CGRectMake(self.lab4.maxX, 0, w, self.bg.height);
    self.lab6.frame = CGRectMake(self.lab5.maxX, 0, w, self.bg.height);
    for (UIView *subView in self.subviews) {
        if([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]){
            for (UIButton *btn in subView.subviews) {
                if ([btn isKindOfClass:[UIButton class]]) {
                    if ([btn.titleLabel.text isEqualToString:@"反手"]) {
                        [btn setTitle:@"反手" forState:UIControlStateNormal];
                    } else if([btn.titleLabel.text isEqualToString:@"止盈止损"]){
                        [btn setTitle:@"止盈止损" forState:UIControlStateNormal];
                    }
                    btn.titleLabel.font = [JCLKitObj JCLFont:13];
                    btn.layer.borderColor = JCL_Cell_COL.CGColor;
                    btn.backgroundColor = JCL_SelText_COL;
                    btn.layer.borderWidth = 10;
                    btn.height = self.bg.height;
                }
            }
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    self.bg.backgroundColor = selected ? JCLRGB(27, 28, 36) : JCL_Bg_COL;
}
@end
