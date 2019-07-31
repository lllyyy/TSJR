//
//  JCLSVProgressHUD.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/17.
//  Copyright © 2017年 刘虎超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCLSVProgressHUD : UIView
/**
 弹出正常转圈的HUD
 */
+ (void)showHUD;
/**
 弹出带文本提示转圈的HUD
 */
+ (void)showHUD:(NSString *)str;

/**
 弹出成功提示的HUD
*/
+ (void)showSuccessHUD:(NSString *)str;

/**
 弹出错误提示的HUD
 */
+ (void)showErrorHud:(NSString *)str;

/**
 正常情况的dismiss
 */
+ (void)dimissHUD;

/**
 延迟几秒dimiss
 */
+ (void)dimissHUDTime:(NSTimeInterval)time;
//弹出带阴影关闭用户交互的hud
+ (void)showshadowHUD;
//弹出带阴影关闭用户交互的和字符串的HUD
+ (void)showshadowHUDString:(NSString *)str;
@property (nonatomic, strong) UIView *backgroundView;

- (void)remove;
@end
