//
//  JCLFramework.m
//  Jincelue
//
//  Created by 邢昭俊 on 2017/2/10.
//  Copyright © 2017年 ruixue. All rights reserved.
//

#import "JCLFramework.h"

@implementation JCLFramework
#pragma mark - SDWebImage
+(void)JCLWebImage:(UIImageView *)parent icon:(NSString *)icon{
    [parent sd_setImageWithURL:[NSURL URLWithString:icon] placeholderImage:[UIImage imageNamed:@"IM_User"]];
}

#pragma mark - SVProgressHUD
+(void)JCLProgressHUD:(NSString *)str{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus:str];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
}
+(void)JCLProgressUPHUD:(NSString *)str{
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus:str];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    
    
    
}
+(void)Dismiss{
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(HUDTime * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
}
+(void)showSuccess:(NSString *)str
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showSuccessWithStatus:str];
    [SVProgressHUD setMinimumDismissTimeInterval:2];
}
+(void)showErrorHud:(NSString *)str
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showErrorWithStatus:str];
    [SVProgressHUD setMinimumDismissTimeInterval:2];
}
 
@end
