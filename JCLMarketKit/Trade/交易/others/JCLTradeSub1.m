//
//  JCLTradeSub1.m
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/12.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradeSub1.h"

@implementation JCLTradeSub1

-(instancetype)init{
    if (self = [super init]){
        self.backgroundColor = [JCLColorObj JCLCellCol];
        self.lock = [JCLKitObj JCLButton:self img:@"suo-13" size:14 target:self action:nil];
        self.val = [JCLKitObj JCLField:self font:14 color:JCL_SelText_COL delegate:self];
        self.val.enabled = NO;
        self.search = [JCLKitObj JCLButton:self img:@"sousuo" size:14 target:self action:nil];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.lock.frame = CGRectMake(2.5, 2.5, self.height-5, self.height-5);
    self.val.frame = CGRectMake(self.lock.maxX, 0, self.width - 2*self.height, self.height);
    self.search.frame = CGRectMake(self.width-29, 4, 27, 27);
}
@end
