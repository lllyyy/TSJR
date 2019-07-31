//
//  BuyCell.m
//  cctv
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 macbook. All rights reserved.
//

#import "JCLTradFiveCell.h"

@implementation JCLTradFiveCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCL_Cell_COL;
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[JCLKitObj JCLImgCol:JCL_Bg_COL]];
        self.oneLabel= [JCLKitObj JCLLable:self font:13 color:JCL_Text_COL alignment:1];
        self.twoLabel= [JCLKitObj JCLLable:self font:13 color:JCL_Text_COL alignment:1];
        self.threeLabel= [JCLKitObj JCLLable:self font:13 color:JCL_Text_COL alignment:1];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.width/3;
    self.oneLabel.frame=CGRectMake(0, 0, w, self.height);
    self.twoLabel.frame=CGRectMake(self.oneLabel.maxX, 0, w, self.height);
    self.threeLabel.frame=CGRectMake(self.twoLabel.maxX, 0, w, self.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.backgroundColor = selected ? JCL_SelText_COL : JCL_Cell_COL;
}


@end
