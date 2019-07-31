//
//  JCLHttpsObj.h
//  JCLMarketLib
//
//  Created by 邢昭俊 on 2017/3/29.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^successBlock) (id obj);
typedef void (^failureBlock) (NSError *error);
@interface JCLHttpsObj : NSObject
+(void)JCLGetStr:(NSString *)url success:(successBlock)success failure:(failureBlock)failure;
+(void)JCLGetJson:(NSString *)url success:(successBlock)success failure:(failureBlock)failure;
+(void)JCLGetXml:(NSString *)url success:(successBlock)success failure:(failureBlock)failure;
+(void)JCLPostJson:(NSString *)url parame:(id)parame success:(successBlock)success failure:(failureBlock)failure;

+(NSArray *)JCLHandleStr:(NSArray *)arr begin:(NSInteger)begin end:(NSInteger)end;
+(NSInteger)JCLNetworkStatus;
@end
