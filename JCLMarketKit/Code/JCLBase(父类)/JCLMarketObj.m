//
//  JCLMarketObjManage.m
//  Jincelue_Sdk
//
//  Created by 邢昭俊 on 2017/2/24.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLMarketObj.h"

@interface JCLMarketObj()
@end

@implementation JCLMarketObj

+(NSArray *)JCLSearchCode:(NSString *)code{
    
    NSArray *array;
//    NSArray *futures_QHDL = FileRead(CachesFile(QHDL));
//    NSArray *futures_QHZZ = FileRead(CachesFile(QHZZ));
//    NSArray *futures_QHSHGZ = FileRead(CachesFile(QHSHGZ));
//    NSArray *futures_QHSH = FileRead(CachesFile(QHSH));
//    NSArray *futures_SQNY = FileRead(CachesFile(SQNY));
//    NSMutableArray *futures = [NSMutableArray array];
//    [futures addObjectsFromArray:futures_QHDL];
//    [futures addObjectsFromArray:futures_QHZZ];
//    [futures addObjectsFromArray:futures_QHSHGZ];
//    [futures addObjectsFromArray:futures_QHSH];
//    [futures addObjectsFromArray:futures_SQNY];
//    NSArray *code_message;
//    for (int i=0; i<futures.count; i++) {
//        NSArray *array = futures[i];
//
//        if ([[array lastObject] isEqualToString:code]) {
//
//            code_message = array;
//
//        }
//    }
    return array;
}
-(void)loadUpdateCodeData{
    [JCLMarketDataObj JCLGetMarketCodeUpdate:JCLMarketURL codeType:@"NYSE" success:^(id obj) {
        if (obj) {
            NSLog(@"--%@",obj);
            NSNumber *serverDate = obj[@"infdate"]; NSNumber *serverTime = obj[@"infhms"];
            NSNumber *localDate = PreRead(
                                          InitDate); NSNumber *localTime = PreRead(InitTime);
            if (![localDate isEqualToNumber:serverDate] || ![localTime isEqualToNumber:serverTime]) {
                
            NSArray *arr = [self JCLTimes:obj[@"common"]];
                
                NSLog(@"--%@",arr);
                
                FileWrite(CachesFile(NYSETime), arr);
                [JCLMarketDataObj JCLGetMarketCode:JCLMarketURL codeType:@"NYSE" success:^(id obj) {
                    
                    
                    FileWrite(CachesFile(NYSE), obj);
                } failure:^(NSError *error) {  }];
                
                [JCLMarketDataObj JCLGetMarketCodeUpdate:JCLMarketURL codeType:@"NASDAQ" success:^(id obj) {
                    FileWrite(CachesFile(NASDAQTime), [self JCLTimes:obj[@"common"]]);
                    [JCLMarketDataObj JCLGetMarketCode:JCLMarketURL codeType:@"NASDAQ" success:^(NSArray *obj) {
                        
                        NSLog(@"%@",obj);
                        FileWrite(CachesFile(NASDAQ), obj);
                    } failure:^(NSError *error) { }];
                } failure:^(NSError *error) {  }];
                
                [JCLMarketDataObj JCLGetMarketCodeUpdate:JCLMarketURL codeType:@"American" success:^(id obj) {
                    FileWrite(CachesFile(AmerTime), [self JCLTimes:obj[@"common"]]);
                    [JCLMarketDataObj JCLGetMarketCode:JCLMarketURL codeType:@"American" success:^(NSArray *obj) {
                         NSLog(@"%@",obj);
                        FileWrite(CachesFile(American), obj);
                    } failure:^(NSError *error) { }];
                } failure:^(NSError *error) {  }];
                PreWrite(serverDate, InitDate); PreWrite(serverTime, InitTime);
            }
        }
    } failure:^(NSError *error) { }];
}

-(NSArray *)JCLTimes:(NSArray *)obj{
    if (!obj.count) return nil;
    NSMutableArray *begins = [[NSMutableArray alloc]init], *ends = [[NSMutableArray alloc]init];
    NSString *end = [NSString stringWithFormat:@"%ld", [obj[obj.count-1] integerValue]];
    [obj enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0 || obj.integerValue == end.integerValue){ return; }
        if (idx % 2 == 0) { [begins addObject:obj]; } else { [ends addObject:obj]; }
    }];
    
    __block NSInteger num = [ends[0] integerValue]-[obj[0] integerValue];
    NSMutableArray *times = [[NSMutableArray alloc]init];
    [times addObject:@[[self JCLTime:obj[0]], @(num)]];
    [ends enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.integerValue == 0) { obj = [NSString stringWithFormat:@"%d", 60*24]; }
        NSString *begin = begins[idx];
        if (begin.integerValue == 0) { begin = [NSString stringWithFormat:@"%d", 60*24]; }
        [times addObject:@[[NSString stringWithFormat:@"%@-%@", [self JCLTime:begin], [self JCLTime:obj]], @(num)]];
        num += (obj.integerValue - begin.integerValue);
    }];
    [times addObject:@[[self JCLTime:end], @(num+end.integerValue)]];
    return times;
}

