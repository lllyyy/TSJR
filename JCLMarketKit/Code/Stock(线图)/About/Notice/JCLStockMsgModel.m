//
//  JCLStockNoticeModel.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/1.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockMsgModel.h"

@implementation JCLStockMsgModel
- (instancetype)init{
    if (self = [super init]) {
        [JCLStockMsgModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{ @"noticeId" : @"id" };
        }];
    }
    return self;
}
@end
