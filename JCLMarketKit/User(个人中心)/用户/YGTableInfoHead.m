//
//  YGTableInfoHead.m
//  NongGe_iOS
//
//  Created by 邢昭俊 on 2017/6/13.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "YGTableInfoHead.h"

@interface YGTableInfoHead()
@end

@implementation YGTableInfoHead
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JCLBGRGB;
        self.title = [JCLKitObj JCLLable:self font:15 color:JCLRGB(255, 116, 55) alignment:0];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat x = 14;
    self.title.frame = CGRectMake(x, 0, self.width, self.height);
}
@end
