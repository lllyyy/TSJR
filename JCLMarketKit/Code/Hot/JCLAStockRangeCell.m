//
//  JCLAStockRangeCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/12.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLAStockRangeCell.h"

@interface JCLAStockRangeCell()
@property(nonatomic, weak) JCLChartPath *box;
@property(nonatomic, weak) JCLChartPath *bar;

@property(nonatomic, weak) JCLChartScale *left;
@property(nonatomic, weak) JCLChartScale *time;
@property(nonatomic, weak) JCLChartScale *key;
@property(nonatomic, weak) JCLChartScale *key1;
@property(nonatomic, weak) JCLChartScale *key2;

@property(nonatomic, assign) BOOL isBox;
@property(nonatomic, assign) CGFloat barWidth;

@property(nonatomic, strong) NSMutableArray *keyArrM;
@end

@implementation JCLAStockRangeCell

+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style{
    static NSString *ID = @"AStockRangeCell";
    JCLAStockRangeCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLAStockRangeCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(NSMutableArray *)keyArrM{ if (_keyArrM) return _keyArrM; return _keyArrM = [[NSMutableArray alloc]init]; }
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        JCLChartPath *box = [[JCLChartPath alloc]init]; [self addSubview:box];
        box.boxNumH = 0; box.boxNumV = 0; box.boxW = 1.4; box.boxCol = JCLRGBA(233, 233, 233, 1); box.isDash = YES;
        box.style = JCLChartPathBox;
        self.box = box; self.barWidth = box.boxW;
    }
    return self;
}

-(void)setArr:(NSArray *)arr{
    _arr = arr;
    [self.bar removeFromSuperview]; [self.left removeFromSuperview]; [self.time removeFromSuperview];
    [self.key removeFromSuperview]; [self.key1 removeFromSuperview]; [self.key2 removeFromSuperview];
    [JCLKitObj JCLRemoveKit:self.keyArrM];
    
    if (!self.keyArrM.count) {
        NSMutableArray *arrM = [[NSMutableArray alloc]init];
        NSMutableArray *keyArrM1 = [[NSMutableArray alloc]init];
        NSMutableArray *keyArrM2 = [[NSMutableArray alloc]init];
        __block NSInteger middle = 0.5*(arr.count-2);
        [arr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arrM addObject:@[obj]];
            if (idx > 0 && idx < arr.count - 1) {
                if (idx < 0.5*(arr.count-2)) {
                    [keyArrM1 addObject:[NSString stringWithFormat:@"%ld", middle]]; middle-=1;
                } else {
                    if (middle != 0) {
                        [keyArrM2 addObject:[NSString stringWithFormat:@"%ld", middle]];
                    }
                    middle-=1;
                }
            }
        }];
        
        
        NSInteger min = 0; // [[arr valueForKeyPath:@"@min.floatValue"] floatValue];
        NSInteger max = [[arr valueForKeyPath:@"@max.floatValue"] floatValue];
        max = max+0.1*(max-min);
        NSArray *rangeArr = @[[NSString stringWithFormat:@"%ld", max],
                              [NSString stringWithFormat:@"%ld", (max-min)/2],
                              [NSString stringWithFormat:@"%ld", min]];
        self.left = [self InitScale:rangeArr style:JCLChartScaleLineV alignment:NSTextAlignmentLeft];
        self.left.size = 11; self.left.color = JCLRGBA(188, 188, 188, 1);
        
        JCLChartPath *bar = [[JCLChartPath alloc]init]; [self addSubview:bar];
        bar.minVal = [NSString stringWithFormat:@"%ld", (long)min], bar.maxVal = [NSString stringWithFormat:@"%ld", (long)max];
        bar.style = JCLChartPathBar;
        bar.barSpac = 0; bar.barWS = 0.66;
        bar.pointCols = @[JCLRGBA(243, 78, 88, 1), JCLRGBA(173, 173, 173, 1), JCLRGBA(28, 185, 113, 1)];
        bar.isLRBar = YES;
        bar.pointArr = arrM;
        __block NSInteger idx = 0;
        __weak typeof(bar)barObj = bar;
        bar.pathPointBlock = ^(CGFloat x, CGFloat y){
            if (idx > arr.count-1) { return ; }
            
            UILabel *info = [JCLKitObj JCLLable:barObj font:7 color:JCLRGBA(188, 188, 188, 1) alignment:1];
            info.text = [NSString stringWithFormat:@"%@", arrM[idx][0]];
            CGSize size = [JCLKitObj JCLTextSize:info.text font:info.font];
            info.frame = CGRectMake(x - 0.5*size.width, y - size.height, size.width, size.height);
            idx += 1;
        };
        self.bar = bar;
        
        NSArray *keyArr = @[@"涨停", @"跌停"];
        self.time = [self InitScale:keyArr style:JCLChartScaleBoxV alignment:NSTextAlignmentCenter];
        self.time.textCols = @[JCLRGBA(243, 78, 88, 1), JCLRGBA(28, 185, 113, 1)];
        
        self.key = [self InitScale:@[@"0"] style:JCLChartScaleBoxH alignment:NSTextAlignmentCenter];
        self.key.color = JCLRGBA(173, 173, 173, 1);
        
        self.key1 = [self InitScale:keyArrM1 style:JCLChartScaleBoxH alignment:NSTextAlignmentCenter];
        self.key1.color = JCLRGBA(243, 78, 88, 1);
        
        self.key2 = [self InitScale:keyArrM2 style:JCLChartScaleBoxH alignment:NSTextAlignmentCenter];
        self.key2.color = JCLRGBA(28, 185, 113, 1);
        
        [self.keyArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *info = [JCLKitObj JCLButton:self img:@"" size:13 target:self action:nil];
            info.title = obj; info.color = self.bar.pointCols[idx];
            [self.keyArrM addObject:info];
        }];
    }
}

