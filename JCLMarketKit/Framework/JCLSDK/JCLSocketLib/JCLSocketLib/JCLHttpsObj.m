//
//  JCLHttpsObj.m
//  JCLMarketLib
//
//  Created by 邢昭俊 on 2017/3/29.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLHttpsObj.h"
#import "JCLHttp.h"

@implementation JCLHttpsObj
+(void)JCLGetStr:(NSString *)url success:(successBlock)success failure:(failureBlock)failure{
    [JCLHttp JCLGetStr:url success:success failure:failure];
}

+(void)JCLGetJson:(NSString *)url success:(successBlock)success failure:(failureBlock)failure{
    [JCLHttp JCLGetJson:url success:success failure:failure];
}

+(void)JCLPostJson:(NSString *)url parame:(id)parame success:(successBlock)success failure:(failureBlock)failure{
    [JCLHttp JCLPostJson:url parame:parame success:success failure:failure];
}

+(NSArray *)JCLHandleStr:(NSArray *)arr begin:(NSInteger)begin end:(NSInteger)end{
    return [JCLHttp JCLHandleStr:arr begin:begin end:end];
}

+(void)JCLGetXml:(NSString *)url success:(successBlock)success failure:(failureBlock)failure{
    return [JCLHttp JCLGetXml:url success:success failure:failure];
}
 
+(NSInteger)JCLNetworkStatus{ return [JCLHttp JCLNetworkStatus]; }
@end
