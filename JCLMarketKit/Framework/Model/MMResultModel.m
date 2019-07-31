//
//  ResultModel.m
//  Doctor
//
//  Created by jian on 15/11/11.
//  Copyright © 2015年 com.cti. All rights reserved.
//

#import "MMResultModel.h"

@implementation MMResultModel

- (NSDictionary *)oneObject {
    if (self.data.count != 0) {
        return self.data[0];
    }
    return @{};
}

- (id)rCode {
    if ([self.code isKindOfClass:[NSString class]]) {
        return (NSString *)self.code;
    } else if ([self.code isKindOfClass:[NSNumber class]]) {
        return (NSNumber *)self.code;
    }
    return nil;
}




@end