-(JCLChartScale *)InitScale:(NSArray *)arr style:(JCLChartScaleStyle)style alignment:(NSInteger)alignment{
    JCLChartScale *scale = [[JCLChartScale alloc]init]; [self addSubview:scale];
    scale.style = style; scale.alignment = alignment;
    scale.size = 9; scale.idxArr = arr;
    return scale;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat keyW = 0.7*self.width, keyX = 0.5*(self.width - keyW), keyH = 34, w = keyW/3;
    [self.keyArrM enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(keyX + idx*w, self.height-keyH - 6, w, keyH);
    }];
    
    CGFloat boxX = 14, boxY = 14;
    CGSize size = [JCLKitObj JCLTextSize:@"44" font:[JCLKitObj JCLFont:12]];
    CGFloat timeY = self.height - size.height - keyH - 6;
    self.time.frame = CGRectMake(boxX, timeY, self.width - 2*boxX, size.height);
    
    self.box.frame = CGRectMake(boxX, boxY, self.width - 2*boxX, timeY - boxY);
    if (self.isBox == NO) {
        self.box.borderState = JCLChartPathBorderLeft;
        self.box.borderState = JCLChartPathBorderBottom;
        self.isBox = YES;
    }
    
    CGFloat barY = self.box.y + self.barWidth;
    self.bar.frame = CGRectMake(boxX + 12, barY, self.box.width - 24, self.box.height - 2*self.barWidth);
    self.key.frame = CGRectMake(self.bar.x + 12, timeY, self.bar.width - 24, size.height);
    self.key1.frame = CGRectMake(self.bar.x + 12, timeY, (self.bar.width - 24)/2 - 17, size.height);
    self.key2.frame = CGRectMake(self.self.key1.maxX + 34, timeY, (self.bar.width - 24)/2 - 17, size.height);
    self.left.frame = CGRectMake(boxX + 2, boxY, self.width, timeY - boxY);
}
@end
