//
//  JCLFramework.h
//  Jincelue
//
//  Created by 邢昭俊 on 2017/2/10.
//  Copyright © 2017年 ruixue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "MJRefresh.h"

@interface JCLFramework : NSObject
#pragma mark - SDWebImage
#define UserIcon @"lxkf"
+(void)JCLWebImage:(UIImageView *)parent icon:(NSString *)icon;

#pragma mark - SVProgressHUD
#define HUDTime 1
+(void)JCLProgressUPHUD:(NSString *)str;
+(void)Dismiss;
+(void)JCLProgressHUD:(NSString *)str;
+(void)showErrorHud:(NSString *)str;
+(void)showSuccess:(NSString *)str;
 
@end
