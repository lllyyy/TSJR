//
//  JCLStockManager.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/2/9.
//  Copyright © 2017年 ruixue. All rights reserved.
//

#import "JCLStockDataObj.h"

@implementation JCLStockDataObj
/**
 * 根据个股代码编号获取盘口信息
 * @param url             域名
 * @param code            代码编号
 * @param success         数据请求成功的回调
 * @param failure         数据请求失败的回调
 */
+ (void)JCLGetStockInfo:(NSString *)url
                   code:(NSString *)code
                success:(successBlock)success
                failure:(failureBlock)failure{
    NSString *urlStr = [NSString stringWithFormat:@"%@/FreeHQWebServer/report?symbol=%@%@", url, code, JCLRandom];
    [JCLHttpsObj JCLGetStr:urlStr success:^(id obj) {
        !success ? : success(obj);
    } failure:^(NSError *error) { !failure ? : failure(error); }];
}

/**
 * 根据个股代码编号获取分时信息
 * @param url             域名
 * @param code            代码编号
 * @param success         数据请求成功的回调
 * @param failure         数据请求失败的回调
 */
+(void)JCLGetStockTimeInfo:(NSString *)url
                       code:(NSString *)code
                    success:(successBlock)success
                    failure:(failureBlock)failure{
    NSString *urlStr = [NSString stringWithFormat:@"%@/FreeHQWebServer/MinuteResource?symbol=%@&ex=0%@", url, code, JCLRandom];
    [JCLHttpsObj JCLGetStr:urlStr success:^(NSArray *obj) {
        !success ? : success(obj);
    } failure:^(NSError *error) { !failure ? : failure(error); }];
}

/**
 * 根据个股代码编号获取K线信息
 * @param url             域名
 * @param code            代码编号
 * @param page            分页(起始分页为0)
 * @param number          每个分页的个数
 * @param timeType        时间类型
 * @param authType        复权类型
 * @param success         数据请求成功的回调
 * @param failure         数据请求失败的回调
 */
+(void)JCLGetStockKLineInfo:(NSString *)url
                        code:(NSString *)code
                       page:(NSInteger)page
                     number:(NSInteger)number
                    timeType:(NSString *)timeType
                    authType:(NSString *)authType
                     success:(successBlock)success
                     failure:(failureBlock)failure{
    NSString *urlStr = [NSString stringWithFormat:@"%@/FreeHQWebServer/KLineResource?symbol=%@&start=%ld&num=%ld&period=%@&ex=%@&synid=0%@", url, code, (long)page, (long)number, timeType, authType, JCLRandom];
    if ([timeType isEqualToString:@"100"]) {
        
        NSLog(@"%@",url);
    }
    [JCLHttpsObj JCLGetStr:urlStr success:^(NSArray *obj) {
        !success ? : success(obj);
    } failure:^(NSError *error) { !failure ? : failure(error); }];
}

/**
 * 根据个股代码编号获取五档信息
 * @param url             域名
 * @param code            代码编号
 * @param success         数据请求成功的回调
 * @param failure         数据请求失败的回调
 */
+ (void)JCLGetStockFiveInfo:(NSString *)url
                       code:(NSString *)code
                    success:(successBlock)success
                    failure:(failureBlock)failure{
    NSString *urlStr = [NSString stringWithFormat:@"%@/FreeHQWebServer/ReportResource?symbol=%@%@", url, code, JCLRandom];
    [JCLHttpsObj JCLGetStr:urlStr success:^(id obj) {
        !success ? : success(obj);
    } failure:^(NSError *error) { !failure ? : failure(error); }];
}
//        NSString *url = [NSString stringWithFormat:@"%@ReportResource?symbol=%@%@", JCLURL90, self.code, JCLRandom];

/**
 * 根据个股代码编号获取分价信息
 * @param url             域名
 * @param code            代码编号
 * @param page            分页 (PS:起始为0)
 * @param number          每页数量
 * @param success         数据请求成功的回调
 * @param failure         数据请求失败的回调
 */
