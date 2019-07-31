//
//  JCLUserUpdateFooter.h
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/15.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLUserSubmit : UIView
@property (nonatomic, weak) UIButton *submit;
@property (nonatomic, weak) UIButton *regist;
@property (nonatomic, weak) UIButton *forget;
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, assign) BOOL isMore;
@property (nonatomic, weak) UIButton *more;

@end
