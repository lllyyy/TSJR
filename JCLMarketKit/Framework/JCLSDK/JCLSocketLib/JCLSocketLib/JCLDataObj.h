//
//  JCLDataObj.h
//  JCLMarketLib
//
//  Created by 邢昭俊 on 2017/3/29.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCLDataObj : NSObject
+(NSString *)JCLPinYin:(NSString *)str;
+(NSString *)JCLPinYinFirst:(NSString *)str;

+(NSString *)JCLBundle:(NSString *)val;
+(NSArray *)JCLPolyphone:(NSDictionary *)dic val:(NSString *)val;
@end
