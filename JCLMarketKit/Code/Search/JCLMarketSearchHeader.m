//
//  JCLMarketSearchHeader.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/17.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLMarketSearchHeader.h"

@interface JCLMarketSearchHeader()
@property (nonatomic, weak) UIView *bg;
@end

@implementation JCLMarketSearchHeader
-(instancetype)init{
    if (self = [super init]){
        self.backgroundColor = JCL_Bg_COL;
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        self.text = [JCLKitObj JCLLable:self font:14 color:JCLHexCol(@"#B9BCC3") alignment:0];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.bg.frame = CGRectMake(0, 0, self.width, self.height-1);
    self.text.frame = CGRectMake(14, 0, self.width, self.bg.height);
}
@end
