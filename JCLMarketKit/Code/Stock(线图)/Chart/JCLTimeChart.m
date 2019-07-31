//
//  JCLTimeChart.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/6/12.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTimeChart.h"

@interface JCLTimeChart()
@property (nonatomic, weak) JCLChartPath *idxBox;
@property (nonatomic, weak) JCLChartPath *idxLine;
@property (nonatomic, weak) JCLChartScale *range;
@property (nonatomic, weak) JCLChartScale *scale;
@property (nonatomic, weak) JCLChartScale *timeRange;
@property (nonatomic, weak) JCLChartPath *volBox;
@property (nonatomic, weak) JCLChartPath *volLine;
@property (nonatomic, weak) JCLChartScale *volRange;

@property (nonatomic, assign) CGFloat boxS;
@property (nonatomic, assign) CGFloat pathS;
@property (nonatomic, assign) CGFloat pathW;

@property(nonatomic,weak)UIView *XLine;   @property(nonatomic,weak)UIView *YLine;    @property(nonatomic,weak)UILabel *time;
@property (nonatomic, strong) NSMutableArray *timeM;
@end

@implementation JCLTimeChart
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) { self.backgroundColor = JCL_Cell_COL;
        self.boxS = 1;
        self.idxBox = [self drawPathBox:3 v:3];
        //self.timeRange = [self InitScale:self arr:@[@"9:30", @"11:30/13:00", @"15:00"] style:JCLChartScaleBoxV alignment:0];
        
        self.volBox = [self drawPathBox:1 v:1];
        [JCLKitObj RXLongPress:self target:self action:@selector(longAction:)];
        [JCLKitObj RXTap:self target:self action:@selector(tapAction:) number:2];
    } return self;
}

-(void)setTimes:(NSArray *)times{
    _times = times;
    self.timeM = [[NSMutableArray alloc]init];
    [times enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *time = [JCLKitObj JCLLable:self font:10 color:JCL_Text_COL alignment:1];
        time.text = [NSString stringWithFormat:@"%@", obj[0]];
        [self.timeM addObject:time];
    }];
}


-(JCLChartPath *)drawPathBox:(CGFloat)h v:(CGFloat)v{
    JCLChartPath *box = [[JCLChartPath alloc]init]; [self addSubview:box];
    box.boxNumH = h; box.boxNumV = v; box.boxW = self.boxS; box.boxCol = JCLHexCol(@"#282B33"); box.isDash = YES;
    box.style = JCLChartPathBox;
    box.layer.borderWidth = self.boxS, box.layer.borderColor = box.boxCol.CGColor;
    return box;
}

-(JCLChartScale *)InitScale:(UIView *)parent arr:(NSArray *)arr style:(JCLChartScaleStyle)style alignment:(NSInteger)alignment{
    JCLChartScale *scale = [[JCLChartScale alloc]init]; [parent addSubview:scale]; scale.frame = parent.frame;
    scale.style = style; scale.alignment = alignment;
    scale.size = 9; scale.color = JCLRGBA(144, 144, 144, 1);
    if (arr.count>=3 && style == JCLChartScaleLineV) { scale.textCols = @[JCLChartRise, JCLChartStop, JCLChartFall]; }
    scale.idxArr = arr;
    return scale;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.idxBox.frame = CGRectMake(0, 0, self.width, 0.66*self.height);
    
    __block NSString *nums = self.times[self.times.count-1][1];
    [self.timeM enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *index = [NSString stringWithFormat:@"%@", self.times[idx][1]];
        
        CGFloat x = 0;
        if(idx != 0 && idx !=self.times.count-1){
            CGFloat range = index.floatValue/nums.floatValue;
            x = range*self.width;
        }
        
        CGSize size = [JCLKitObj JCLTextSize:obj.text font:obj.font];
        if (idx == self.times.count-1) {
            x = self.width - size.width;
        }
        obj.frame = CGRectMake(x, self.idxBox.maxY, size.width, 0.1*self.height);
        
    }];
    //self.timeRange.frame = CGRectMake(0, self.idxBox.maxY, self.width, 0.1*self.height);
    self.volBox.frame = CGRectMake(0, self.idxBox.maxY+0.1*self.height, self.width, 0.24*self.height);
}

-(void)setArr:(NSArray *)arr{
    _arr = arr;
    if (arr.count) {
        self.pathS = 0;
        if (self.width > JCLWIDTH) {
            self.pathS = 0;
        }
        self.pathW =  (self.width-2*(self.boxS)) / 90 ;
        NSLog(@"==self.pathW== %f",self.pathW);
        [self.idxLine removeFromSuperview]; [self.volLine removeFromSuperview];
        NSMutableArray *lineArrM = [[NSMutableArray alloc]init];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           [lineArrM addObject:@[obj[1]]];
        }];
        
        NSLog(@"==lineArrM=== %@",lineArrM);
        
        self.idxLine = [self drawPathBroken:self.idxBox arr:lineArrM];
        self.volLine = [self drawPathVol:self.volBox arr:arr];
 
    }
}

-(JCLChartPath *)drawPathBroken:(UIView *)parent arr:(NSArray *)arr{
    JCLChartPath *broken = [[JCLChartPath alloc]init];
    [parent addSubview:broken];
    broken.layer.masksToBounds = YES;
    CGFloat s = self.boxS; broken.frame = CGRectMake(s, s, parent.width-2*s, parent.height-2*s);
    broken.style = JCLChartPathBroken;
//    broken.isTime = YES;
//    broken.pathW = self.pathW;
//    broken.pathS = self.pathS;
//    broken.close = self.close.floatValue;
     broken.pointW = 1;
    
    broken.pointArr = arr;
    broken.pointCols = @[[UIColor whiteColor], JCLHexCol(@"#F41F0A")];
    __weak typeof(broken)weakBroken = broken;
    broken.animaActionBlock = ^(){
        [self InitIdxRange:weakBroken]; };
    return broken;
}

