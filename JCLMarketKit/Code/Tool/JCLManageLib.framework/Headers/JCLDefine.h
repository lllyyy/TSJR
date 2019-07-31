//
//  JCLDefine.h
//  Jincelue
//
//  Created by 邢昭俊 on 2017/2/10.
//  Copyright © 2017年 ruixue. All rights reserved.
//

#ifndef JCLDefine_h
#define JCLDefine_h

#import "JCLBaseManage.h"
#import "UIView+Manage.h"
#import "UIButton+Base.h"

#define JCLKLineC @"Code"
#define JCLKLineV @"Vertical"
#define JCLKLineH @"Cross"

#define JCLColorRGB(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a] // 获取RGB颜色值
#define JCLMAINRGB JCLColorRGB(252, 81, 79, 1)


#pragma mark ---- NSUserDefaults
#define CachesFile(value) [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:value]
#define TmpFile(value) [NSTemporaryDirectory() stringByAppendingPathComponent:value]

#define FileRead(key) [NSMutableArray arrayWithContentsOfFile:key];
#define FileWrite(value, key) [key writeToFile:value atomically:YES];

#define PreRead(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define PreWrite(value, key) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]


#pragma mark ---- UIScreen
#define JCLBOUNDS [UIScreen mainScreen].bounds
#define JCLSIZE [UIScreen mainScreen].bounds.size
#define JCLWIDTH [UIScreen mainScreen].bounds.size.width
#define JCLHEIGHT [UIScreen mainScreen].bounds.size.height

#pragma mark ---- UIDevice
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define iOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#endif /* JCLDefine_h */
