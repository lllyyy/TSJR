//
//  JCLMainList.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/14.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLMainList.h"
#import "JCLMarketObj.h"
#import "JCLTabBarList.h"
#import "AppDelegate.h"

#define BundleNumber @"BundleNumber"

@interface JCLMainList ()
@property (nonatomic, assign) NSInteger downCount;

@property (nonatomic, weak) UIButton *text;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) BOOL isInitCode;
@end

@implementation JCLMainList
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navi.hidden = YES;
//    UIImageView *icon = [JCLKitObj JCLImage:self.view];
//    icon.image = [UIImage imageNamed:@"Launch"];
//    icon.frame = CGRectMake(0, 0, JCLWIDTH, JCLHEIGHT);
    
    if ([JCLUserData getUserInfo].username.length) {
        NSString *username = [JCLUserData getUserInfo].username;
        NSString *password = [JCLUserData getUserInfo].password;
        NSDictionary *dic = @{ @"password": password };
        NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:NULL];
        NSString *url = [NSString stringWithFormat:@"%@userLogin?phone=%@&password=%@&location=ios",
                         JCLWebURL,
                         [username stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                         [data base64EncodedStringWithOptions:0]];
        [JCLHttpsObj JCLGetJson:url success:^(id obj) {
            if([obj[@"code"] isEqualToString:@"0"]){
                NSString *online = [JCLUserData getUserInfo].online;
                JCLUserData *data = [JCLUserData mj_objectWithKeyValues:obj[@"content"]];
                data.username = username; data.password = password; data.online = online;
                [JCLUserData saveUserInfo:data];
            }
        } failure:^(NSError *error) { [JCLFramework JCLProgressHUD:@"网络超时，请您检查网络"]; }];
        
        [self InitBar];
        
    } else {
        //        JCLUserLoginList *list = [[JCLUserLoginList alloc] init];
        //        list.isMain = YES;
        //        list.popActionBlock = ^(){
        [self InitBar];
        //        };
//        [UIApplication sharedApplication].keyWindow.rootViewController = list;
    }
//
//    [self drawAdvert];
}
-(void)InitBar{
    
    PreWrite(@"44", isTrade);
    self.tabbar = [[JCLTabBarList alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = self.tabbar;
     
//    NSString *url = [NSString stringWithFormat:@"%@getStatus?messagecode=%@", JCLWebURL, @"1.4.6"];
//    [JCLHttpsObj JCLGetJson:url success:^(id obj) {
//
//        NSLog(@"--%@",obj);
//
//        if ([obj[@"status"] isEqualToString:@"2"]) {
//             PreWrite(@"", isTrade);
//            
//        } else {
//            PreWrite(@"44", isTrade);
//        }
//        NSLog(@"---%@",obj);
//
//    } failure:^(NSError *error) { }];
//    PreWrite(@"44", isTrade);
//    self.tabbar = [[JCLTabBarList alloc] init];
//    [UIApplication sharedApplication].keyWindow.rootViewController = self.tabbar;
}
-(void)drawAdvert{
    self.downCount = 3;
    UIImageView *img = [JCLKitObj JCLImage:self.view]; img.frame = self.view.bounds;
    
    self.text = [JCLKitObj JCLButton:img img:@"" size:13 target:self action:@selector(pushAction)];
    self.text.frame = CGRectMake(JCLWIDTH - 14 - 0.1*JCLWIDTH, 34, 0.1*JCLWIDTH, 30);
    
    NSString *url = [NSString stringWithFormat:@"%@/yssys/servlet/StartPageServlet", zbUrl];
    [JCLHttpsObj JCLGetJson:url success:^(id obj) {
    } failure:^(NSError *error) { [JCLFramework JCLProgressHUD:@"请求超时!"]; }];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

-(void)pushAction{
    [self.timer invalidate];
    NSString *version = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    if([version compare:PreRead(BundleNumber)] == NSOrderedDescending){
        PreWrite(version, BundleNumber);
        [UIApplication sharedApplication].keyWindow.rootViewController = [[JCLTabBarList alloc] init];
    } else {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[JCLTabBarList alloc] init];
    }
}

-(void)timerAction{
    if (self.downCount == 0) { self.text.title = @""; [self pushAction]; }
    else { self.text.title = [NSString stringWithFormat:@"( %zd )", --self.downCount]; }
}
@end
