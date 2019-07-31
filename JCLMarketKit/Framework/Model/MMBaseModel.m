//
//  MMBaseModel.m
//  Doctor
//
//  Created by jian on 15/11/4.
//  Copyright © 2015年 com.cti. All rights reserved.
//

#import "MMBaseModel.h"

@implementation MMBaseModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    return [self modelInitWithCoder:aDecoder];
}

- (id)copyWithZone:(NSZone *)zone {
    return [self modelCopy];
}

- (NSUInteger)hash {
    return [self modelHash];
}

- (BOOL)isEqual:(id)object {
    return [self modelIsEqual:object];
}

@end
