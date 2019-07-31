//
//  JCLBarList.h
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/7.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLBarList : UIView
@property (nonatomic, strong) NSArray *icons;
@property (nonatomic, strong) NSArray *hisIcons;
@property (nonatomic, strong) NSArray *vals;
@property (nonatomic, copy) void (^actionBlock)(NSInteger idx);
@property (nonatomic, assign) BOOL isBar;
@property (nonatomic, assign) BOOL isAction;
@property (nonatomic, assign) NSInteger idx;
@end
