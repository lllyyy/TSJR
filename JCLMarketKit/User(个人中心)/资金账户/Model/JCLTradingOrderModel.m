//
//  JCLTradingOrderModel.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/3.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "JCLTradingOrderModel.h"

@implementation JCLTradingOrderModel



-(NSString *)statusStr{
    if (self.status.length > 0) {
        if ([self.status isEqualToString:@"Cancelled"]) {
            return @"手动撤销";
        }else{
             return @"已提交";
        }
    }
    return @"";
}


@end
