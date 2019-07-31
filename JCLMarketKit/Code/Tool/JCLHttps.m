//
//  JCLHttps.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 24/10/2016.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "JCLHttps.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
@implementation JCLHttps
static AFHTTPSessionManager *session;
+ (AFHTTPSessionManager *)session{
    if (!session) {
        session = [AFHTTPSessionManager manager];
        session.requestSerializer = [AFHTTPRequestSerializer serializer];
        session.requestSerializer.timeoutInterval = 10;
        session.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return session;
}

+ (void)getString:(id)url success:(successBlock)success{
    [[self session] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id obj = [[[NSString alloc] initWithData:[self utf8:responseObject] encoding:NSUTF8StringEncoding] componentsSeparatedByString:@"\r\n"];
        !success ? : success(obj);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self requestFailed:error];
    }];
}

+ (void)getString:(id)url success:(successBlock)success failure:(failureBlock)failure{
    [[self session] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id obj = [[[NSString alloc] initWithData:[self utf8:responseObject] encoding:NSUTF8StringEncoding] componentsSeparatedByString:@"\r\n"];
        !success ? : success(obj);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure ? : failure(error);
    }];
}

+ (void)getJson:(id)url success:(successBlock)success{
    [[self session] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id obj = [NSJSONSerialization JSONObjectWithData:[self utf8:responseObject]
                                                 options:NSJSONReadingAllowFragments
                                                   error:nil];
        !success ? : success(obj);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self requestFailed:error];
    }];
}

+ (void)getJson:(id)url success:(successBlock)success failure:(failureBlock)failure{
    [[self session] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id obj = [NSJSONSerialization JSONObjectWithData:[self utf8:responseObject]
                                                 options:NSJSONReadingAllowFragments
                                                   error:nil];
        !success ? : success(obj);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure ? : failure(error);
    }];
}

+ (void)postJson:(id)url parame:(id)parame success:(successBlock)success{
    [[self session] POST:url parameters:parame progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id obj = [NSJSONSerialization JSONObjectWithData:[self utf8:responseObject]
                                                 options:NSJSONReadingAllowFragments
                                                   error:nil];
        !success ? : success(obj);
     
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self requestFailed:error];
    }];
}

+(NSMutableArray *)splitArrayM:(NSArray *)array begin:(NSInteger)begin end:(NSInteger)end{
    NSMutableArray *arrayM =[[NSMutableArray alloc] init];
    NSArray *split = array;
    split = [split objectsAtIndexes:[[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(begin, end)]];
    for (NSInteger i = 0; i < split.count; i++) {
        NSArray *group = [split[i] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        [arrayM addObject:group];
    }
    return arrayM;
}

+ (NSData *)utf8:(NSData *)data{
    char aa[] = {'A','A','A','A','A','A'};
    NSMutableData *md = [NSMutableData dataWithData:data];
    int loc = 0;
    while(loc < [md length]){
        char buffer;
        [md getBytes:&buffer range:NSMakeRange(loc, 1)];
        if((buffer & 0x80) == 0){
            loc++;
            continue;
        }else if((buffer & 0xE0) == 0xC0) {
            loc++;
            [md getBytes:&buffer range:NSMakeRange(loc, 1)];
            if((buffer & 0xC0) == 0x80){
                loc++;
                continue;
            } loc--;
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1];
            loc++;
            continue;
        }else if((buffer & 0xF0) == 0xE0){
            loc++;
            [md getBytes:&buffer range:NSMakeRange(loc, 1)];
            if((buffer & 0xC0) == 0x80){
                loc++;
                [md getBytes:&buffer range:NSMakeRange(loc, 1)];
                if((buffer & 0xC0) == 0x80){
                    loc++;
                    continue;
                } loc--;
            } loc--;
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1];
            loc++;
            continue;
        }else{
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1];
            loc++;
            continue;
        }
    }
    return md;
}

+ (void)requestFailed:(NSError *)error{
    switch (error.code) {
        case NSURLErrorNotConnectedToInternet :
            NSLog(@"网络链接失败，请检查网络。");
               // [JCLSVProgressHUD showErrorHud:@"网络链接失败,请检查网络!"];
            break;
        case NSURLErrorTimedOut:
            NSLog(@"访问服务器超时，请检查网络。");
            //[JCLSVProgressHUD showErrorHud:@"访问服务器超时，请检查网络!"];

            break;
            
        case NSURLErrorBadServerResponse :
            //[JCLSVProgressHUD showErrorHud:@"服务器报错了，请稍后再访问!"];
            NSLog(@"服务器报错了，请稍后再访问。");
            break;
        case NSURLErrorCannotConnectToHost:
        {
//            [GCDQueue executeInMainQueue:^{
//                [JCLSVProgressHUD showErrorHud:@"请求超时!"];
//            } afterDelaySecs:1.0f];
        }
            break;
        default:
            break;
    }
    NSLog(@"--------------\n%ld %@",(long)error.code, error.debugDescription);
}

