//
//  LHCMenuView.h
//  封装MenuView
//
//  Created by  on 2017/2/20.
//  Copyright © 2017年 . All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^MenuChangeBlock) (UIButton *btn);
@interface LHCMenuView : UIView
@property(nonatomic,assign)CGFloat lineWidth;
@property (nonatomic,strong) UIView *lineView;
@property(nonatomic,copy)MenuChangeBlock block;
//选中按钮
@property (nonatomic, strong) UIButton *selectedBtn;
+ (LHCMenuView *)MenuViewTitleArray:(NSArray *)array SelectLineHeight:(CGFloat)height SelectLineColor:(UIColor *)color Selectidx:(NSUInteger)idx Blcok:(MenuChangeBlock)block;
@property (nonatomic,assign) BOOL isBgImg;
@end
