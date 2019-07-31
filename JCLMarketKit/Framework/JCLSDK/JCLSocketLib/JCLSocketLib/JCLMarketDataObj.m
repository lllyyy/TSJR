//
//  JCLHttpsObjManage.m
//  Jincelue_Sdk
//
//  Created by 邢昭俊 on 2017/2/23.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLMarketDataObj.h"
#import "JCLDataObj.h"

@implementation JCLMarketDataObj
/**
 * 根据市场前缀编号获取市场代码链更新信息
 * @param url       域名
 * @param codeType  市场前缀编号 (PS:如:SZ,SH,....)
 * @param success   数据请求成功的回调
 * @param failure   数据请求失败的回调
 */
+(void)JCLGetMarketCodeUpdate:(NSString *)url
                     codeType:(NSString *)codeType
                      success:(successBlock)success
                      failure:(failureBlock)failure{
    NSString *urlStr = [NSString stringWithFormat:@"%@/FreeHQWebServer/hostmore?setcode=%@", url, codeType];
    [JCLHttpsObj JCLGetJson:urlStr success:^(id obj) {
        !success ? : success(obj);
    } failure:^(NSError *error) { !failure ? : failure(error); }];
}

/**
 * 根据市场前缀编号获取市场代码链
 * @param url       域名
 * @param codeType  市场前缀编号 (PS:如:SZ,SH,....)
 * @param success   数据请求成功的回调
 * @param failure   数据请求失败的回调
 */
+(void)JCLGetMarketCode:(NSString *)url
                     codeType:(NSString *)codeType
                      success:(successBlock)success
                      failure:(failureBlock)failure{
    NSString *urlStr = [NSString stringWithFormat:@"%@/FreeHQWebServer/codelist?symbol=%@", url, codeType];
    [JCLHttpsObj JCLGetStr:urlStr success:^(NSArray *obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[JCLDataObj JCLBundle:@"py.plist"]];

        NSArray *arr = [JCLHttpsObj JCLHandleStr:obj begin:2 end:obj.count - 3];
        NSMutableArray *arrM = [[NSMutableArray alloc]init];
        [arr enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableArray *pys = [[NSMutableArray alloc]init];
            NSString *code = [NSString stringWithFormat:@"%@%@", obj[1], obj[2]];
            
            NSMutableArray *codes = [[NSMutableArray alloc]init];
            [obj enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [codes addObject:obj];
            }];
            [codes addObject:code];
            
            [pys addObjectsFromArray:codes];
            if ([self isChinese:obj[3]]) {
                [pys addObjectsFromArray:[JCLDataObj JCLPolyphone:dic val:obj[3]]];
            }
            [arrM addObject:pys];
        }];
        !success ? : success(arrM);
    } failure:^(NSError *error) { !failure ? : failure(error); }];
}

+(BOOL)isChinese:(NSString *)str{
    for(int i=0; i<str.length; i++) {
        int a = [str characterAtIndex:i];
        if(a > 0x4e00 && a < 0x9fff) return YES;
    }
    return NO;
}

/**
* 根据多个个股代码编号获取盘口信息
* @param url             域名
* @param code            代码编号
* @param success         数据请求成功的回调
* @param failure         数据请求失败的回调
*/
+ (void)JCLGetMarketInfos:(NSString *)url
                     code:(NSArray *)code
                  success:(successBlock)success
                  failure:(failureBlock)failure{
    __block NSString *codes = @"";
    NSLog(@"urlurl  %@",url);
     NSLog(@"code  %@",code);
    
    [code enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (code.count > 1) {
            codes = [NSString stringWithFormat:@"%@&symbol=%@", codes, obj];
             NSLog(@"codescodes  %@",codes);
        } else {
            codes = [NSString stringWithFormat:@"symbol=%@", obj];
        }
    }];
    NSString *urlStr = [NSString stringWithFormat:@"%@/FreeHQWebServer/report?%@%@", url, codes, JCLRandom];
     NSLog(@"urlStrurlStr  %@",urlStr);
    [JCLHttpsObj JCLGetStr:urlStr success:^(NSArray *obj) {
         NSLog(@"objobjobjobj  %@",obj);
 
        !success ? : success(obj);
    } failure:^(NSError *error) { !failure ? : failure(error); }];
}

