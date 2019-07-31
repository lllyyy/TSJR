//
//  JCLBar.h
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/7.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLBarModel : UIView
@property(nonatomic, assign) BOOL isIcon;
@property(nonatomic, weak) UIImageView *icon;
@property(nonatomic, weak) UILabel *val;
@end