-(NSString *)JCLTime:(NSString *)val{
    NSInteger shi = [val integerValue]/60;
    NSInteger fen = [val integerValue] - shi*60;
    NSString *f = fen == 0 ? @"00" : [NSString stringWithFormat:@"%ld", fen];
    return [NSString stringWithFormat:@"%ld:%@", shi, f];
}

// 拿到服务器的时间
-(void)JCLSeverDate{
    NSString *url = [NSString stringWithFormat:@"%@/FreeHQWebServer/serverdate", JCLMarketURL];
    [JCLHttpsObj JCLGetJson:url success:^(id obj) {
        NSString *date = [NSString stringWithFormat:@"%@", obj[@"date"]]; PreWrite(date, SeverDate);
    } failure:^(NSError *error) { }];
}

// 通过代码获取市场信息
+(NSArray *)JCLMarketInfos:(NSString *)code{
    if ([code hasPrefix:@"NYSE"]) {
        return FileRead(CachesFile(NYSE));
    } if ([code hasPrefix:@"NASDAQ"]) {
        return FileRead(CachesFile(NASDAQ));
    } else {
        return FileRead(CachesFile(American));
    }
}

// 通过市场获取时间轴
+(NSArray *)JCLStockTimes:(NSString *)code{
    if ([code hasPrefix:@"NYSE"]) {
        return FileRead(CachesFile(NYSETime));
    } if ([code hasPrefix:@"NASDAQ"]) {
        return FileRead(CachesFile(NASDAQTime));
    } else {
        return FileRead(CachesFile(AmerTime));
    }
}

// 通过代码获取个股索引
+(NSInteger)JCLStockIdx:(NSString *)code{
    __block NSInteger index = 0;
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", [code substringFromIndex:2]];
    [[self JCLMarketInfos:code] enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL *stop) {
        if ([NSArray arrayWithArray:[obj filteredArrayUsingPredicate:preicate]].count) { index = idx; }
    }];
    return index;
}

// 通过代码获取个股信息
+(NSArray *)JCLStockInfo:(NSString *)code{
    NSLog(@"codecodecode %@",code);
    __block NSArray *searchArr;
    [[self JCLMarketInfos:code] enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL *stop) {
        if (obj.count > 6) {
                NSLog(@"obj[6]obj[6] %@",obj[6]);
            if ([obj[6] isEqualToString:code]) { searchArr = obj; }
        }
    }];
    return searchArr;
}

// 通过代码获取个股现价小数点
+(NSString *)JCLStockDecimal:(NSString *)code{
    NSString *style = [code substringToIndex:2].lowercaseString;
    NSString *codes = [code substringFromIndex:2];
    NSString *num = @"2";
    if ([style isEqualToString:@"sh"]) {
        if ([[codes substringToIndex:3] isEqualToString:@"900"] || [[codes substringToIndex:1] isEqualToString:@"2"] ||
            [[codes substringToIndex:2] isEqualToString:@"50"] || [[codes substringToIndex:2] isEqualToString:@"50"]){
            num = @"3";
        }
    }else if ([style isEqualToString:@"sz"]){
        NSString *code = [codes substringToIndex:2];
        if (code.intValue == 13 || code.intValue == 15 || code.intValue == 16 || code.intValue == 17 || code.intValue == 18){
            num = @"3";
        }
    }
    return num;
}

// 通过现价获取对应色值
+(UIColor *)JCLMarketColor:(NSString *)price{
    if ([price floatValue] > 0) {
        return JCL_Rise_COL;
    } else if ([price floatValue] < 0) {
        return JCL_Fall_COL;
    }  else {
        return JCLRGB(190, 190, 190);
    }
}

// 通过现价和昨收获取对应色值
+(UIColor *)JCLMarketColor:(NSString *)price close:(NSString *)close{
    if (price.floatValue > close.floatValue) { return JCL_Rise_COL;
    } else if (price.floatValue < close.floatValue) { return JCL_Fall_COL;
    } else { return JCLFLATRGB; }
}


//  红涨 
+(UIColor *)TSJRMarketColor:(NSString *)price close:(NSString *)close{
    NSLog(@"----- %@  close  %@",price,close)
    if (price.floatValue > close.floatValue){
        return RoseColor;
    } else if (price.floatValue < close.floatValue) {
        return FallColor;
    } else {
        return GreyColor;
   }
}

//盈亏
+(UIColor *)TSJRMarketColorA:(NSString *)price{
 
    if (price.floatValue > 0){
        return RoseColor;
    }else if (price.floatValue == 0.00) {
        return GreyColor;
    }
//    else if (price.floatValue < 0) {
//        return FallColor;
//    }
    else  {
        return FallColor;
    }
}

// 通过代码检测市场类型
+(NSString *)JCLMarketStyle:(NSString *)code{
    return [code.lowercaseString isEqualToString:@"sz"] ? @"0" : @"1";
}

