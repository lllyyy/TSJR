//
//  JCLMenuView.h
//  Jincelue_Sdk
//
//  Created by 邢昭俊 on 2017/3/7.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    ScreenTypeOfVertical = 0,
    ScreenTypeOfCross,
}KLineScreenType;
//
@interface JCLMenuUI : UIView
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, copy) void (^actionBlock)(NSInteger idx);
@property (nonatomic, weak) UILabel *selectModel;
@property (nonatomic, assign) KLineScreenType type;
@property (nonatomic, assign) CGFloat size; // 字体大小;
@end
