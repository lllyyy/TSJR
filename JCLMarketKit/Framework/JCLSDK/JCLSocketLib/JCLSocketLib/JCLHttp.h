//
//  JCLHttpsObj.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 24/10/2016.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^successBlock) (id obj);
typedef void (^failureBlock) (NSError *error);
@interface JCLHttp : NSObject
+(void)JCLGetStr:(NSString *)url success:(successBlock)success failure:(failureBlock)failure;
+(void)JCLGetJson:(NSString *)url success:(successBlock)success failure:(failureBlock)failure;
+(void)JCLGetXml:(NSString *)url success:(successBlock)success failure:(failureBlock)failure;
+(void)JCLPostJson:(NSString *)url parame:(id)parame success:(successBlock)success failure:(failureBlock)failure;

+(NSArray *)JCLHandleStr:(NSArray *)arr begin:(NSInteger)begin end:(NSInteger)end;
+(NSInteger)JCLNetworkStatus;
 
@end
