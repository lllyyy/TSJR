//
//  JCLChartPath.m
//  Jincelue_Sdk
//
//  Created by 邢昭俊 on 2017/3/9.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLChartPath.h"
#import "JCLChartManage.h"

#define JCLPoint CGPointMake(0.5*self.width, 0.5*self.height) // 中心点

@interface JCLChartPath()<CAAnimationDelegate>
@property(nonatomic, strong) NSMutableArray *pathArrM; // 记录图表数据

@property(nonatomic, assign) CGFloat barWidth; // 柱状图宽度
@property(nonatomic, assign) BOOL isRun;

@property(nonatomic, weak) CAShapeLayer *selectLayer;
@end

@implementation JCLChartPath
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) { self.backgroundColor = [UIColor clearColor];
        [self drawBorder:CGRectMake(self.width - 2, 0, 2, self.height)];
    } return self;
}
#pragma mark 1.设置图标边框
-(void)setBorderState:(JCLChartPathBorderState)borderState{
    _borderState = borderState;
    CGFloat w = self.boxW;
    switch (borderState) {
        case JCLChartPathBorderTop: [self drawBorder:CGRectMake(0, 0, self.width, w)]; break;
        case JCLChartPathBorderLeft: [self drawBorder:CGRectMake(0, 0, w, self.height)]; break;
        case JCLChartPathBorderRight: [self drawBorder:CGRectMake(self.width - w, 0, w, self.height)]; break;
        case JCLChartPathBorderBottom: [self drawBorder:CGRectMake(0, self.height - w, self.width, w)]; break;
        default: break;
    }
}

-(void)drawBorder:(CGRect)frame{
    CALayer *layer = [CALayer layer]; layer.frame = frame; layer.backgroundColor = self.boxCol.CGColor; [self.layer addSublayer:layer];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.isRun == NO) {
        switch (self.style) {
            case JCLChartPathBox: [self layoutChartBox]; break;
            case JCLChartPathBar: [self InitPathPoint]; break;
            case JCLChartPathMacd: [self InitMacd]; break;
            case JCLChartPathBroken: [self InitPathPoint]; break;
            case JCLChartPathPie: [self drawChartPie]; break;
            case JCLChartPathRadar: [self drawChartRadar]; break;
            case JCLChartPathPoint: [self setupPathArr]; break;
            case JCLChartPathRing: self.isRings ? [self drawChartRings] : [self drawChartRing]; break;
            default: break;
        }
        self.isRun = YES;
    }
}

-(void)drawRect:(CGRect)rect{
    switch (self.style) {
        case JCLChartPathKline: [self InitKLine]; break;
        case JCLChartPathVol: [self InitVol]; break;
        case JCLChartPathTimeVol: [self InitTimeVol]; break;
        default: break;
    }
}

-(NSArray *)InitKLinePoint{
    CGFloat maxVal = self.maxVal.floatValue, minVal = self.minVal.floatValue;
    if (maxVal == 0 && minVal == 0) { maxVal = maxVal + 1; }
    NSMutableArray *arrM = [[NSMutableArray alloc]init];
    __block CGFloat pointX = 0.5*(self.pathW);
    [self.pointArr enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL *stop) {
        CGFloat heightY = self.height * (1 - ([obj[3] floatValue] - minVal) / (maxVal - minVal));
        CGFloat lowY = self.height * (1 - ([obj[4] floatValue] - minVal) / (maxVal - minVal));
        CGFloat openY = self.height * (1 - ([obj[2] floatValue] - minVal) / (maxVal - minVal));
        CGFloat closeY = self.height * (1 - ([obj[5] floatValue] - minVal) / (maxVal - minVal));
        CGFloat volY = self.height * (1 - ([obj[6] floatValue] - minVal) / (maxVal - minVal));
        [arrM addObject:@[NSStringFromCGPoint(CGPointMake(pointX, heightY)), NSStringFromCGPoint(CGPointMake(pointX, lowY)),
                          NSStringFromCGPoint(CGPointMake(pointX, openY)), NSStringFromCGPoint(CGPointMake(pointX, closeY)),
                          NSStringFromCGPoint(CGPointMake(pointX, volY)), obj[0], obj[1], obj[2], obj[3], obj[4], obj[5], obj[6], obj[7], obj[8]]];
        pointX += (self.pathW + 1);
    }]; self.XYArr = arrM;
    return arrM;
}



