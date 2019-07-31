//
//  AppDelegate.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/6/20.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "AppDelegate.h"
#import "JCLDateObj.h"
#import "JCLSocketObj.h"
#import "RXMLElement.h"
#import "JCLTabBarList.h"
#import "AFNetworking.h"
#import "XHLaunchAd.h"
#import <AVFoundation/AVFoundation.h>
#import "JCLTradeDefine.h"
#import "AppDelegate+MMUMeng.h"
#import <MeiQiaSDK/MQManager.h>
#import <Bugly/Bugly.h>
#import "MRCHomepageViewModel.h"
#import "MRCNavigationControllerStack.h"
#import "MRCViewModelServicesImpl.h"
#import "Harpy.h"
#import "TSJRStokeCoderModel.h"

@interface AppDelegate ()<HarpyDelegate>
@property (nonatomic, weak) NSTimer *updateTimer;
@property (nonatomic, weak) NSTimer *codeTimer;
@property (nonatomic, strong) MRCViewModelServicesImpl *services;
@property (nonatomic, strong) MRCViewModel *viewModel;
@property (nonatomic, strong, readwrite) MRCNavigationControllerStack *navigationControllerStack;
@end

@implementation AppDelegate

+(AppDelegate* )shareAppDelegate {
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
     [self getToken];
 
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    JCLMarketObj *business = [[JCLMarketObj alloc]init];
//     [business loadUpdateCodeData];

    self.main = [[JCLMainList alloc] init];
    self.window.rootViewController = self.main;
    NSError *setCategoryErr = nil;
    NSError *activationErr  = nil;
    [[AVAudioSession sharedInstance]
     setCategory: AVAudioSessionCategoryPlayback
     error: &setCategoryErr];
    [[AVAudioSession sharedInstance]
     setActive: YES
     error: &activationErr];
 
 
//    self.polling = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimerAction:) userInfo:nil repeats:YES];
 
    if (@available(ios 11.0,*)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }
    
    [[JCLSocketObj share] connect];
    [self configureMeiQia];
//    [self initCode];
    [self CheckNetWorkStatus];
    [self configureUMeng];
   
    [[NSUserDefaults standardUserDefaults] setValue:MRC_APP_VERSION forKey:MRCApplicationVersionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
//    [self initDBCode];
    return YES;
}
 
-(void)configureMRC{
    self.services = [[MRCViewModelServicesImpl alloc] init];
    self.navigationControllerStack = [[MRCNavigationControllerStack alloc] initWithServices:self.services];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.services resetRootViewModel:[self createInitialViewModel]];
    [self.window makeKeyAndVisible];
}

- (MRCViewModel *)createInitialViewModel {
    // The user has logged-in.
    return [[MRCHomepageViewModel alloc] initWithServices:self.services params:nil];
    
}

-(void)configureMeiQia{
    [MQManager initWithAppkey:MeiQia_APPKEY completion:^(NSString *clientId, NSError *error) {
         if (!error) {
            NSLog(@"美洽 SDK：初始化成功");
        } else {
            NSLog(@"error:%@",error);
        }
        
    }];
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
#pragma mark  集成第四步: 上传设备deviceToken
    [MQManager registerDeviceToken:deviceToken];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

-(void)CheckNetWorkStatus{
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                //未知网络
                NSLog(@"未知网络");
                PreWrite(nil, @"network");
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                PreWrite(nil, @"network");
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"无网络连接!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                //手机自带网络
                NSLog(@"当前使用的是2g/3g/4g网络");
                PreWrite(@"yes", @"network");
              
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                //WIFI
                NSLog(@"当前在WIFI网络下");
                PreWrite(@"yes", @"network");
               
            }
        }
    }];
}

