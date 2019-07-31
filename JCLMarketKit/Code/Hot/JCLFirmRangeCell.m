//
//  JCLFirmRangeCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/12.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//
#import "JCLFirmRangeCell.h"

@interface JCLFirmRangeCell()
@property(nonatomic, weak) JCLChartPath *box;
@property(nonatomic, weak) JCLChartPath *broken;

@property(nonatomic, weak) JCLChartScale *left;
@property(nonatomic, weak) JCLChartScale *time;

@property(nonatomic, assign) BOOL    isBox;
@property(nonatomic, assign) CGFloat barWidth;
@property(nonatomic, strong) NSMutableArray *keyArrM;
@end

@implementation JCLFirmRangeCell
+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style{
    static NSString *ID = @"FirmRangeCell";
    JCLFirmRangeCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLFirmRangeCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        
        JCLChartPath *box = [[JCLChartPath alloc]init]; [self addSubview:box];
        box.boxNumH = 0; box.boxNumV = 0; box.boxW = 1.4; box.boxCol = JCLBGRGB; box.isDash = YES;
        box.style = JCLChartPathBox;
        self.box = box;
        self.barWidth = box.boxW;
    }
    return self;
}

-(NSMutableArray *)keyArrM{ if (_keyArrM) return _keyArrM; return _keyArrM = [[NSMutableArray alloc]init]; }
-(void)setFallArr:(NSArray *)fallArr{
    _fallArr = fallArr;
    
    [self.broken removeFromSuperview]; [self.left removeFromSuperview]; [self.time removeFromSuperview];
    [JCLKitObj JCLRemoveKit:self.keyArrM];
    self.broken = nil;

    if (fallArr.count && self.riseArr.count && self.broken == nil) {
        NSArray *maxArr, *minArr; NSArray *colors;
        if (fallArr.count < self.riseArr.count) {
            maxArr = self.riseArr; minArr = fallArr; colors = @[JCLRGBA(242, 79, 88, 1), JCLRGBA(28, 185, 113, 1)];
        } else {
            maxArr = fallArr; minArr = self.riseArr; colors = @[JCLRGBA(28, 185, 113, 1), JCLRGBA(242, 79, 88, 1)];
        }
        
        NSMutableArray *arrM = [[NSMutableArray alloc]init];
        [maxArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *val = idx <= self.idx ? obj : @"";
            NSString *min = idx <= self.idx && idx<minArr.count ? [NSString stringWithFormat:@"%@", minArr[idx]] : @"";
            [arrM addObject:@[[NSString stringWithFormat:@"%@", val], min]];
        }];
        
        JCLChartPath *broken = [[JCLChartPath alloc]init]; [self addSubview:broken];
        broken.style = JCLChartPathBroken; broken.minVal = @"0";
        broken.pointW = 1;
        broken.pointArr = arrM;
        broken.pointCols = colors;
        self.broken = broken;
        
        NSArray *subArr = arrM[0];
        NSMutableArray *minArrM = [[NSMutableArray alloc]init]; NSMutableArray *maxArrM = [[NSMutableArray alloc]init];
        [subArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableArray *arrM1 = [[NSMutableArray alloc]init];
            [arrM enumerateObjectsUsingBlock:^(NSArray *arr, NSUInteger index, BOOL *stop) { [arrM1 addObject:arr[idx]]; }];
            [minArrM addObject:[NSString stringWithFormat:@"%.2lf", [[arrM1 valueForKeyPath:@"@min.floatValue"] floatValue]]];
            [maxArrM addObject:[NSString stringWithFormat:@"%.2lf", [[arrM1 valueForKeyPath:@"@max.floatValue"] floatValue]]];
        }];
        
        
        NSString *max = [maxArrM valueForKeyPath:@"@max.floatValue"];
        NSArray *rangeArr = @[[NSString stringWithFormat:@"%@", max],
                              [NSString stringWithFormat:@"%.0lf", max.floatValue/2],
                              @"0"];
                              //[NSString stringWithFormat:@"%@", [minArrM valueForKeyPath:@"@min.floatValue"]]];
        self.left = [self InitScale:rangeArr style:JCLChartScaleLineV alignment:NSTextAlignmentLeft];
        NSArray *timeArr = @[@"09:30", @"", @"15:00"];
        self.time = [self InitScale:timeArr style:JCLChartScaleBoxV alignment:NSTextAlignmentCenter];
        
        colors = @[JCLRGBA(242, 79, 88, 1), JCLRGBA(28, 185, 113, 1)];
        NSArray *keyArr = @[[NSString stringWithFormat:@"涨停家数: (%@)", self.riseArr[self.idx]],
                            [NSString stringWithFormat:@"跌停家数: (%@)", fallArr[self.idx]]];
        [keyArr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *info = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:nil];
            info.title = obj; info.color = colors[idx];
            [self.keyArrM addObject:info];
        }];
    }
}

-(JCLChartScale *)InitScale:(NSArray *)arr style:(JCLChartScaleStyle)style alignment:(NSInteger)alignment{
    JCLChartScale *scale = [[JCLChartScale alloc]init]; [self addSubview:scale];
    scale.style = style; scale.alignment = alignment;
    scale.size = 11; scale.color = JCLRGBA(188, 188, 188, 1);
    scale.idxArr = arr;
    return scale;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat boxX = 14, boxY = 14;
    
    CGSize size = [JCLKitObj JCLTextSize:@"44" font:[JCLKitObj JCLFont:12]];

    CGFloat w = 0.6*self.width, x = 0.5*(self.width - w), h = size.height, y = self.height - h - boxY;
    [self.keyArrM enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(x+w*0.5*idx, y, w*0.5, h);
    }];
    
    CGFloat timeY = y - size.height - boxY;
    self.time.frame = CGRectMake(boxX, timeY, self.width - 2*boxX, size.height);
    
    self.box.frame = CGRectMake(boxX, boxY, self.width - 2*boxX, timeY - boxY);
    if (self.isBox == NO) {
        self.box.borderState = JCLChartPathBorderLeft;
        self.box.borderState = JCLChartPathBorderBottom;
        self.isBox = YES;
    }
    
    CGFloat barX = self.box.x + self.barWidth, barY = self.box.y + self.barWidth;
    self.broken.frame = CGRectMake(barX, barY, self.width - barX - boxX - self.barWidth, timeY - barY - self.barWidth);
    self.left.frame = CGRectMake(boxX + 2, boxY, self.width, timeY - boxY);
}
@end