// 初始化klile
-(void)InitKLine{
    [[self InitKLinePoint] enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL *stop) {
        CGPoint heightPoint, lowPoint, openPoint, closePoint;
        heightPoint = CGPointFromString([obj objectAtIndex:0]);
        lowPoint = CGPointFromString([obj objectAtIndex:1]);
        openPoint = CGPointFromString([obj objectAtIndex:2]);
        closePoint = CGPointFromString([obj objectAtIndex:3]);
        CGPoint maxPoint, minPoint; UIColor *strokeCol, *fillCol;
        
        CGFloat maxW = self.pathW, minW = 1;
        if ([obj[10] floatValue] > [obj[7] floatValue]) {
            maxPoint = closePoint; minPoint = openPoint;
            strokeCol = JCLChartRise; fillCol = self.isFillK ? JCLChartRise : JCLChartRise;
        } else if ([obj[10] floatValue] < [obj[7] floatValue]) {
            maxPoint = openPoint; minPoint = closePoint; strokeCol = JCLChartFall; fillCol = JCLChartFall;
        } else {
            maxPoint = openPoint; minPoint = closePoint; strokeCol = JCLChartStop; fillCol = nil;
        }
        
        [self InitPath:CGPointMake(heightPoint.x, heightPoint.y) add:CGPointMake(heightPoint.x, maxPoint.y) width:minW color:strokeCol];
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(maxPoint.x - 0.5*(maxW - minW), maxPoint.y, maxW - minW, minPoint.y - maxPoint.y)];
        [JCLChartManage JCLInitLayer:self path:path width:minW strokeCol:strokeCol fillCol:fillCol];
        [self InitPath:CGPointMake(minPoint.x, minPoint.y) add:CGPointMake(lowPoint.x, lowPoint.y) width:minW color:strokeCol];
    }];
    self.isSimiK ? : [self InitMAVal];
}

-(void)InitMAVal{
    __block BOOL isMax = NO, isMin = NO;
    [[self InitKLinePoint] enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL *stop) {
        CGPoint heightPoint, lowPoint;
        heightPoint = CGPointFromString([obj objectAtIndex:0]);
        lowPoint = CGPointFromString([obj objectAtIndex:1]);
        if (!isMax) { if ([obj[8] floatValue] >= self.max){ [self InitValText:heightPoint val:[obj[8] floatValue] isMax:YES]; isMax = YES; } }
        if (!isMin) { if ([obj[9] floatValue] <= self.min){ [self InitValText:lowPoint val:[obj[9] floatValue] isMax:NO]; isMin = YES; } }
    }];
}

-(void)InitValText:(CGPoint)point val:(CGFloat)val isMax:(BOOL)isMax{
    UILabel *info = [JCLKitObj JCLLable:self font:9 color:JCLChartStop alignment:0];
    info.text = [NSString stringWithFormat:@"%.2lf", val];
    CGSize size = [JCLKitObj JCLTextSize:info.text font:info.font];
    CGFloat min = 2*(size.width + 10), max = self.width - self.pathW - size.width - 10;
    CGFloat h = isMax ? 0.00 : size.height;
    CGFloat x = point.x < max && point.x < min ? point.x + 4 : point.x - 4;
    [self InitPath:CGPointMake(point.x, point.y) add:CGPointMake(x, point.y-h + 0.5*(size.height-1)) width:1 color:JCL_Text_COL];
    
    CGFloat infoX = point.x < max && point.x < min ? point.x + 6 : point.x - size.width + 2;
    info.frame = CGRectMake(infoX, point.y-h, size.width, size.height);
}