+ (void)JCLGetStockPriceInfo:(NSString *)url
                        code:(NSString *)code
                        page:(NSString *)page
                      number:(NSString *)number
                     success:(successBlock)success
                     failure:(failureBlock)failure{
    NSString *urlStr = [NSString stringWithFormat:@"%@/FreeHQWebServer/fjtable?symbol=%@&start=%@&num=%@%@", url, code, page, number, JCLRandom];
    [JCLHttpsObj JCLGetStr:urlStr success:^(id obj) {
        !success ? : success(obj);
    } failure:^(NSError *error) { !failure ? : failure(error); }];
}

/**
 * 根据个股代码编号获取明细信息
 * @param url             域名
 * @param code            代码编号
 * @param page            分页 (PS:起始为0)
 * @param number          每页数量
 * @param success         数据请求成功的回调
 * @param failure         数据请求失败的回调
 */
+ (void)JCLGetStockDetailInfo:(NSString *)url
                         code:(NSString *)code
                         page:(NSString *)page
                       number:(NSString *)number
                      success:(successBlock)success
                      failure:(failureBlock)failure{
    NSString *urlStr = [NSString stringWithFormat:@"%@/FreeHQWebServer/currenttick?symbol=%@&start=%@&num=%@%@", url, code, page, number, JCLRandom];
    [JCLHttpsObj JCLGetJson:urlStr success:^(id obj) {
        !success ? : success(obj);
    } failure:^(NSError *error) { !failure ? : failure(error); }];
}

/**
 * 根据个股代码编号获取板块信息
 * @param url             域名
 * @param code            代码编号
 * @param page            分页 (PS:起始为0)
 * @param number          每页数量
 * @param mianSort        主排序字段
 * @param subSort         子排序字段
 * @param success        数据请求成功的回调
 * @param failure         数据请求失败的回调
 */
+ (void)JCLGetStockPlateInfo:(NSString *)url
                        code:(NSString *)code
                        page:(NSString *)page
                      number:(NSString *)number
                    mianSort:(NSString *)mianSort
                     subSort:(NSString *)subSort
                     success:(successBlock)success
                     failure:(failureBlock)failure{
    NSString *urlStr = [NSString stringWithFormat:@"%@/FreeSortWebServer/relateblock?symbol=%@&start=%@&num=%@&sortid=%@&subsortid=%@%@", url, code, page, number, mianSort, subSort, JCLRandom];
    [JCLHttpsObj JCLGetStr:urlStr success:^(id obj) {
        !success ? : success(obj);
    } failure:^(NSError *error) { !failure ? : failure(error); }];
}

/**
 * 根据个股代码编号获取主力资金信息
 * @param url             域名
 * @param code            代码编号
 * @param success         数据请求成功的回调 (return 代码,名称,昨收,开盘价,最高价,最低价,收盘价,成交量,成交金额,买,卖)
 * @param failure         数据请求失败的回调
 */
+(void)JCLGetStockMainCapitalInfo:(NSString *)url
                             code:(NSString *)code
                          success:(successBlock)success
                          failure:(failureBlock)failure{
    NSString *urlStr = [NSString stringWithFormat:@"%@/freezjwebserver/freezjwebserver/curmoneydat?symbol=%@&start=0&num=1%@", url, code, JCLRandom];
    [JCLHttpsObj JCLGetStr:urlStr success:^(NSArray *obj) {
        !success ? : success(obj);
    } failure:^(NSError *error) { !failure ? : failure(error); }];
}

/**
 * 根据个股代码编号获取五日资金信息
 * @param url             域名
 * @param code            代码编号
 * @param success         数据请求成功的回调
 * @param failure         数据请求失败的回调
 */
+(void)JCLGetStockFiveDayCapitalInfo:(NSString *)url
                                 code:(NSString *)code
                              success:(successBlock)success
                              failure:(failureBlock)failure{
    NSString *urlStr = [NSString stringWithFormat:@"%@/freezjwebserver/freezjwebserver/hismoneydat?symbol=%@&start=0&num=5%@", url, code, JCLRandom];
    [JCLHttpsObj JCLGetStr:urlStr success:^(NSArray *obj) {
        !success ? : success(obj);
    } failure:^(NSError *error) { !failure ? : failure(error); }];
}
@end
