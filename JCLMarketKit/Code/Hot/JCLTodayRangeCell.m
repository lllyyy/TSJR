//
//  JCLTodayRangeCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/12.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTodayRangeCell.h"

@interface JCLTodayRangeCell()
@property(nonatomic, weak) JCLChartPath *box;
@property(nonatomic, weak) JCLChartPath *broken;

@property(nonatomic, weak) JCLChartScale *left;
@property(nonatomic, weak) JCLChartScale *time;

@property(nonatomic, assign) BOOL isBox;
@property(nonatomic, assign) CGFloat barWidth;
@end

@implementation JCLTodayRangeCell
+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style{
    static NSString *ID = @"TodayRangeCell";
    JCLTodayRangeCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLTodayRangeCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        
        JCLChartPath *box = [[JCLChartPath alloc]init]; [self addSubview:box];
        box.boxNumH = 1; box.boxNumV = 0; box.boxW = 1.4; box.boxCol = JCLBGRGB;
        box.style = JCLChartPathBox;
        self.box = box;
        self.barWidth = box.boxW;
    }
    return self;
}

-(void)setArr:(NSArray *)arr{
    _arr = arr;
    
    [self.broken removeFromSuperview]; [self.left removeFromSuperview]; [self.time removeFromSuperview];
    self.broken = nil;
    if (arr.count && self.broken == nil) {
        CGFloat min = [[arr valueForKeyPath:@"@min.floatValue"] floatValue];
        CGFloat max = [[arr valueForKeyPath:@"@max.floatValue"] floatValue];
        if (fabs(min) > fabs(max)) {
            max = fabs(min);
        } else {
            min = -max;
        }
        NSArray *rangeArr = @[[NSString stringWithFormat:@"%.2lf", max], @"0", [NSString stringWithFormat:@"%.2lf", min]];
        self.left = [self InitScale:rangeArr style:JCLChartScaleLineV alignment:NSTextAlignmentLeft];
        
        NSMutableArray *arrM = [[NSMutableArray alloc]init];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *val = idx <= self.idx ? obj : @"";
            [arrM addObject:@[[NSString stringWithFormat:@"%@", val]]];
        }];
        JCLChartPath *broken = [[JCLChartPath alloc]init]; [self addSubview:broken];
        broken.minVal = [NSString stringWithFormat:@"%f", min], broken.maxVal = [NSString stringWithFormat:@"%f", max];
        broken.style = JCLChartPathBroken;
        broken.pointW = 1;
        broken.pointArr = arrM;
        broken.pointCol = JCLRGBA(219, 63, 42, 1);
        self.broken = broken;

        NSArray *timeArr = @[@"09:30", @"", @"15:00"];
        self.time = [self InitScale:timeArr style:JCLChartScaleBoxV alignment:NSTextAlignmentCenter];
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
    CGFloat timeY = self.height - size.height - boxY;
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