+(void)listenNetworkStatus{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                //[JCLObject setupAlert:@"无网络！"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                break;
            default:
                break;
        }
    }] ;
}

//获取Tkone
+(void)tokenSuccess:(successBlock)success failure:(failureBlock)failure{
    NSDictionary *dict = @{@"username":@"appios",@"password":@"1q2w3e4r-beyond"};
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];//设
    NSString *urls =    [NSString stringWithFormat:@"%@/%@",baseApiURlA,@"auth"];
    NSLog(@"------  %@",urls);
    [sessionManager POST: urls
              parameters:dict
                progress:^(NSProgress *downloadProgress) {
                    
                }
                 success:^(NSURLSessionDataTask *task, id responseObject) {
                    NSDictionary *dict = (NSDictionary *)responseObject;
                   NSLog(@"responseObject%@", responseObject);
                    MMResultV2Model *model = [MMResultV2Model modelWithDictionary:dict];
//                    NSLog(@"modelmodel%@", model.code);
                     if (model.code.intValue == 200) {
                         NSDictionary *dict = (NSDictionary *)model.data;
                         PreWrite(dict[@"token"], @"Token");
                         success(dict[@"token"]);
                     }else{
                        [JCLFramework showErrorHud:model.message];
                     }
                   
                 }
                 failure:^(NSURLSessionDataTask *task, NSError *error) {
                     NSLog(@"errorerrorerror%@", error);
                     failure(error);
                }];
    
}

+(void)httpPOSTRequest:(NSString *)url params:(NSDictionary*)params success:(successBlock)success failure:(failureBlock)failure{
 
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];//设
    NSString *str = PreRead(@"Token");
    [sessionManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",str] forHTTPHeaderField:@"Authorization"];
    NSLog(@"----tttoken----%@",[NSString stringWithFormat:@"Bearer %@",str]);
//    NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlA,url];
     NSLog(@"postUrl  %@",url);
     NSLog(@"params  %@",params);
    [sessionManager POST:url
              parameters:params
                progress:^(NSProgress *downloadProgress) {
                    
                }
                 success:^(NSURLSessionDataTask *task, id responseObject) {
                      NSLog(@"responseObjectsssss %@",responseObject);
                     NSDictionary *dict = (NSDictionary *)responseObject;
         
                     MMResultV2Model *model = [MMResultV2Model modelWithDictionary:dict];
                
                     success(model);
                     
                 }
                 failure:^(NSURLSessionDataTask *task, NSError *error) {
                     NSLog(@"errorerrorerror%@", error);
                     failure(error);
                 }];
    
}
+(void)httpImageUpload:(NSString *)url params:(NSDictionary*)params headImage:(id)headImage success:(successBlock)success failure:(failureBlock)failure{
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer.timeoutInterval = 20;
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    
    NSString *str = PreRead(@"Token");
    [sessionManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",str] forHTTPHeaderField:@"Authorization"];
    
    NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlA,url];
    NSLog(@"postUrl  %@",postUrl);
    NSLog(@"params  %@",params);
    [sessionManager POST:postUrl
                    parameters:params
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    //取出单张图片二进制数据
    id obj = headImage;
    UIImage *image = nil;
    if ([obj isKindOfClass:[UIImage class]]) {
        image = (UIImage *)obj;
    }else{
        image = [UIImage imageWithContentsOfFile:obj];
    }
    if (image) {
        
        UIImage *image = headImage;
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        
        // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
        // 要解决此问题，
        // 可以在上传时使用当前的系统事件作为文件名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *dateString = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
        /*
         *该方法的参数
         1. appendPartWithFileData：要上传的照片[二进制流]
         2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
         3. fileName：要保存在服务器上的文件名
         4. mimeType：上传的文件的类型
         */
        NSLog(@"filename %@",fileName);
        [formData appendPartWithFileData:imageData name:@"upload" fileName:fileName mimeType:@"image/jpeg"]; //
    }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObjectsssss %@",responseObject);
         NSDictionary *dict = (NSDictionary *)responseObject;
         MMResultV2Model *model = [MMResultV2Model modelWithDictionary:dict];
         success(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"errorerrorerror%@", error);
       failure(error);
    }];
 
}
@end