// 初始化VAL
-(void)InitVol{
    CGFloat maxW = self.pathW, minW = 1;
    [[self InitKLinePoint] enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL *stop) {
        CGPoint point = CGPointFromString([obj objectAtIndex:4]);
        UIColor *strokeCol; UIColor *fillCol;
        if ([obj[10] floatValue] > [obj[7] floatValue]) {
            //            strokeCol = JCLChartRise; fillCol = self.isFillK ? JCLChartRise : [UIColor clearColor];
            strokeCol = JCLChartRise; fillCol = JCLChartRise;
            
        } else if ([obj[10] floatValue] < [obj[7] floatValue]) {
            strokeCol = JCLChartFall; fillCol = JCLChartFall;
        } else {
            if (([obj[10] floatValue] - [obj[13] floatValue])/[obj[13] floatValue] > 0) {
                //                strokeCol = JCLChartRise; fillCol = self.isFillK ? JCLChartRise : [UIColor clearColor];
                strokeCol = JCLChartRise; fillCol = JCLChartRise;
            } else {
                strokeCol = JCLChartFall; fillCol = JCLChartFall;
            }
        }
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(point.x - 0.5*(maxW - minW), point.y, maxW - minW, self.height - point.y)];
        CGFloat w = self.height - point.y <= 0 ? 0 : minW;
        [JCLChartManage JCLInitLayer:self path:path width:w strokeCol:strokeCol fillCol:fillCol];
    }];
}

// 初始化MACD
-(void)InitMacd{
    [self InitRangeVal];
    CGFloat maxVal = self.maxVal.floatValue, minVal = self.minVal.floatValue;
    NSMutableArray *arrM = [[NSMutableArray alloc]init];
    __block CGFloat pointX = 0.5*self.pathW;
    [self.pointArr enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL *stop) {
        CGFloat y = self.height * (1 - ([obj[2] floatValue] - minVal) / (maxVal - minVal));
        [arrM addObject:@[NSStringFromCGPoint(CGPointMake(pointX, y)), obj[2]]];
        pointX += (self.pathW + 1);
    }];
    
    CGFloat y = self.height * (1 - (0 - minVal) / (maxVal - minVal));
    [arrM enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL *stop) {
        CGPoint point = CGPointFromString([obj objectAtIndex:0]);
        UIColor *strokeCol = [obj[1] floatValue] > 0 ? JCLChartRise : JCLChartFall;
        [self InitPath:CGPointMake(point.x, y) add:CGPointMake(point.x, point.y) width:3 color:strokeCol];
    }];
}

// 初始化VOL
-(void)InitTimeVol{
    NSMutableArray *volArrM = [[NSMutableArray alloc]init];
    [self.pointArr enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL *stop) { [volArrM addObject:obj[3]]; }];
    self.maxVal = [volArrM valueForKeyPath:@"@max.floatValue"], self.minVal = self.minVal; //[volArrM valueForKeyPath:@"@min.floatValue"];
    CGFloat maxVal = self.maxVal.floatValue, minVal = self.minVal.floatValue;
    NSMutableArray *arrM = [[NSMutableArray alloc]init];
    __block CGFloat pointX = 0.5*self.pathW;
    [self.pointArr enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL *stop) {
        CGFloat volV = self.height * (1 - ([obj[3] floatValue] - minVal) / (maxVal - minVal));
        if (maxVal - minVal == 0) {
            volV = self.height;
        }
        [arrM addObject:@[NSStringFromCGPoint(CGPointMake(pointX, volV)),
                          obj[0], obj[1], obj[2], obj[3], obj[4]]];
        pointX += (self.pathW + self.pathS);
    }];
    self.XYArr = arrM;
    
    __block UIColor *strokeCol; __block CGFloat vol;
    [arrM enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL *stop) {
        CGPoint point = CGPointFromString([obj objectAtIndex:0]);
        if (idx == 0) {
            strokeCol = [obj[2] floatValue] > self.close ? JCLChartRise : JCLChartFall;
        } else {
            if ([obj[2] floatValue] > vol) {
                strokeCol = JCLChartRise;
            } else if ([obj[2] floatValue] < vol) {
                strokeCol = JCLChartFall;
            } else {
                strokeCol = JCLChartStop;
            }
        }
        vol = [obj[2] floatValue];
        [self InitPath:CGPointMake(point.x, self.height) add:CGPointMake(point.x, point.y) width:self.pathW color:strokeCol];
        if (idx == arrM.count - 1) { !self.animaActionBlock ? : self.animaActionBlock(); }
    }];
}

-(CAShapeLayer *)InitPath:(CGPoint)move add:(CGPoint)add width:(CGFloat)width color:(UIColor *)color{
    UIBezierPath *path = [UIBezierPath bezierPath]; [path moveToPoint:move]; [path addLineToPoint:add];
    return [JCLChartManage JCLInitLayer:self path:path width:width strokeCol:color fillCol:color];
}

