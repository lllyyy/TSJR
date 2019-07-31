//
//  JCLChartManage.m
//  Jincelue_Sdk
//
//  Created by 邢昭俊 on 2017/3/14.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLChartManage.h"

#define JCLAngle(radian) ((radian) * (180.0 / M_PI)) // 弧度转角度
#define JCLRadian(angle) ((angle) / 180.0 * M_PI) // 角度转弧度

@implementation JCLChartManage
#pragma mark 根据角度获取坐标值
+(CGPoint)JCLInitAngle:(CGPoint)point angle:(CGFloat)angle radius:(CGFloat)radius{
    CGFloat x = radius*cosf(angle*M_PI/180), y = radius*sinf(angle*M_PI/180);
    return CGPointMake(point.x+x, point.y+y);
}

#pragma mark 根据角度获取坐标值的中心点
+(NSArray *)JCLAnglePoint:(NSArray *)arr point:(CGPoint)point radius:(CGFloat)radius{
    __block CGFloat angle = 0.00;
    CGFloat sumVal = [[arr valueForKeyPath:@"@sum.floatValue"] floatValue];
    NSMutableArray *arrM = [[NSMutableArray alloc]init];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat angles = 360/(sumVal/[obj floatValue]);
        angle += angles;
        [arrM addObject:NSStringFromCGPoint([JCLChartManage JCLInitAngle:point angle:angle - 0.5*angles radius:radius])];
    }];
    return arrM;
}

#pragma mark 根据规则角度获取坐标值
+(NSArray *)JCLAnglePoint:(NSArray *)arr point:(CGPoint)point radius:(CGFloat)radius style:(NSInteger)style{
    CGFloat angle = 360/arr.count;
    NSMutableArray *arrM = [[NSMutableArray alloc]init];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat r = style != 4 ? radius : radius*[obj floatValue]/100;
        [arrM addObject:NSStringFromCGPoint([JCLChartManage JCLInitAngle:point angle:angle*idx radius:r])];
    }];
    return arrM;
}

#pragma mark 根据坐标初始化路径
+(UIBezierPath *)JCLInitLine:(NSArray *)arr isClose:(BOOL)isClose{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint point = CGPointFromString(obj);
        if (idx == 0) { [path moveToPoint:point]; } else { [path addLineToPoint:point]; }
    }];
    if (isClose){ [path closePath];} [path stroke];
    return path;
}

+(UIBezierPath *)JCLInitRadian:(CGPoint)point radius:(CGFloat)radius start:(CGFloat)start end:(CGFloat)end{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point];
    [path addArcWithCenter:point radius:radius startAngle:JCLRadian(start) endAngle:JCLRadian(end) clockwise:YES]; 
    [path closePath]; [path stroke];
    return path;
}

#pragma mark 根据路径初始化图层
+(CAShapeLayer *)JCLInitLayer:(UIView *)parent path:(UIBezierPath *)path width:(CGFloat)width strokeCol:(UIColor *)strokeCol fillCol:(UIColor *)fillCol{
    CAShapeLayer *layer = [CAShapeLayer layer];
    [parent.layer addSublayer:layer];
    layer.strokeColor = strokeCol.CGColor;
    layer.fillColor = fillCol.CGColor;
    layer.lineWidth = width;
    layer.path = path.CGPath;
    return layer;
}

+(CAGradientLayer *)JCLGradient:(UIView *)parent colors:(NSMutableArray *)colors{
    CAGradientLayer *layer = [CAGradientLayer layer];
    [parent.layer addSublayer:layer];
    layer.frame = parent.bounds;
    layer.colors = colors;
    layer.startPoint = CGPointMake(0.5,0.5);
    layer.endPoint = CGPointMake(0.5,1);
    return layer;
}

#pragma mark 根据图层初始化动画
+(CABasicAnimation *)JCLInitAnima:(CAShapeLayer *)layer style:(NSString *)style from:(id)from to:(id)to time:(NSInteger)time delegate:(id)delegate{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:style];
    animation.duration = time;
    animation.fromValue = from;
    animation.toValue = to;
    animation.autoreverses = NO;
    animation.delegate = delegate;
    animation.removedOnCompletion = NO; // 取消反弹
    animation.fillMode = kCAFillModeForwards; // 始终保持最新的效果
    [layer addAnimation:animation forKey:style];
    return animation;
}
@end
