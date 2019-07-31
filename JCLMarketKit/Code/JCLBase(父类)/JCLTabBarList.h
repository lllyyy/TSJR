//
//  TabBarController.h
//  RuiXueTuan
//
//  Created by 邢昭俊 on 14-6-14.
//  Copyright (c) 2014年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLNaviBarList : UINavigationController
@end

@interface JCLTabBar : UITabBar
@end

@interface JCLTabBarList : UITabBarController
@property (nonatomic, assign) BOOL isShow;
@end