-(void)InitRangeVal{
    NSArray *arr = self.pointArr;
    if (arr) {
        NSArray *subArr = arr[0];
        NSMutableArray *minArrM = [[NSMutableArray alloc]init]; NSMutableArray *maxArrM = [[NSMutableArray alloc]init];
        [subArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableArray *arrM = [[NSMutableArray alloc]init];
            [arr enumerateObjectsUsingBlock:^(NSArray *subObj, NSUInteger index, BOOL *stop) {
                NSString *val = self.style == JCLChartPathBar ? [NSString stringWithFormat:@"%lf", fabs([subObj[idx] floatValue])] : subObj[idx];
                if (self.pathW > 0) {
                    if (![subObj[idx] isEqualToString:@""]) { [arrM addObject:val]; }
                }
                else { [arrM addObject:val]; }
            }];
            if (!arrM.count) { [arrM addObject:@""]; }
            NSString *min = [arrM valueForKeyPath:@"@min.floatValue"], *max = [arrM valueForKeyPath:@"@max.floatValue"];
            if (min.floatValue != 0 || min.floatValue != max.floatValue) { [minArrM addObject:min]; [maxArrM addObject:max]; }
        }];
        self.min = [[minArrM valueForKeyPath:@"@min.floatValue"] floatValue];
        self.max = [[maxArrM valueForKeyPath:@"@max.floatValue"] floatValue];
        
        // 分时特殊处理
        if (self.isTime) {
            CGFloat close = self.close;
            if (self.max - close > close - self.min) { self.min = close - (self.max - close); }
            else if(close - self.min > self.max - close){ self.max = close + close - self.min; }
            if (self.max == self.min) { self.max = self.max+0.01; self.min = self.min - 0.01; }
        }
        if (!self.minVal.length) { self.minVal = [NSString stringWithFormat:@"%f", self.min]; }
        if (!self.maxVal.length) { self.maxVal = [NSString stringWithFormat:@"%f", self.max]; }
    }
}

#pragma mark 1.绘制图表框
-(void)layoutChartBox{
    CGFloat w = self.boxW;
    CGFloat boxVS = ((self.width - 2*w) - w*(self.boxNumV))/(self.boxNumV + 1);
    for (int idx = 0; idx < self.boxNumV + 1; idx++) {
        if (idx != 0) { CGFloat x = idx*boxVS+idx*w;
            [self InitDashLine:@[NSStringFromCGPoint(CGPointMake(x, w)), NSStringFromCGPoint(CGPointMake(x, self.height - 2*w))]];
        }
    }
    
    CGFloat boxHS = ((self.height - 2*w) - (w*self.boxNumH))/(self.boxNumH + 1);
    for (int idx = 0; idx < self.boxNumH + 1; idx++) {
        if (idx != 0) { CGFloat y = boxHS*idx+idx*w;
            [self InitDashLine:@[NSStringFromCGPoint(CGPointMake(w, y)), NSStringFromCGPoint(CGPointMake(self.width - 2*w, y))]];
        }
    }
}

-(void)InitDashLine:(NSArray *)arr{
    CGFloat w = self.boxW;
    CAShapeLayer *layer = [self InitLinePath:arr width:w strokeCol:self.boxCol fillCol:self.boxCol];
    layer.lineWidth = w; if (self.isDash) { layer.lineDashPattern = @[@(w*2), @(w*2)]; }
}