/**
 * 获取市场排序后的信息
 * @param url       域名
 * @param page      分页(起始分页为0)
 * @param number    每个分页的个数
 * @param mainType  入口type (参考市场入口Define)
 * @param sortType  排序type (参考市场排序Define)
 * @param info      市场排序字段 （PS:多个字段用*拼接，如:0*1*2）参考市场信息Define
 * @param sort      排序类型 （PS:参考排序Define）
 * @param success   数据请求成功的回调
 * @param failure   数据请求失败的回调
 */
+(void)JCLGetMarketSortInfo:(NSString *)url
                       page:(NSInteger)page
                     number:(NSInteger)number
                   mainType:(NSString *)mainType
                   sortType:(NSString *)sortType
                       info:(NSString *)info
                       sort:(NSString *)sort
                    success:(successBlock)success
                    failure:(failureBlock)failure{
    NSString *urlStr = [NSString stringWithFormat:@"%@/FreeSortWebServer/domainsorthq?start=%ld&num=%ld&setdomain=%@&coltype=%@&sortid=%@&sorttype=%@&synid=%@%@",
                     url, (long)page, (long)number, mainType, sortType, info, sort, Random, JCLRandom];
    NSLog(@"urlStrurlStr  %@",urlStr);
    [JCLHttpsObj JCLGetStr:urlStr success:^(NSArray *obj) {
        !success ? : success(obj);
    } failure:^(NSError *error) { !failure ? : failure(error); }];
}

/**
 * 根据市场代码获取市场排序后的信息
 * @param url       域名
 * @param page      分页(起始分页为0)
 * @param number    每个分页的个数
 * @param mainType  入口type (参考市场入口Define)
 * @param sortType  排序type (参考市场排序Define)
 * @param info      市场排序字段 （PS:多个字段用*拼接，如:0*1*2）参考市场信息Define
 * @param sort      排序类型 （PS:参考排序Define）
 * @param code      市场代码
 * @param success   数据请求成功的回调
 * @param failure   数据请求失败的回调
 */
+(void)JCLGetMarketSortInfo:(NSString *)url
                       page:(NSInteger)page
                     number:(NSInteger)number
                   mainType:(NSString *)mainType
                   sortType:(NSString *)sortType
                       info:(NSString *)info
                       sort:(NSString *)sort
                       code:(NSString *)code
                    success:(successBlock)success
                    failure:(failureBlock)failure{
    NSString *urlStr = [NSString stringWithFormat:@"%@/FreeSortWebServer/domainsorthq?start=%ld&num=%ld&setdomain=%@&coltype=%@&sortid=%@&sorttype=%@&symbol=%@&synid=10012%@",
                     url, (long)page, (long)number, mainType, sortType, info, sort, code, JCLRandom];
    [JCLHttpsObj JCLGetStr:urlStr success:^(NSArray *obj) {
        !success ? : success(obj);
    } failure:^(NSError *error) { !failure ? : failure(error); }];
}

/**
 * 获取带有子市场排序后的信息
 * @param url       域名
 * @param page      分页(起始分页为0)
 * @param number    每个分页的个数
 * @param mainType  入口type (参考市场入口Define)
 * @param sortType  排序type (参考市场排序Define)
 * @param info      市场排序字段 （PS:多个字段用*拼接，如:0*1*2）参考市场信息Define
 * @param subInfo   子市场排序字段 （PS:多个字段用*拼接，如:0*1*2）参考市场信息Define
 * @param sort      排序类型 （PS:参考排序Define）
 * @param success   数据请求成功的回调
 * @param failure   数据请求失败的回调
 */
