//
//  JCLStockReportModel.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/1.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockReportModel.h"

@implementation JCLStockReportModel
- (instancetype)init{
    if (self = [super init]) {
        [JCLStockReportModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{ @"reportId" : @"id" };
        }];
    }
    return self;
}
@end