// 处理图表数据
-(NSMutableArray *)pathArrM{ if (_pathArrM) return _pathArrM; return _pathArrM = [[NSMutableArray alloc]init]; }
-(void)setupPathArr{
    [self.pathArrM removeAllObjects];
    [self InitRangeVal];
    NSArray *arr = self.pointArr;
    CGFloat minIdx = self.minVal.floatValue, maxIdx = self.maxVal.floatValue;
    CGFloat groupWidth = self.width/arr.count; // 每组柱子的宽度
    NSArray *subArr = arr[0];
    if (self.style == JCLChartPathBroken) {
        __block CGFloat pointX = 0.00;
        if (self.pathW > 0) {
            pointX = 0.5*self.pathW;
        }
        [arr enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableArray *arrM = [[NSMutableArray alloc]init];
            [obj enumerateObjectsUsingBlock:^(id  _Nonnull subObj, NSUInteger idx, BOOL * _Nonnull stop) {
                CGFloat y = [subObj isEqualToString:@""] ? -4444 : self.height * (1 - ([subObj floatValue] - minIdx) / (maxIdx - minIdx));
                [arrM addObject:NSStringFromCGPoint(CGPointMake(pointX, y))];
                !self.pathPointBlock ? : self.pathPointBlock(pointX, y);
            }];
            if (self.pathW > 0) {
                pointX += (self.pathW + self.pathS);
            } else {
                pointX += groupWidth;
            }
            [self.pathArrM addObject:arrM];
            
            if (idx == arr.count - 1) { !self.animaActionBlock ? : self.animaActionBlock(); }
        }];
    } else {
        CGFloat sumSWidth = self.barSpac*(subArr.count - 1); // 每组柱子中总间距的总宽度
        CGFloat sumWidth = groupWidth - sumSWidth; // 每组柱子中除间距的总宽度
        CGFloat width = self.barWS*(sumWidth/subArr.count); // 实际柱子的宽度
        __block CGFloat pointX = 0.5*(groupWidth - (sumSWidth+subArr.count*width)) + 0.5*width;
        [arr enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            __block CGFloat x = pointX;
            NSMutableArray *arrM = [[NSMutableArray alloc]init];
            [obj enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *val = [NSString stringWithFormat:@"%f", fabs(str.floatValue)];
                if (self.isUpDownBar) {
                    val = [NSString stringWithFormat:@"%f", str.floatValue];
                }
                CGFloat h = self.isUpDownBar ? 0.5*self.height : self.height;
                CGFloat y = minIdx == maxIdx ? h : h * (1 - ([val floatValue] - minIdx) / (maxIdx - minIdx));
                
                [arrM addObject:NSStringFromCGPoint(CGPointMake(x, y))];
                !self.pathPointBlock ? : self.pathPointBlock(x, y);
                
                x += (width + self.barSpac);
            }];
            pointX += groupWidth; [self.pathArrM addObject:arrM];
            
            if (idx == arr.count - 1) { !self.animaActionBlock ? : self.animaActionBlock(); }
        }];
        self.barWidth = width;
    }
}

//// 绘制图表动作
//-(void)drawChartAction:(CALayer *)layer{
//    UIView *bar = [JCLKitObj JCLView:self color:nil]; [bar.layer addSublayer:layer];
//    [JCLKitObj RXTap:bar target:self action:@selector(chartAction:) number:1];
//}
//
//-(void)chartAction:(UITapGestureRecognizer *)tap{
//    UIView *view = (UIView*)tap.view;
//    !self.pathActionBlock ? : self.pathActionBlock(view.frame);
//}

#pragma mark 2.绘制/折线柱状图
-(void)InitPathPoint{
    [self setupPathArr];
    
    NSArray *arr = self.pathArrM;
    __block UIColor *pathCol = self.pointCol;
    NSArray *subArr = arr[0];
    [subArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.style == JCLChartPathBroken) {
            if (self.isMacd) { if (idx == subArr.count - 2) { *stop = YES; } }
            
            UIBezierPath *path = [UIBezierPath bezierPath]; UIBezierPath *pathBg = [UIBezierPath bezierPath];
            [arr enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger index, BOOL *stop) {
                CGPoint point = CGPointFromString(obj[idx]);
                if (self.isTime) {
                    if (index == 0) { [pathBg moveToPoint:CGPointMake(point.x, self.height)]; }
                    [pathBg addLineToPoint:CGPointMake(point.x, point.y)];
                    if (index == arr.count - 1) { [pathBg addLineToPoint:CGPointMake(point.x, self.height)]; [pathBg closePath]; }
                }
                if (point.y != -4444) {
                    [path addLineToPoint:CGPointMake(point.x, point.y)]; [path moveToPoint:CGPointMake(point.x, point.y)];
                }
            }];
            if (self.pointCols.count >= subArr.count && self.pointCols) { pathCol = self.pointCols[idx]; }
            
            if (self.isTime && idx == 0) {
                NSMutableArray *colors = [NSMutableArray arrayWithArray:@[(__bridge id)JCLRGBA(13, 36, 62, 0.8).CGColor, (__bridge id)JCLRGBA(13, 36, 62, 0.4).CGColor, (__bridge id)JCLRGBA(13, 36, 62, 0.2).CGColor]];
                CAGradientLayer *gradient = [JCLChartManage JCLGradient:self colors:colors];
                CAShapeLayer *layer = [CAShapeLayer layer]; [self.layer addSublayer:layer]; layer.path = pathBg.CGPath;
                gradient.mask = layer;
            }
            CAShapeLayer *layer = [JCLChartManage JCLInitLayer:self path:path width:self.pointW strokeCol:pathCol fillCol:pathCol];
            if (self.aniTime != 0) { [self InitAnima:layer style:@"strokeEnd" from:@(0) to:@(1)]; }
        } else {
            [arr enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger index, BOOL *stop) {
                if (self.pointCols.count >= subArr.count && self.pointCols) { pathCol = self.pointCols[idx]; }
                if (self.isLRBar) {
                    NSInteger middle = 0.5*arr.count;
                    if (index < middle) {
                        pathCol = self.pointCols[0];
                    } else if (index > middle) {
                        pathCol = self.pointCols[2];
                    } else {
                        pathCol = self.pointCols[1];
                    }
                }
                
                if (self.lossCol) {
                    pathCol = [self.pointArr[index][idx] floatValue] < 0 ? self.lossCol : self.pointCol;
                }
                [self InitBar:obj[idx] color:pathCol];
            }];
        }
    }];
}

