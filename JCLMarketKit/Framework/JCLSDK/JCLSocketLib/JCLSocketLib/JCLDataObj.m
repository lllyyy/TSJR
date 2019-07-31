//
//  JCLDataObj.m
//  JCLMarketLib
//
//  Created by 邢昭俊 on 2017/3/29.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLDataObj.h"

@implementation JCLDataObj
+(NSString *)JCLPinYin:(NSString *)str{
    NSMutableString *pinyin = [NSMutableString stringWithString:str];
    CFStringTransform((CFMutableStringRef) pinyin, NULL, kCFStringTransformToLatin, false);
    pinyin = (NSMutableString *)[pinyin stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    pinyin = [[pinyin stringByReplacingOccurrencesOfString:@" " withString:@""] mutableCopy];
    return pinyin.lowercaseString;
}
+(NSString *)JCLPinYinFirst:(NSString *)str{
    NSMutableString *strM = [NSMutableString string];
    NSString *temp = nil;
    for (int i = 0; i < str.length; i ++) {
        temp = [str substringWithRange:NSMakeRange(i, 1)];
        NSMutableString *mutableString = [NSMutableString stringWithString:temp];
        CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
        mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
        mutableString = [[mutableString substringToIndex:1] mutableCopy];
        [strM appendString:(NSString *)mutableString];
    }
    return strM.lowercaseString;
}

+(NSString *)JCLBundle:(NSString *)val{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"JCLBundle" ofType:@"bundle"]];
    return [[bundle resourcePath] stringByAppendingPathComponent:val];
}

+(NSArray *)JCLPolyphone:(NSDictionary *)dic val:(NSString *)val{
    __block NSMutableArray *pyArr = [[NSMutableArray alloc]init];
    [pyArr addObjectsFromArray:[self filterArr:dic val:val]];
    __block NSMutableArray *pys = [[NSMutableArray alloc]init];
    
    NSInteger idx = [self filterIdx:val];
    [pyArr enumerateObjectsUsingBlock:^(id obj, NSUInteger i, BOOL * _Nonnull stop) {
        [pys addObject:[pyArr[i] substringToIndex:idx]];
    }];
    NSArray *arr;
    for (NSInteger i = idx; i < val.length; i ++) {
        NSString *frist = [val substringWithRange:NSMakeRange(i, 1)];
        if ([self isChinese:frist]) {
            arr = [dic objectForKey:frist];
            NSUInteger n = pyArr.count;
            if (arr.count) {
                for (int i = 1; i < arr.count; i++) {
                    for (int j = 0; j < n; j++) {
                        [pyArr addObject:pyArr[j]];
                        [pys addObject:pys[j]];
                    }
                }
                for (int i = 0; i < arr.count; i++) {
                    for (int j = 0; j < n; j++) {
                        NSInteger idx = i*n+j;
                        [pyArr replaceObjectAtIndex:idx withObject:[NSString stringWithFormat:@"%@%@", pyArr[idx], arr[i]]];
                        [pys replaceObjectAtIndex:idx withObject:[NSString stringWithFormat:@"%@%@", pys[idx], [arr[i] substringToIndex:1]]];
                    }
                }
            } else {
                for (int j = 0; j < n; j++) {
                    [pyArr replaceObjectAtIndex:j withObject:[NSString stringWithFormat:@"%@%@", pyArr[j], arr[0]]];
                    [pys replaceObjectAtIndex:j withObject:[NSString stringWithFormat:@"%@%@", pys[j], [arr[0] substringToIndex:1]]];
                }
            }
        } else {
            [pyArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [pyArr replaceObjectAtIndex:idx withObject:[NSString stringWithFormat:@"%@%@", pyArr[idx], frist]];
            }];
            [pys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [pys replaceObjectAtIndex:idx withObject:[NSString stringWithFormat:@"%@%@", pys[idx], frist]];
            }];
        }
    }
    NSMutableArray *arrM = [[NSMutableArray alloc]init];
    [arrM addObjectsFromArray:[[NSSet setWithArray:pyArr] allObjects]];
    [arrM addObjectsFromArray:[[NSSet setWithArray:pys] allObjects]];
    return arrM;
}

+(NSArray *)filterArr:(NSDictionary *)dic val:(NSString *)val{
    __block NSMutableArray *arrM = [[NSMutableArray alloc]init];
    [arrM addObjectsFromArray:[dic objectForKey:[val substringToIndex:1]]];
    NSString *py = @"";
    if (!arrM.count) {
        for (int i = 0; i < val.length; i++) {
            NSString *frist = [val substringWithRange:NSMakeRange(i, 1)];
            if ([self isChinese:frist]) {
                NSArray *arr = [dic objectForKey:frist];
                [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [arrM addObject:[NSString stringWithFormat:@"%@%@", py, obj]];
                }];
                break;
            } else { py = [NSString stringWithFormat:@"%@%@", py, frist]; }
        }
    }
    return arrM;
}

+(NSInteger)filterIdx:(NSString *)val{
    NSInteger idx = 1;
    for (int i = 0; i < val.length; i++) {
        NSString *frist = [val substringWithRange:NSMakeRange(i, 1)];
        if ([self isChinese:frist]) { break;
        } else { idx++; }
    }
    return idx;
}

+(BOOL)isChinese:(NSString *)str{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:str];
}
@end
