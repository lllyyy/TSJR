//
//  JCLTradeSub3.m
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/12.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradeSub3.h"

@implementation JCLTradeSub3
-(instancetype)init{
    if (self = [super init]){
        
        self.backgroundColor = JCL_Cell_COL;
        self.idx = [JCLKitObj JCLLable:self font:12 color:JCL_Text_COL alignment:1];
        self.idx.backgroundColor = [UIColor orangeColor];
        self.key = [JCLKitObj JCLLable:self font:13 color:JCL_Text_COL alignment:0];
//        self.val = [JCLKitObj JCLLable:self font:13 color:JCL_Text_COL alignment:2];
        self.key.text = @"--"; self.val.text = @"--";
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat x = 10;
    CGSize size = [JCLKitObj JCLTextSize:@"44" font:self.idx.font];
    NSInteger h = 1.2*size.height;
    self.idx.frame = CGRectMake(x, 0.5*(self.height-h), 1.2*size.width, h);
    self.key.frame = CGRectMake(self.width/2, 0, self.width, self.height);
//    self.val.frame = CGRectMake(0, 0, self.width-x, self.height);
}
@end
