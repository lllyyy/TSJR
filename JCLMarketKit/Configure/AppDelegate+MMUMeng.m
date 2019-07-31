
#import "AppDelegate+MMUMeng.h"
#import <UMCommon/UMCommon.h>



#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define _IPHONE80_ 80000

@implementation AppDelegate (MMUMeng)

- (void)configureUMeng {
    
    [UMConfigure initWithAppkey:UMENG_APPKEY channel:@"App Store"];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXKEY appSecret:WXSecret redirectURL:nil];
   
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQKEY  appSecret:QQSecret redirectURL:nil];
    
}


- (void)configureUShare {
    /* 设置友盟appkey */
   
    
}

 

 
@end
