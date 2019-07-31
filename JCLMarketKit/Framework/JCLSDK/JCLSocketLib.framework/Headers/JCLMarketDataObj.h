//
//  JCLHttpsObjManage.h
//  Jincelue_Sdk
//
//  Created by 邢昭俊 on 2017/2/23.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCLMarketDataObj : NSObject
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
                      failure:(failureBlock)failure;

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
                failure:(failureBlock)failure;

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
                  failure:(failureBlock)failure;

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
                    failure:(failureBlock)failure;

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
                    failure:(failureBlock)failure;

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
                    failure:(failureBlock)failure;

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
                        failure:(failureBlock)failure;

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
                       failure:(failureBlock)failure;
@end
