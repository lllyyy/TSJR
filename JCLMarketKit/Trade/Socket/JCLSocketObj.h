//
//  JCLSocketObj.h
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/7/19.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCLSocketObj : NSObject
+(instancetype)share;
-(BOOL)connect;
-(void)disConnect;
-(void)JCLSocketRequst:(NSDictionary *)dic idx:(NSInteger)idx;
@property(nonatomic, copy) void (^socketActionBlock)(NSDictionary *dic, NSInteger idx);
@end
