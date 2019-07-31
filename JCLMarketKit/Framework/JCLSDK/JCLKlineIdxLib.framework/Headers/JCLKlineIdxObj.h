//
//  JCLKlineIndexManage.h
//  basichq
//
//  Created by 邢昭俊 on 2017/3/3.
//  Copyright © 2017年 jrj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCLKlineIdxObj : NSObject
+(NSArray *)idxArr:(NSArray *)arr;
+(NSArray *)InitMAData:(NSArray *)arr idx:(NSInteger)idx;
+(NSArray *)InitMAData:(NSArray *)arr idx:(NSInteger)index day:(NSInteger)day;
+(NSArray *)InitIdxData:(NSArray *)arr kline:(NSString *)kline idx:(NSString *)idx;
@end
