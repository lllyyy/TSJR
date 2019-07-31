//
//  XLDMenu.h
//  Jincelue
//
//  Created by 邢昭俊 on 2017/1/20.
//  Copyright © 2017年 ruixue. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    MenuTypeOfText = 0,
    MenuTypeOfIcon,
    MenuTypeOfsubText,
} MenuModelType;

/** 点击按钮的回调函数 */
typedef void (^ButtonPressed)() ;
@interface JCLKitModel : UIView
@property(nonatomic, assign) MenuModelType type;
@property(nonatomic, weak) UIImageView *icon;
@property(nonatomic, weak) UILabel *text;
@property(nonatomic, weak) UILabel *subText;
@property (nonatomic, copy) ButtonPressed tapActionBlock;

@end
