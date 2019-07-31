//
//  JCLStockRankTodayRangeCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/29.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockRankRangeCell.h"

@interface JCLStockRankRangeCell()
@property(nonatomic, weak) JCLChartPath *box;
@property(nonatomic, weak) JCLChartPath *bar;

@property(nonatomic, weak) JCLChartScale *left;
@property(nonatomic, weak) JCLChartScale *time;

@property(nonatomic, assign) BOOL isBox;
@property(nonatomic, assign) CGFloat barWidth;
@end

@implementation JCLStockRankRangeCell
+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style{
    static NSString *ID = @"RankRangeCell";
    JCLStockRankRangeCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLStockRankRangeCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        JCLChartPath *box = [[JCLChartPath alloc]init]; [self addSubview:box]; box.boxW = 1.4; box.boxCol = JCLBGRGB;
        box.style = JCLChartPathBox;
        self.box = box; self.barWidth = box.boxW;
    }
    return self;
}

-(void)setArr:(NSArray *)arr{
    _arr = arr;
    
    [self.bar removeFromSuperview]; [self.time removeFromSuperview];
    if (arr.count) {
        JCLChartPath *bar = [[JCLChartPath alloc]init]; [self addSubview:bar];
        bar.style = JCLChartPathBar; 
        bar.barSpac = 0; bar.barWS = 0.4; bar.minVal = @"0";
        bar.pointCol = JCLRGBA(238, 74, 89, 1); bar.lossCol = JCLRGBA(42, 188, 100, 1);
        NSMutableArray *arrM = [[NSMutableArray alloc]init];
        [arr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arrM addObject:@[obj]];
        }];
        bar.pointArr = arrM;
        __weak typeof(bar) weakBar = bar;
        __block NSInteger idx = 0;
        bar.pathPointBlock = ^(CGFloat x, CGFloat y){
            if (idx > arr.count -1) { return ; }
            UILabel *info = [JCLKitObj JCLLable:weakBar font:11 color:JCLRGBA(178, 178, 178, 1) alignment:1];
            info.text = [NSString stringWithFormat:@"%@", arr[idx]].length ? [NSString stringWithFormat:@"%@%%", arr[idx]] : @"0";
            CGSize size = [JCLKitObj JCLTextSize:info.text font:info.font];
            info.frame = CGRectMake(x - 0.5*size.width, y - size.height, size.width, size.height);
            idx += 1;
        };
        self.bar = bar;
        
//        NSArray *rangeArr = @[[NSString stringWithFormat:@"%@%%", [arr valueForKeyPath:@"@max.floatValue"]],
//                              [NSString stringWithFormat:@"%@%%", [arr valueForKeyPath:@"@min.floatValue"]]];
//        self.left = [self InitScale:rangeArr style:JCLChartScaleLineV alignment:NSTextAlignmentLeft];
//        self.left.size = 10;
        NSArray *keyArr = @[@"1日", @"3日", @"5日", @"10日"];
        self.time = [self InitScale:keyArr style:JCLChartScaleBoxH alignment:NSTextAlignmentCenter];
    }
}

-(JCLChartScale *)InitScale:(NSArray *)arr style:(JCLChartScaleStyle)style alignment:(NSInteger)alignment{
    JCLChartScale *scale = [[JCLChartScale alloc]init]; [self addSubview:scale];
    scale.style = style; scale.alignment = alignment;
    scale.size = 12; scale.color = JCLRGBA(178, 178, 178, 1);
    scale.idxArr = arr;
    return scale;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat boxX = 14, boxY = 14;
    
    CGSize size = [JCLKitObj JCLTextSize:@"44" font:[JCLKitObj JCLFont:self.time.size]];
    CGFloat timeY = self.height - size.height - boxY;
    self.time.frame = CGRectMake(boxX, timeY, self.width - 2*boxX, size.height+6);
    
    self.box.frame = CGRectMake(boxX, boxY, self.width - 2*boxX, timeY - boxY);
    if (self.isBox == NO) {
        self.box.borderState = JCLChartPathBorderLeft;
        self.box.borderState = JCLChartPathBorderBottom;
        self.isBox = YES;
    }
    
    CGFloat barX = self.box.x + self.barWidth, barY = self.box.y + self.barWidth + boxY;
    self.bar.frame = CGRectMake(barX, barY, self.width - barX - boxX - self.barWidth, timeY - barY - self.barWidth);
    self.left.frame = CGRectMake(boxX + 2, boxY, self.width, timeY - boxY);
}
@end
