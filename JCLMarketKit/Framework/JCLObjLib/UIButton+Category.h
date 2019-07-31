//
//  UIButton+RuiXue.h
//  RuiXueTuan
//
//  Created by 邢昭俊 on 14-6-14.
//  Copyright (c) 2014年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Category)
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *selectedTitle;

@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) UIColor *selectedColor;

@property(nonatomic, copy) NSString *img;
@property(nonatomic, copy) NSString *selectedImg;
@property(nonatomic, copy) NSString *highlightedImg;
@property(nonatomic, copy) NSString *disabledImg;

-(void)addTarget:(id)target action:(SEL)action;
@end