+(void)JCLGetMarketSortInfo:(NSString *)url
                       page:(NSInteger)page
                     number:(NSInteger)number
                   mainType:(NSString *)mainType
                   sortType:(NSString *)sortType
                       info:(NSString *)info
                    subInfo:(NSString *)subInfo
                       sort:(NSString *)sort
                    success:(successBlock)success
                    failure:(failureBlock)failure{
    NSString *urlStr = [NSString stringWithFormat:@"%@/FreeSortWebServer/domainsorthq?start=%ld&num=%ld&setdomain=%@&coltype=%@&sortid=%@&subsortid=%@&sorttype=%@&synid=10012%@",
                     url, (long)page, (long)number, mainType, sortType, info, subInfo, sort, JCLRandom];
    [JCLHttpsObj JCLGetStr:urlStr success:^(NSArray *obj) {
        !success ? : success(obj);
    } failure:^(NSError *error) { !failure ? : failure(error); }];
}

/**
 * 获取市场自选排序后的信息
 * @param url       域名
 * @param page      分页(起始分页为0)
 * @param number    每个分页的个数
 * @param mainType  入口type (参考市场入口Define)
 * @param sortType  排序type (参考市场排序Define)
 * @param info      市场排序字段 （PS:多个字段用*拼接，如:0*1*2）参考市场信息Define
 * @param sort      排序类型 （PS:参考排序Define）
 * @param code      市场代码
 * @param success   数据请求成功的回调
 * @param failure   数据请求失败的回调
 */
+(void)JCLGetMarketSelfsortInfo:(NSString *)url
                           page:(NSInteger)page
                         number:(NSInteger)number
                       mainType:(NSString *)mainType
                       sortType:(NSString *)sortType
                           info:(NSString *)info
                           sort:(NSString *)sort
                           code:(NSString *)code
                        success:(successBlock)success
                        failure:(failureBlock)failure{
    NSString *urlStr = [NSString stringWithFormat:@"%@/FreeSortWebServer/selfsorthq?start=%ld&num=%ld&setdomain=%@&coltype=%@&sortid=%@&sorttype=%@&symbol=%@&synid=10012%@",
                     url, (long)page, (long)number, mainType, sortType, info, sort, code, JCLRandom];
    [JCLHttpsObj JCLGetStr:urlStr success:^(NSArray *obj) {
        !success ? : success(obj);
    } failure:^(NSError *error) { !failure ? : failure(error); }];
}

/**
 * 获取市场资金信息
 * @param url       域名
 * @param page      分页(起始分页为0)
 * @param number    每个分页的个数
 * @param mainType  入口type (参考市场入口Define)
 * @param sortType  排序type (参考市场排序Define)
 * @param info      市场排序字段 （PS:多个字段用*拼接，如:0*1*2）参考市场信息Define
 * @param sort      排序类型 （PS:参考排序Define）
 * @param code      市场代码
 * @param success   数据请求成功的回调
 * @param failure   数据请求失败的回调
 */
+(void)JCLGetMarketCapitalInfo:(NSString *)url
                          page:(NSInteger)page
                        number:(NSInteger)number
                      mainType:(NSString *)mainType
                      sortType:(NSString *)sortType
                          info:(NSString *)info
                          sort:(NSString *)sort
                          code:(NSString *)code
                       success:(successBlock)success
                       failure:(failureBlock)failure{
    NSString *urlStr = [NSString stringWithFormat:@"%@/FreeSortWebServer/selfsorthq?start=%ld&num=%ld&setdomain=%@&coltype=%@&sortid=%@&sorttype=%@&symbol=%@&synid=10012%@",
                     url, (long)page, (long)number, mainType, sortType, info, sort, code, JCLRandom];
    [JCLHttpsObj JCLGetStr:urlStr success:^(NSArray *obj) {
        !success ? : success(obj);
    } failure:^(NSError *error) { !failure ? : failure(error); }];
}
@end
