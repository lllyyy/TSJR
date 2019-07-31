//
//  YGCollectCell.m
//  NongGe_iOS
//
//  Created by 邢昭俊 on 2017/6/25.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "YGCollectMenuCell.h"

@implementation YGCollectMenuCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.text = [JCLKitObj JCLLable:self font:13 color:JCL_Text_COL alignment:1];
        self.layer.cornerRadius = 4; self.layer.borderWidth = 1;
        self.backgroundColor = JCL_Cell_COL; self.layer.borderColor = JCL_Cell_COL.CGColor;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.text.frame = self.bounds;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    self.backgroundColor = selected ? JCL_SelText_COL : JCL_Cell_COL;
    self.layer.borderColor = selected ? JCL_SelText_COL.CGColor : JCL_Cell_COL.CGColor;
}
@end