-(void)InitBar:(id)obj color:(UIColor *)color{
    CGPoint point = CGPointFromString(obj);
    CGFloat moveY = self.height, addY = point.y;
    if (self.isRound) {
        moveY = self.height - 0.5*self.barWidth, addY = point.y + 0.5*self.barWidth;
    }
    
    if (self.isUpDownBar) {
        moveY = 0.5*self.height;
        color = moveY > addY ? JCLChartRise : JCLChartFall;
    }
    
    NSArray *arr = @[NSStringFromCGPoint(CGPointMake(point.x, moveY)), NSStringFromCGPoint(CGPointMake(point.x, addY))];
    CAShapeLayer *layer = [self InitLinePath:arr width:self.barWidth strokeCol:color fillCol:color];
    if (self.isRound) { layer.lineCap = kCALineCapRound; layer.lineJoin = kCALineCapRound; }
    if (self.aniTime != 0) { [self InitAnima:layer style:@"strokeEnd" from:@(0) to:@(1)]; }
}

#pragma mark 4.绘制环形图
-(void)drawChartRing{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:JCLPoint radius:JCLPoint.y startAngle:0 endAngle:M_PI_2*4 clockwise:YES];
    [JCLChartManage JCLInitLayer:self path:path width:self.ringW strokeCol:self.ringBgCol fillCol:[UIColor clearColor]];
    CAShapeLayer *layer = [JCLChartManage JCLInitLayer:self path:path width:self.ringW strokeCol:self.ringValCol fillCol:[UIColor clearColor]];
    layer.strokeStart = 0.0f; layer.strokeEnd = self.ringEndVal;
    
    [self InitAnima:layer style:@"strokeEnd" from:@(layer.strokeStart) to:@(layer.strokeEnd)];
}

-(void)drawChartRings{
    CGFloat sumVal = [[self.ringArr valueForKeyPath:@"@sum.floatValue"] floatValue];
    __block CGFloat start = 0.00, end = 0.00;
    [self.ringArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL *stop) {
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:JCLPoint radius:JCLPoint.y startAngle:0 endAngle:M_PI_2*4 clockwise:YES];
        end = start + [obj floatValue]/sumVal;
        CAShapeLayer *layer = [JCLChartManage JCLInitLayer:self path:path width:self.ringW strokeCol:self.ringCols[idx] fillCol:[UIColor clearColor]];
        layer.strokeStart = start; layer.strokeEnd = end;
        start = end;
        
        [self InitAnima:layer style:@"strokeEnd" from:@(layer.strokeStart) to:@(layer.strokeEnd)];
        
        [self.pathArrM addObject:layer];
    }];
}

