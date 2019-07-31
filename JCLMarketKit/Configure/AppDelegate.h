//
//  AppDelegate.h
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/6/20.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCLMainList.h"
#import "MRCNavigationControllerStack.h"
#import "TSJRDBCodeStore.h"
#import "JCLCodeNameModel.h"
@class JCLUserModel;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
+(AppDelegate *)shareAppDelegate;
@property (nonatomic, strong, readonly) MRCNavigationControllerStack *navigationControllerStack;
@property (nonatomic, weak) NSTimer *polling;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) JCLMainList *main;
@property (nonatomic, strong) JCLUserModel *userModel;
@property (nonatomic, copy) void (^timerAtionBlock)();

@property (nonatomic, strong) TSJRDBCodeStore *messageNoticeStore;
 
@end

