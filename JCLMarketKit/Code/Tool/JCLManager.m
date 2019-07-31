//
//  JCLManager.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/1/18.
//  Copyright © 2017年 ruixue. All rights reserved.
//

#import "JCLManager.h"

@implementation JCLManager

+ (instancetype)shareManager
{
    static JCLManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JCLManager alloc]init];
    });
    return manager;
}

- (instancetype)init
{
    self.main_flag=[NSMutableArray arrayWithCapacity:0];
    self.Holder=[NSMutableArray arrayWithCapacity:0];
    self.CCDataArray=[NSMutableArray arrayWithCapacity:0];
    self.CDDataArray=[NSMutableArray arrayWithCapacity:0];
    return self;
}

@end