#pragma mark 5.绘制饼图
-(void)drawChartPie{
    NSArray *arr = self.pieArr, *colors = self.pieCols;
    if (self.pathArrM.count < arr.count) {
        CGFloat sumVal = [[arr valueForKeyPath:@"@sum.floatValue"] floatValue];
        __block CGFloat start = 0.00, end = 0.00;
        [arr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL *stop) {
            end = start + 360*([obj floatValue]/sumVal);
            CAShapeLayer *layer = [self InitRadian:0.5*self.height start:start end:end strokeCol:colors[idx] fillCol:colors[idx]];
            NSInteger index = self.pieIdx < arr.count ? self.pieIdx : 4444;
            if (idx == index) {
                [self InitPieAnima:layer idx:idx];
            }
            start = end;
            
            [self.pathArrM addObject:layer];
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    if (self.style == JCLChartPathPie) {
        CGPoint point = [[touches anyObject] locationInView:self];
        [self.pathArrM enumerateObjectsUsingBlock:^(CAShapeLayer *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (CGPathContainsPoint(obj.path, 0, point, YES)) {
                id to = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)];
                [self InitAnima:self.selectLayer style:@"transform" from:nil to:to];
                [self InitPieAnima:obj idx:idx];
                
                !self.pathActionBlock ? : self.pathActionBlock(idx);
            }
        }];
    }
}

-(void)InitPieAnima:(CAShapeLayer *)obj idx:(NSInteger)idx{
    if (self.isPieAnima) {
        NSArray *arr = self.pieArr;
        NSArray *fromArr = [JCLChartManage JCLAnglePoint:arr point:JCLPoint radius:JCLPoint.y];
        CGPoint fromPoint = CGPointFromString(fromArr[idx]);
        
        NSArray *toArr = [JCLChartManage JCLAnglePoint:arr point:JCLPoint radius:JCLPoint.y + 6];
        CGPoint toPoint = CGPointFromString(toArr[idx]);
        
        CGPoint point = CGPointMake(toPoint.x - fromPoint.x, toPoint.y - fromPoint.y);
        [self InitAnima:obj style:@"transform" from:nil to:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(point.x, point.y, 0)]];
        self.selectLayer = obj;
    }
}

-(CAShapeLayer *)InitRadian:(CGFloat)radius start:(CGFloat)start end:(CGFloat)end strokeCol:(UIColor *)strokeCol fillCol:(UIColor *)fillCol{
    UIBezierPath *path = [JCLChartManage JCLInitRadian:JCLPoint radius:radius start:start end:end];
    return [JCLChartManage JCLInitLayer:self path:path width:0 strokeCol:strokeCol fillCol:fillCol];
}

#pragma mark 6.绘制雷达图
-(void)drawChartRadar{
    self.radarArr = @[@"33", @"44",@"22", @"11", @"66"];
    
    NSInteger number = 5;
    CGFloat radius = 0.5*self.height;
    CGFloat s = 0.5*self.height/number;
    for (int i = 0; i < number; i++) {
        NSArray *arr = [self InitRadarPoint:radius style:44];
        [self InitLinePath:arr width:1 strokeCol:JCLBGRGB fillCol:[UIColor clearColor]];
        radius = radius - s;
        if (i == 0) { [self.pathArrM addObjectsFromArray:arr]; }
    }
    
    [self.pathArrM enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *arr = @[NSStringFromCGPoint(CGPointMake(0.5*self.width, 0.5*self.height)), obj];
        [self InitLinePath:arr width:1 strokeCol:JCLBGRGB fillCol:[UIColor clearColor]];
    }];
    
    [self InitLinePath:[self InitRadarPoint:JCLPoint.y style:4] width:1 strokeCol:JCLChartRise fillCol:[UIColor clearColor]];
}

-(NSArray *)InitRadarPoint:(CGFloat)radius style:(NSInteger)style{
    return [JCLChartManage JCLAnglePoint:self.radarArr point:JCLPoint radius:radius style:style];
}

-(CAShapeLayer *)InitLinePath:(NSArray *)arr width:(CGFloat)width strokeCol:(UIColor *)strokeCol fillCol:(UIColor *)fillCol{
    return [JCLChartManage JCLInitLayer:self path:[JCLChartManage JCLInitLine:arr isClose:YES] width:width strokeCol:strokeCol fillCol:fillCol];
}

-(CABasicAnimation *)InitAnima:(CAShapeLayer *)layer style:(NSString *)style from:(id)from to:(id)to{
    return [JCLChartManage JCLInitAnima:layer style:style from:from to:to time:self.aniTime delegate:self];
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{ !self.animaActionBlock ? : self.animaActionBlock(); }
@end

