//
//  JCLHttpsObj.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 24/10/2016.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "JCLHttp.h"
#import "AFNetworking.h"

@implementation JCLHttp
static AFHTTPSessionManager *session;
+ (AFHTTPSessionManager *)session{
    if (!session) {
        session = [AFHTTPSessionManager manager];
        session.requestSerializer = [AFHTTPRequestSerializer serializer];
        session.requestSerializer.timeoutInterval = 8;
        session.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return session;
}

+(void)JCLGetStr:(NSString *)url success:(successBlock)success failure:(failureBlock)failure{
    NSLog(@"url  %@",url);
    
  
    [[self session] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject  %@",responseObject);
        !success ? : success([[[NSString alloc] initWithData:[self utf8:responseObject] encoding:NSUTF8StringEncoding] componentsSeparatedByString:@"\r\n"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure ? : failure(error);
    }];
}

+(void)JCLGetJson:(NSString *)url success:(successBlock)success failure:(failureBlock)failure{
    [[self session] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        !success ? : success([NSJSONSerialization JSONObjectWithData:[self utf8:responseObject] options:NSJSONReadingAllowFragments error:nil]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure ? : failure(error);
    }];
}

+(void)JCLGetXml:(NSString *)url success:(successBlock)success failure:(failureBlock)failure{
    [[self session] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        !success ? : success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure ? : failure(error);
    }];
}

+(NSData *)utf8:(NSData *)data{
    char aa[] = {'A','A','A','A','A','A'};
    NSMutableData *md = [NSMutableData dataWithData:data];
    int loc = 0;
    while(loc < [md length]){
        char buffer;
        [md getBytes:&buffer range:NSMakeRange(loc, 1)];
        if((buffer & 0x80) == 0){ loc++; continue;
        } else if((buffer & 0xE0) == 0xC0) { loc++;
            [md getBytes:&buffer range:NSMakeRange(loc, 1)];
            if((buffer & 0xC0) == 0x80){ loc++; continue;
            } loc--;
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1]; loc++; continue;
        } else if((buffer & 0xF0) == 0xE0){ loc++;
            [md getBytes:&buffer range:NSMakeRange(loc, 1)];
            if((buffer & 0xC0) == 0x80){ loc++;
                [md getBytes:&buffer range:NSMakeRange(loc, 1)];
                if((buffer & 0xC0) == 0x80){ loc++; continue;
                } loc--;
            } loc--;
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1]; loc++; continue;
        } else {
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1]; loc++; continue;
        }
    }
    return md;
}

+(void)JCLPostJson:(NSString *)url parame:(id)parame success:(successBlock)success failure:(failureBlock)failure{
    [[self session] POST:url parameters:parame progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        !success ? : success([NSJSONSerialization JSONObjectWithData:[self utf8:responseObject] options:NSJSONReadingAllowFragments error:nil]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure ? : failure(error);
    }];
}

+(NSArray *)JCLHandleStr:(NSArray *)arr begin:(NSInteger)begin end:(NSInteger)end{
    NSArray *split = [arr objectsAtIndexes:[[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(begin, end)]];
    NSMutableArray *arrM =[[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < split.count; i++) {
        NSArray *group = [split[i] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        [arrM addObject:group];
    }
    return arrM;
}

+(NSInteger)JCLNetworkStatus{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    __block NSInteger style = 0;
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable: style = 0; NSLog(@"44440"); break;
            case AFNetworkReachabilityStatusReachableViaWWAN: style = 1;NSLog(@"44441"); break;
            case AFNetworkReachabilityStatusReachableViaWiFi: style = 2;NSLog(@"44442"); break;
            default: break;
        }
    }];
    [manager startMonitoring];
    return style;
}


@end
