//
//  UIButton+RuiXue.h
//  RuiXueTuan
//
//  Created by 邢昭俊 on 14-6-14.
//  Copyright (c) 2014年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Base)
@property (copy, nonatomic) NSString *disabledImage;

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *highlightedTitle;
@property (copy, nonatomic) NSString *selectedTitle;

@property (strong, nonatomic) UIColor *titleColor;
@property (strong, nonatomic) UIColor *highlightedTitleColor;
@property (strong, nonatomic) UIColor *selectedTitleColor;

@property (copy, nonatomic) NSString *image;
@property (copy, nonatomic) NSString *highlightedImage;
@property (copy, nonatomic) NSString *selectedImage;

@property (copy, nonatomic) NSString *bgImage;
@property (copy, nonatomic) NSString *highlightedBgImage;
@property (copy, nonatomic) NSString *selectedBgString;

@property (copy, nonatomic) UIImage  *selectedBgImage;

// 设置未拉伸的正常状态背影图片
-(void)setNormal:(NSString *)normal;

// 设置未拉伸的高亮状态背影图片
-(void)setHighlighteds:(NSString *)highlighted;

// 设置未拉伸后的正常和高亮状态按钮背影图片
-(void)setNormal:(NSString *)normal highlighted:(NSString *)highlighted;

- (void)addTarget:(id)target action:(SEL)action;
@end
