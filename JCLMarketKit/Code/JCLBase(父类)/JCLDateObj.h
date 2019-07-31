//
//  JCLDateObj.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/1.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCLDateObj : NSObject
// 根据时间戳自动分配格式
+(NSString *)JCLDate:(NSString *)str;
+(NSString *)JCLWuYuDate:(NSString *)str;
// 通过秒数计算出分时
+(NSString *)JCLTime:(NSString *)time;
// 根据规范日期格式获取指定字符
+(NSString *)JCLDateFormat:(NSDate *)date format:(NSString *)format;
// 根据日期获取当月天数
+(NSString *)JCLDateDay:(NSString *)str;
// 根据日期获得星期几
+(NSString*)JCLDateWeek:(NSString *)str;
// 根据指定字符获取规范日期格式
+(NSDate *)JCLDate:(NSString *)str format:(NSString *)format;

// 根据 NSDate 获取指定的时间格式
+(NSString *)JCLDate:(NSString *)style date:(NSDate *)date;

//
+ (NSDate *)getTimeAfterNowWithDay:(NSInteger)day;
@end

