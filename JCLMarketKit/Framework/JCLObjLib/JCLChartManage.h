//
//  JCLChartManage.h
//  Jincelue_Sdk
//
//  Created by 邢昭俊 on 2017/3/14.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface JCLChartManage : NSObject
#pragma mark 根据角度获取坐标值
+(CGPoint)JCLInitAngle:(CGPoint)point angle:(CGFloat)angle radius:(CGFloat)radius;
#pragma mark 根据角度获取坐标值的中心点
+(NSArray *)JCLAnglePoint:(NSArray *)arr point:(CGPoint)point radius:(CGFloat)radius;
#pragma mark 根据规则角度获取坐标值
+(NSArray *)JCLAnglePoint:(NSArray *)arr point:(CGPoint)point radius:(CGFloat)radius style:(NSInteger)style;

#pragma mark 根据坐标初始化路径
+(UIBezierPath *)JCLInitLine:(NSArray *)arr isClose:(BOOL)isClose;
+(UIBezierPath *)JCLInitRadian:(CGPoint)point radius:(CGFloat)radius start:(CGFloat)start end:(CGFloat)end;

#pragma mark 根据路径初始化图层
+(CAShapeLayer *)JCLInitLayer:(UIView *)parent path:(UIBezierPath *)path width:(CGFloat)width strokeCol:(UIColor *)strokeCol fillCol:(UIColor *)fillCol;
+(CAGradientLayer *)JCLGradient:(UIView *)parent colors:(NSMutableArray *)colors;
#pragma mark 根据图层初始化动画
+(CABasicAnimation *)JCLInitAnima:(CAShapeLayer *)layer style:(NSString *)style from:(id)from to:(id)to time:(NSInteger)time delegate:(id)delegate;
@end