-(void)updateTimerAction:(NSTimer *)timer{
 
    NSString *ss = [JCLDateObj JCLDateFormat:[NSDate date] format:@"ss"];
    NSLog(@"SSSSSS %@",ss);
    if(ss.integerValue%5==0){
        !self.timerAtionBlock ? : self.timerAtionBlock(timer);
        
//        JCLMarketObj *business = [[JCLMarketObj alloc]init];
//        [business loadUpdateCodeData];
//        [self userAction];
//        [self userCapitalInfo];
    }
   
}
-(void)userAction{
    NSString *url = [NSString stringWithFormat:@"%@id=%@&online=%@&cmd=unique", JCLAuthURL, [JCLUserData getUserInfo].username, [JCLUserData getUserInfo].online];
    [JCLHttpsObj JCLGetXml:url success:^(id obj) {
        RXMLElement *xml = [RXMLElement elementFromXMLString:[[NSString alloc] initWithData:obj encoding:NSUTF8StringEncoding] encoding:NSUTF8StringEncoding];
        NSString *result = [xml child:@"result"].text;
        if (![result isEqualToString:@"1"]){
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"您的账户在其他设备登录，请重新登录."
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      NSFileManager *manager = [NSFileManager defaultManager]; [manager removeItemAtPath:CachesFile(JCLUser) error:NULL];
                                                                      JCLUserLoginList *list = [[JCLUserLoginList alloc] init];
                                                                      list.popActionBlock = ^(){
                                                                          [UIApplication sharedApplication].keyWindow.rootViewController = [[JCLTabBarList alloc] init];
                                                                      };
                                                                      [UIApplication sharedApplication].keyWindow.rootViewController = list;
                                                                  }];
            [alert addAction:defaultAction];
        }
    } failure:^(NSError *error) { }];
}
-(UIViewController *)popRootList{
    UIViewController *list = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (list.presentedViewController) { list = list.presentedViewController; }
    return list;
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
#pragma mark  集成第三步: 进入后台 关闭美洽服务
    [MQManager closeMeiqiaService];
    [[JCLSocketObj share]disConnect];
    [self.polling setFireDate:[NSDate distantFuture]];
    UIApplication*   app = [UIApplication sharedApplication];
    __block    UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    });
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
#pragma mark  集成第二步: 进入前台 打开meiqia服务
    [MQManager openMeiqiaService];
    [[JCLSocketObj share] connect];
    [self.polling setFireDate:[NSDate distantPast]];
    [self getAccessToken];
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
     [[Harpy sharedInstance] checkVersion];
}
-(void)userCapitalInfo{
    if (![JCLUserData getUserInfo].username) {
        return;
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary *dic = @{ @"client_id" : [JCLUserData getUserInfo].username };
        [[JCLSocketObj share] JCLSocketRequst:dic idx:JCL_PROTOCOL_ZJCX];
        
    });
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self getToken];
    [[Harpy sharedInstance] checkVersionDaily];
}

- (void)configureBugtags {
    [Bugly startWithAppId:TSJR_BUGTAGS_APP_ID];
}
-(void)getToken{
    [JCLHttps tokenSuccess:^(id obj) {
        NSLog(@"sssssssss  %@",obj);
    
    } failure:^(NSError *error) {
        
    }];
}

-(void)initCode{
    NSData *data = [NSData dataNamed:@"中概股.json"];
    NSDictionary *dict  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *arrayData = dict[@"data"];
    for (NSDictionary *dd in arrayData) {
        JCLCodeNameModel *m = [JCLCodeNameModel modelWithDictionary:dd];
        [self.messageNoticeStore addMessageNotice:m];
    }
    
}

-(void)initDBCode{
    //    if ([JCLUserSession getDB].length==0) {
    //        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    if(userId().length==0){
        return ;
    }
    
    NSString *postUrlAAA = [NSString stringWithFormat:@"%@/%@",baseApiURlE,@"chinaSymbolNames"];
    [JCLHttps httpPOSTRequest:postUrlAAA params:@{@"userId":userId()} success:^(id obj) {
        NSLog(@"objobjAAAAAAAAA %@",obj);
        MMResultModel *model =(MMResultModel *)obj;
        NSLog(@"countcountcount %@",model.data);
        if (model.code.intValue == 200&&model.data.count>0) {
            [[AppDelegate shareAppDelegate].messageNoticeStore  deleteTable];
            for ( id object in model.data) {
                JCLCodeNameModel *codeModel = [JCLCodeNameModel modelWithDictionary:object];
                NSLog(@"--name-==== %@",codeModel.name);
                 NSLog(@"--symbol-==== %@",codeModel.symbol);
                
                [[AppDelegate shareAppDelegate].messageNoticeStore addMessageNotice:codeModel];
            }
        }
    } failure:^(NSError *error) {
//        [JCLFramework showErrorHud:@"服务器异常"];
    }];
    //        });
    //    }
}

///accountapi/userLoginRequest
//获取老虎ACCESS TOKEN
-(void)getAccessToken{
    if(userId().length==0){
        return ;
    }
    NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlB,@"userLoginRequest"];
    [JCLHttps httpPOSTRequest:postUrl params:@{@"userId":userId(),@"password":[JCLUserSession getPassWord],@"phone":user().phone} success:^(id obj) {
        NSLog(@"objobj %@",obj);
        MMResultModel *model =(MMResultModel *)obj;
        NSLog(@"countcountcount %@",model.data);
        if (model.code.intValue == 200) {
            
        }
    } failure:^(NSError *error) {
        
    }];
//    /accountapi/userTradeTokenRequest
//    获取老虎Trade TOKEN
//    NSString *postUrlB = [NSString stringWithFormat:@"%@/%@",baseApiURlB,@"userTradeTokenRequest"];
//    [JCLHttps httpPOSTRequest:postUrlB params:@{@"userId":userId()} success:^(id obj) {
//
//        MMResultModel *model =(MMResultModel *)obj;
//
//        if (model.code.intValue == 200) {
//
//        }
//    } failure:^(NSError *error) {
//
//    }];
    
}




- (TSJRDBCodeStore *)messageNoticeStore
{
    if (_messageNoticeStore == nil) {
        _messageNoticeStore = [[TSJRDBCodeStore alloc] init];
    }
    return _messageNoticeStore;
}
@end
