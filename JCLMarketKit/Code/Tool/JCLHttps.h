//
//  JCLHttps.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 24/10/2016.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import <UIKit/UIKit.h>

#define JCLURL90 @"http://120.55.184.28:9001/FreeHQWebServer/" // 行情
#define JCLURL83 @"http://120.55.184.28:9001/FreeSortWebServer/" //排序HTTP：
#define JCLURL81 @"http://120.55.184.28:9001/freezjwebserver/" //资金HTTP：


#define JCLURL98 @"http://120.55.184.28:9001/freedoopwebserver/" //选股：
#define JCLURL82 @"http://120.55.184.28:9001/freecomselwebserver/cloudcalcsort/" //股票池HTTP：

#define JCLURL08 @"http://120.26.228.246:80/logo/" //静态页面地址HTTP：
#define JCLURL88 @"http://embedded-web.fh.jincelue.net:8088/servlet/"
#define JCLURL8888 @"http://embedded-web.fh.jincelue.net:8088/"

#define XLDURL @"http://120.26.228.246:8188/yssys/servlet/" // 内网
#define XLDURL1 @"http://embedded-web.fh.jincelue.net:8088/"
//#define XLDURL1 @"http://120.26.106.242:8018/" //测试

#define XLDNewURL @"http://yhzb.mytv365.com/News_WebService/News/" 

#define JCLXMLHost @"http://121.41.49.99/mobileauth/auth.do?" // XML

#define JCLFTP @"ftp://120.26.228.246:3303"
#define JCLFTPUSER @"softweb"
#define JCLFTPPASS @"pwsoftwebys*"

#define JCLRandom [NSString stringWithFormat:@"&r=%u",arc4random_uniform(1000000)]
#define Random [NSString stringWithFormat:@"%u",arc4random_uniform(1000000)]

typedef void (^successBlock) (id obj);
typedef void (^failureBlock) (NSError *error);

@interface JCLHttps : NSObject
+(void)listenNetworkStatus;
+(void)getString:(id)url success:(successBlock)success;
+(void)getString:(id)url success:(successBlock)success failure:(failureBlock)failure;
+(void)getJson:(id)url success:(successBlock)success;
+(void)getJson:(id)url success:(successBlock)success failure:(failureBlock)failure;
+(void)getXml:(id)url success:(successBlock)success;
+(void)postJson:(id)url parame:(id)parame success:(successBlock)success;
+(NSMutableArray *)splitArrayM:(NSArray *)array begin:(NSInteger)begin end:(NSInteger)end;
+ (NSData *)utf8:(NSData *)data;

//获取token
+(void)tokenSuccess:(successBlock)success failure:(failureBlock)failure;
//网络请求
+(void)httpPOSTRequest:(NSString *)url params:(NSDictionary*)params success:(successBlock)success failure:(failureBlock)failure;
//上传图片
+(void)httpImageUpload:(NSString *)url params:(NSDictionary*)params headImage:(id)headImage success:(successBlock)success failure:(failureBlock)failure;
@end