-(void)InitIdxRange:(UIView *)parent{
    [self.range removeFromSuperview]; [self.scale removeFromSuperview];
    NSString *max = [JCLMarketObj JCLMarketPrice:self.idxLine.maxVal.floatValue decimal:self.decimal];
    NSString *min = [JCLMarketObj JCLMarketPrice:self.idxLine.minVal.floatValue decimal:self.decimal];
    NSArray *rangeArr = @[max, self.close, min];
    self.range = [self InitScale:self arr:rangeArr style:JCLChartScaleLineV alignment:0]; self.range.frame = parent.frame;
    
    NSString *maxR = [JCLMarketObj JCLMarketRange:max close:self.close is:self.decimal];
    NSString *minR = [JCLMarketObj JCLMarketRange:min close:self.close is:self.decimal];
    NSArray *scaleArr = @[[JCLMarketObj JCLMarketScale:maxR close:self.close], @"0.00%", [JCLMarketObj JCLMarketScale:minR close:self.close]];
    self.scale = [self InitScale:self arr:scaleArr style:JCLChartScaleLineV alignment:2]; self.scale.frame = parent.frame;
}


-(JCLChartPath *)drawPathVol:(UIView *)parent arr:(NSArray *)arr{
    JCLChartPath *vol = [[JCLChartPath alloc]init]; [parent addSubview:vol];
    vol.layer.masksToBounds = YES;
    CGFloat s = self.boxS; vol.frame = CGRectMake(s, s, parent.width-2*s, parent.height-2*s);
    vol.style = JCLChartPathTimeVol; vol.pathW = self.pathW; vol.pathS = self.pathS; vol.close = self.close.floatValue; vol.minVal = @"0";
    vol.pointArr = arr;
    __weak typeof(vol)weakVol = vol;
    vol.animaActionBlock = ^(){
        [self.volRange removeFromSuperview];
        NSArray *rangeArr = @[[JCLMarketObj JCLMarketUnit:weakVol.maxVal decimal:self.decimal style:2],
                              [JCLMarketObj JCLMarketUnit:weakVol.minVal decimal:self.decimal style:2]];
        self.volRange = [self InitScale:self arr:rangeArr style:JCLChartScaleLineV alignment:0]; self.volRange.frame = parent.frame;
    };
    return vol;
}

-(void)longAction:(UILongPressGestureRecognizer *)longResture{
    if (self.arr) {
        CGPoint point = [longResture locationInView:self];
        if(longResture.state == UIGestureRecognizerStateBegan){
            self.XLine = [JCLKitObj JCLView:self color:JCL_Line_COL];
            self.time = [JCLKitObj JCLLable:self font:10 color:@"" alignment:1];
            self.time.backgroundColor = JCL_Line_COL;
            self.time.layer.cornerRadius = 4;
            [self drawCrossLine:point];
        } if (longResture.state == UIGestureRecognizerStateChanged) {
            [self drawCrossLine:point];
        } else if (longResture.state == UIGestureRecognizerStateEnded) {
            [self longNot:NO obj:@[]]; !self.longActionBlock ? : self.longActionBlock(NO, @[]);
            [self.XLine removeFromSuperview]; [self.YLine removeFromSuperview]; [self.time removeFromSuperview];
        }
    }
}

-(void)drawCrossLine:(CGPoint)point{
    __block CGFloat pointX = 0.0, wh = 1.2, y = self.idxLine.y;
    
     NSLog(@"volLinevolLine %@",self.volLine.XYArr);
    
    [self.volLine.XYArr enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"objobj %@",obj)
        
        CGPoint objPoint = CGPointFromString([obj objectAtIndex:0]);
        pointX = objPoint.x;
        
        NSLog(@"pointX %f",pointX)
        if (pointX == point.x || point.x-pointX <= self.pathW/2) {
            
            NSLog(@" obj[1] obj[1] %@", obj[1])
           
            self.XLine.frame = CGRectMake(objPoint.x - 0.5*wh + 1, y, wh, self.height - y -1);
            CGSize size = [JCLKitObj JCLTextSize:@"20160404" font:self.time.font];
            CGFloat x = pointX < 0.5*self.width ? point.x + 2 : point.x - 1.4*size.width - 2;
            self.time.frame = CGRectMake(x, y, size.width, 1.4*size.height);
            if ([NSString stringWithFormat:@"%@", obj[1]].length > 3) {
                 NSString *val =  [[JCLKitObj timeStampString:obj[1]] substringWithRange:NSMakeRange(11, 5)];
                NSLog(@"val--------------------- %@",[JCLKitObj timeStampString:obj[1]]);
 
//                 self.time.text =  [NSString stringWithFormat:@"%@",val];
//                 NSLog(@"timetimetime %@",self.time.text);
                
            } else {
//                self.time.text = [NSString stringWithFormat:@"0%@:%@", [obj[1] substringToIndex:1], [obj[1] substringFromIndex:1]];
            }
            [self longNot:YES obj:obj]; !self.longActionBlock ? : self.longActionBlock(YES, obj);
            *stop = YES;
        }
    }];
}

-(void)longNot:(BOOL)isHave obj:(NSArray *)obj{
    NSDictionary *dic = @{@"isHave":[NSNumber numberWithBool:isHave], @"obj":obj};
    [[NSNotificationCenter defaultCenter] postNotificationName:KLineLongNot object:nil userInfo:dic];
}

-(void)tapAction:(UIGestureRecognizer*)gesture{
    [[NSNotificationCenter defaultCenter] postNotificationName:KLinePushNot object:nil];
    
}
@end
