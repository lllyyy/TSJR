//
//  JCLStockRankRangeCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/29.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockRankDealCell.h"

@interface JCLStockRankDealCell()
@property(nonatomic, strong) JCLChartPath *pie;
@property(nonatomic, strong) NSMutableArray *textArrM;
@property(nonatomic, strong) NSMutableArray *pointArrM;
@property(nonatomic, strong) NSMutableArray *lineArrM;
@end

@implementation JCLStockRankDealCell
+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style{
    static NSString *ID = @"RankDealCell";
    JCLStockRankDealCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLStockRankDealCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setArr:(NSArray *)arr{
    _arr = arr;
    
    [self.pie removeFromSuperview]; [JCLKitObj JCLRemoveKit:self.textArrM];
    [JCLKitObj JCLRemoveLayer:self.pointArrM]; [JCLKitObj JCLRemoveLayer:self.lineArrM];
    if (arr.count) {
        JCLChartPath *pie = [[JCLChartPath alloc]init]; [self addSubview:pie];
        pie.style = JCLChartPathPie;
        pie.pieArr = self.arr;
        pie.pieCols = @[JCLRGBA(238, 74, 89, 1), JCLRGBA(42, 188, 100, 1)];
        self.pie = pie;
    }
}

-(NSMutableArray *)textArrM{ if (_textArrM) return _textArrM; return _textArrM = [[NSMutableArray alloc]init]; }
-(NSMutableArray *)pointArrM{ if (_pointArrM) return _pointArrM; return _pointArrM = [[NSMutableArray alloc]init]; }
-(NSMutableArray *)lineArrM{ if (_lineArrM) return _lineArrM; return _lineArrM = [[NSMutableArray alloc]init]; }
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat pieY = 28;
    self.pie.frame = CGRectMake(0, pieY, self.width, self.height - 2*pieY);
    
    if (!self.textArrM.count) {
        NSArray *arr = self.arr;
        CGPoint point = CGPointMake(0.5*self.pie.width, 0.5*self.pie.height);
        NSArray *moveArr = [JCLChartManage JCLAnglePoint:arr point:CGPointMake(0.5*self.width, 0.5*self.height) radius:0.8*point.y];
        NSArray *addArr = [JCLChartManage JCLAnglePoint:arr point:CGPointMake(0.5*self.width, 0.5*self.height) radius:1.12*point.y];
        NSArray *value = @[@"买入总计(万): ", @"卖出总计(万): "]; //*cols = @[JCLRGBA(238, 74, 89, 1), JCLRGBA(42, 188, 100, 1)];
        [moveArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGPoint movePoint = CGPointFromString(obj); CGFloat wh = 5;
            
            CGPoint addPoint = CGPointFromString(addArr[idx]); CGFloat lineW = point.y + 4;
            CGFloat addsPointX = movePoint.x > point.x ? point.x + lineW : point.x - lineW;
            CGPoint addsPoint = CGPointMake(addsPointX, addPoint.y);
            CAShapeLayer *line = [self InitLinePath:@[obj, addArr[idx], NSStringFromCGPoint(addsPoint)] width:1.4 strokeCol:JCLRGBA(224, 224, 224, 1) fillCol:[UIColor clearColor]];
            [self.lineArrM addObject:line];
            
            UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(movePoint.x - 0.5*wh, movePoint.y - 0.5*wh, wh, wh)];
            CAShapeLayer *layer = [JCLChartManage JCLInitLayer:self path:path width:0 strokeCol:JCLBGRGB fillCol:JCLBGRGB];
            [self.pointArrM addObject:layer];
            
            UILabel *info = [JCLKitObj JCLLable:self font:12 color:nil alignment:1];
            NSString *val = [NSString stringWithFormat:@"%.2lf", [arr[idx] floatValue]/10000];
            NSString *text = [NSString stringWithFormat:@"%@%@",value[idx], val];
            info.attributedText = [JCLKitObj RXAttStr:text color:[UIColor blackColor] endIdx:val.length]; // cols[idx]
            
            CGSize size = [JCLKitObj JCLTextSize:info.text font:info.font width:0.5*self.width - 0.5*self.height];
            CGFloat x = addsPoint.x < 0.5*self.width ? addsPoint.x - size.width : addsPoint.x;
            CGFloat y = addsPoint.y - 0.5*size.height;
            info.frame = CGRectMake(x, y, size.width, size.height);
            
            [self.textArrM addObject:info];
        }];
    }
}

-(CAShapeLayer *)InitLinePath:(NSArray *)arr width:(CGFloat)width strokeCol:(UIColor *)strokeCol fillCol:(UIColor *)fillCol{
    return [JCLChartManage JCLInitLayer:self path:[JCLChartManage JCLInitLine:arr isClose:NO] width:width strokeCol:strokeCol fillCol:fillCol];
}
@end
