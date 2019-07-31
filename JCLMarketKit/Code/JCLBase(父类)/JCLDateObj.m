//
//  JCLDateObj.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/1.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLDateObj.h"

@implementation JCLDateObj
// 根据日期自动分配格式
+(NSString *)JCLDate:(NSString *)str{
    //    NSString *sever = PreRead(SeverDate);
    NSDate *date = [self JCLDate:str format:@"YYYYMMddHHmmss"];
    //    if ([[self JCLDateFormat:date format:@"YYYYMMdd"] isEqualToString:sever]) {
    //        return [self JCLDateFormat:date format:@"HH:mm"];
    //    } else if ([[str substringToIndex:3] isEqualToString:[sever substringToIndex:3]]){
    //        return [self JCLDateFormat:date format:@"MM-dd"];
    //    } else {
    return [self JCLDateFormat:date format:@"yyyy-MM-dd"];
    //    }
}

// 根据 NSDate 获取指定的时间格式
+(NSString *)JCLDate:(NSString *)style date:(NSDate *)date{
    NSDateFormatter *format = [[NSDateFormatter alloc] init]; [format setDateFormat:style];
    format.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    return [format stringFromDate:date];
}

+(NSString *)JCLWuYuDate:(NSString *)str {
    NSString *sever = PreRead(SeverDate);
    NSDate *date = [self JCLDate:str format:@"YYYY-MM-dd HH:mm:ss"];
    if ([[self JCLDateFormat:date format:@"YYYYMMdd"] isEqualToString:sever]) {
        return [self JCLDateFormat:date format:@"HH:mm"];
    } else if ([[str substringToIndex:3] isEqualToString:[sever substringToIndex:3]]){
        return [self JCLDateFormat:date format:@"MM-dd"];
    } else {
        return [self JCLDateFormat:date format:@"yyyy-MM-dd"];
    }
}

// 通过秒数计算出分时
+(NSString *)JCLTime:(NSString *)time{
    NSInteger shi = [time integerValue] / 60;
    NSInteger fen = [time integerValue] - shi*60;
    return fen < 10 ? [NSString stringWithFormat:@"%ld:0%ld", (long)shi, (long)fen] : [NSString stringWithFormat:@"%ld:%ld", (long)shi, (long)fen];
}

// 根据规范日期格式获取指定字符
+(NSString *)JCLDateFormat:(NSDate *)date format:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init]; [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

// 根据指定字符获取规范日期格式
+(NSDate *)JCLDate:(NSString *)str format:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]]; [formatter setDateFormat:format];
    return[formatter dateFromString:str];
}

// 根据日期获取当月天数
+(NSString *)JCLDateDay:(NSString *)str{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [self JCLDate:str format:@"YYYYMMdd"];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return [NSString stringWithFormat:@"%ld", range.length];
}

// 根据日期获得当前星期几
+(NSString *)JCLDateWeek:(NSString *)str{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [self JCLDate:str format:@"YYYYMMdd"];
    NSDateComponents *compon = [calendar components:NSWeekdayCalendarUnit fromDate:date];
    return [NSString stringWithFormat:@"%ld", compon.weekday];
}

+ (NSDate *)getTimeAfterNowWithDay:(NSInteger)day
{
    NSDate *nowDate = [NSDate date];
    NSDate *theDate;
    
    if(day!=0)
    {
        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
        
        theDate = [nowDate initWithTimeIntervalSinceNow: -oneDay*day ];
        //or
        //theDate = [nowDate initWithTimeIntervalSinceNow: -oneDay*day ];
    }
    else
    {
        theDate = nowDate;
    }
    return theDate;
}
@end

