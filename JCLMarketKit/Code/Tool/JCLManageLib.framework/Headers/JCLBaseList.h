//
//  BaseController.h
//  BaoGang_iOS
//
//  Created by 邢昭俊 on 8/29/16.
//  Copyright © 2016 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>
//12345
@interface JCLBaseNavi : UIView
// 导航左侧的控件
@property (nonatomic, weak) UIButton *left;

// 导航右侧的控件
@property (nonatomic, weak) UIButton *right;

// 导航中间的控件
@property (nonatomic, weak) UIButton *middle;
@property (nonatomic, weak) UIButton *subMiddle;
@end

@interface JCLBaseList : UIViewController
// 对导航中的控件属性进行灵活修改（PS:可重写）
@property(nonatomic , weak) JCLBaseNavi *navi;

// 导航左侧的Block回调方法
@property (nonatomic, copy) void (^leftActionBlock)();

// 导航右侧的Block回调方法
@property (nonatomic, copy) void (^rightActionBlock)();

// 导航中间的Block回调方法 (PS：默认不执行)
@property (nonatomic, copy) void (^middleActionBlock)();
@end
