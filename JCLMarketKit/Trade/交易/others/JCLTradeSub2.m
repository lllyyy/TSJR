//
//  JCLTradeSub2.m
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/12.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradeSub2.h"

@implementation JCLTradeSub2
-(instancetype)init{
    if (self = [super init]){
        self.backgroundColor = [JCLColorObj JCLCellCol];
        self.key = [JCLKitObj JCLLable:self font:13 color:JCLRGB(112, 113, 115) alignment:0];
        self.val = [JCLKitObj JCLField:self font:13 color:JCL_SelText_COL delegate:self];
        self.val.textAlignment = 2;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat x = 10;
    self.key.frame = CGRectMake(x, 0, self.width, self.height);
    self.val.frame = CGRectMake(0, 1.2, self.width-x, self.height);
}
@end
