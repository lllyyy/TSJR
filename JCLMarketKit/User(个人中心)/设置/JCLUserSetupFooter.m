//
//  JCLUserSetupFooter.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/15.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLUserSetupFooter.h"

@implementation JCLUserSetupFooter
-(instancetype)init{
    if (self = [super init]){
        self.backgroundColor = JCL_Bg_COL;
        self.signOut = [JCLKitObj JCLButton:self img:@"" size:16 target:self action:nil];
        self.signOut.color = JCLHexCol(@"#BE9E62");
        self.signOut.backgroundColor = JCL_Cell_COL;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.signOut.frame = CGRectMake(0, 0, self.width, self.height);
}
@end