// 通过数字获取对应单位数字(1.价格, 2.量，3.万)
+(NSString *)JCLMarketUnit:(NSString *)number decimal:(NSString *)decimal style:(NSInteger)style{
    if (style == 3) {
        NSString *val = [self JCLMarketPrice:number.floatValue/10000 decimal:decimal];
        return [NSString stringWithFormat:@"%@万", val];
    }
    if (fabsf(number.floatValue) > 100000000) {
        NSString *val = [self JCLMarketPrice:number.floatValue/100000000 decimal:decimal];
        return [NSString stringWithFormat:@"%@亿", val];
    } else if (fabsf(number.floatValue) > 10000) {
        NSString *val = [self JCLMarketPrice:number.floatValue/10000 decimal:decimal];
        return [NSString stringWithFormat:@"%@万", val];
    } else {
        if (style == 1) {
            return [self JCLMarketPrice:number.floatValue decimal:decimal];
        } else {
            return [NSString stringWithFormat:@"%ld", number.integerValue];
        }
    }
}
+(NSString *)JCLMarketPrice:(CGFloat)price decimal:(NSString *)decimal{
    if ([decimal isEqualToString:@"3"]) {
        return [NSString stringWithFormat:@"%.3lf", price];
    } else {
        return [NSString stringWithFormat:@"%.2lf", price];
    }
}

// 通过代码检测是否是市场指数
+(BOOL)JCLMarketIdx:(NSString *)code{
    NSString *codeStyle = [code substringToIndex:2];
    NSString *codeNum = [code substringFromIndex:2];
    if ([codeStyle isEqualToString:@"SH"]) {
        if ([[codeNum substringToIndex:3] isEqualToString:@"000"] || [[codeNum substringToIndex:3] isEqualToString:@"990"] ||
            [[codeNum substringToIndex:2] isEqualToString:@"88"] || [[codeNum substringToIndex:3] isEqualToString:@"777"] ||
            [[codeNum substringToIndex:3] isEqualToString:@"778"] || [[codeNum substringToIndex:3] isEqualToString:@"779"]){
            return true;
        }
    } else if ([codeStyle isEqualToString:@"SZ"]){
        if ([[codeNum substringToIndex:3] isEqualToString:@"399"]){
            return true;
        }
    }
    return false;
}

// 通过开盘价和昨收获取市场价格涨跌范围
+(NSString *)JCLMarketRange:(NSString *)open close:(NSString *)close{
    NSString *range = [NSString stringWithFormat:@"%.2lf", [open floatValue] - [close floatValue]];
    if (open.floatValue == 0 || close.floatValue == 0) {
        return @"--";
    } else if (range.floatValue > 0){
        return [NSString stringWithFormat:@"+%@", range];
    } else {
        return range;
    }
}

+(NSString *)JCLMarketRange:(NSString *)open close:(NSString *)close is:(NSString *)is{
    NSString *range;
    if ([is isEqualToString:@"3"]) {
        range = [NSString stringWithFormat:@"%.3lf", [open floatValue] - [close floatValue]];
    } else {
        range = [NSString stringWithFormat:@"%.2lf", [open floatValue] - [close floatValue]];
    }
    if (open.floatValue == 0 || close.floatValue == 0) {
        return @"--";
    } else if (range.floatValue > 0){
        return [NSString stringWithFormat:@"+%@", range];
    } else {
        return range;
    }
}

+(NSString *)JCLMarketPrice:(NSString *)price is:(NSString *)is{
    if (price.floatValue == 0) {
        return @"--";
    }
    if ([is isEqualToString:@"3"]) {
        return [NSString stringWithFormat:@"%.3lf", [price floatValue]];
    } else {
        return [NSString stringWithFormat:@"%.2lf", [price floatValue]];
    }
}

// 通过价格涨跌范围和昨收获取市场价格涨跌比例
+(NSString *)JCLMarketScale:(NSString *)range close:(NSString *)close{
    NSString *scale = [NSString stringWithFormat:@"%.2lf%%", [range floatValue] / [close floatValue] * 100];
    if ([range isEqualToString:@"--"]) { return @"--";
    } else if (scale.floatValue > 0){ return [NSString stringWithFormat:@"+%@", scale];
    } else { return scale; }
}

// 清空个股信息的沙盒记录
+(void)JCLStockClear{
    PreWrite(@"", JCLInfoIdx);
    PreWrite(@"", JCLKLineIdx);
    PreWrite(@"", JCLKLine);
    
}


+(NSString *)JCLMarketPercent:(NSString *)str {
    
    if (str.floatValue > 0){
        return [NSString stringWithFormat:@"+%@%%", str];
    } else if (str.floatValue < 0) {
        return [NSString stringWithFormat:@"%@%%", str];
    }else{
        return [NSString stringWithFormat:@"%@%%", str];
    }
}

// 完全无视，遇到就懂了，无语
+(NSString*)UTF8_To_GB2312:(NSString*)utf8string{
    CFStringRef nonAlphaNumValidChars = CFSTR("![        DISCUZ_CODE_1        ]’()*+,-./:;=?@_~");
    NSString *preprocessedString= (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,(CFStringRef)utf8string,CFSTR(""),kCFStringEncodingGB_18030_2000));
    NSString *newStr =(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)preprocessedString,NULL,nonAlphaNumValidChars,kCFStringEncodingGB_18030_2000)) ;
    return newStr;
}
@end
