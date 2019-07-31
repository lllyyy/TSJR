//
//  JCLStockTodayCapitalCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/29.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockTodayCapitalCell.h"

@interface JCLStockTodayCapitalCell()
@property (nonatomic, strong) NSMutableArray *keyArrM;
@property (nonatomic, strong) NSMutableArray *keyColsM;
@property (nonatomic, strong) NSMutableArray *valArrM;
@property (nonatomic, strong) NSMutableArray *scaleArrM;
@property(nonatomic, strong) JCLChartPath *pie;
@property(nonatomic, assign) NSInteger idx;
@property(nonatomic, weak) UIView *bg;
@end

@implementation JCLStockTodayCapitalCell
+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style{
    static NSString *ID = @"TodayCapitalCell";
    JCLStockTodayCapitalCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLStockTodayCapitalCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(NSMutableArray *)keyArrM{ if (_keyArrM) return _keyArrM; return _keyArrM = [[NSMutableArray alloc]init]; }
-(NSMutableArray *)keyColsM{ if (_keyColsM) return _keyColsM; return _keyColsM = [[NSMutableArray alloc]init]; }
-(NSMutableArray *)valArrM{ if (_valArrM) return _valArrM; return _valArrM = [[NSMutableArray alloc]init]; }
-(void)setKeyArr:(NSArray *)keyArr{
    _keyArr = keyArr;
    self.backgroundColor = JCL_Cell_COL;
    [self.pie removeFromSuperview];
    [JCLKitObj JCLRemoveKit:self.keyArrM]; [JCLKitObj JCLRemoveKit:self.scaleArrM]; [JCLKitObj JCLRemoveKit:self.keyColsM];
    [self.valArrM removeAllObjects];
    if (keyArr.count && !self.keyColsM.count) {
        self.idx = 0;
        NSArray *keyArr = self.keyArr;
        NSArray *cols = self.keyCols;
        NSArray *arr = @[@"主力流入", @"主力流出", @"散户流入", @"散户流出"];
        
        NSMutableArray *arrM = [[NSMutableArray alloc]init];
        [keyArr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arrM addObject:[NSString stringWithFormat:@"%f", fabs(obj.doubleValue)]];
        }];
        CGFloat sum = [[arrM valueForKeyPath:@"@sum.floatValue"] floatValue];
        
        [arrM enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.keyColsM addObject:[JCLKitObj JCLView:self color:cols[idx]]];
            UILabel *info = [JCLKitObj JCLLable:self font:13 color:JCL_Text_COL alignment:0];
            NSString *val = [JCLMarketObj JCLMarketUnit:obj decimal:nil style:1];
            val = [val isEqualToString:@" --"] ? @"0.00" : val;
            NSString *text = [NSString stringWithFormat:@"%@: %@", arr[idx], val];
            info.attributedText = [JCLKitObj RXAttStr:text color:cols[idx] endIdx:val.length];
            [self.keyArrM addObject:info];
            [self.valArrM addObject:[NSString stringWithFormat:@"%.2lf%%", obj.floatValue/sum*100]];
        }];
        
        JCLChartPath *pie = [[JCLChartPath alloc]init]; [self addSubview:pie];
        pie.style = JCLChartPathPie;
        pie.pieArr = self.valArrM;
        pie.pieCols = cols;
        self.pie = pie;
        
        self.bg = [JCLKitObj JCLView:self color:nil];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat topS = 14, wh = 0.14*self.height, s = (self.height - 2*topS - self.keyColsM.count*wh)/self.keyColsM.count;
    [self.keyColsM enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(topS, topS + s*idx + wh*idx, wh, wh);
    }];
    [self.keyArrM enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(topS+wh + 8, topS + s*idx + wh*idx, self.width, wh);
    }];
    self.pie.frame = CGRectMake(0.5*self.width, 14, 0.5*self.width, self.height - 3*14);
    self.bg.frame = self.pie.frame;
    if (self.keyArr.count && self.idx < 1) {
        CGFloat centX = 0.5*self.pie.width, centY = 0.5*self.pie.height;
        NSArray *XYArr = [JCLChartManage JCLAnglePoint:self.valArrM point:CGPointMake(centX, centY) radius:0.36*self.pie.height];
        [XYArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *info = [JCLKitObj JCLLable:self.bg font:8 color:[UIColor whiteColor] alignment:1];
            NSString *text = [self.valArrM[idx] floatValue] > 0 ? self.valArrM[idx] : @"";
            info.text = text;
            CGSize size = [JCLKitObj JCLTextSize:info.text font:info.font width:self.width];
            CGPoint point = CGPointFromString(obj);
            CGFloat x = point.x - 0.5*size.width, y = point.y - 0.5*size.height ;
            info.frame = CGRectMake(x, y, size.width, size.height); info.tag = idx;
            [self.scaleArrM addObject:info];
        }];
        
        CGFloat pathWH = 0.16*self.width;
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(centX - 0.5*pathWH, centY - 0.5*pathWH, pathWH, pathWH)];
        [JCLChartManage JCLInitLayer:self.bg path:path width:0 strokeCol:JCL_Cell_COL fillCol:JCL_Cell_COL];
        self.idx++;
    }
}
@end
