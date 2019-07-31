//
//  JCLStockRankHistoryCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/17.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockRankHistoryCell.h"

@interface JCLStockRankHistoryCell()
@property(nonatomic, weak) JCLChartPath *box;
@property(nonatomic, weak) JCLChartPath *rangeBar;
@property(nonatomic, weak) JCLChartPath *scaleBar;

@property(nonatomic, weak) JCLChartScale *left;
@property(nonatomic, weak) JCLChartScale *right;
@property(nonatomic, weak) JCLChartScale *time;

@property(nonatomic, assign) BOOL isBox;
@property(nonatomic, assign) CGFloat barWidth;

@property(nonatomic, strong) NSMutableArray *keyArrM;
@end

@implementation JCLStockRankHistoryCell
+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style{
    static NSString *ID = @"RankHistoryCell";
    JCLStockRankHistoryCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLStockRankHistoryCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSLog(@"");
    return cell;
}

-(NSMutableArray *)keyArrM{ if (_keyArrM) return _keyArrM; return _keyArrM = [[NSMutableArray alloc]init]; }
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.info = [JCLKitObj JCLLable:self font:14 color:JCLRGB(188, 188, 188) alignment:2];
        NSArray *arr = @[@"● 平均涨幅", @"● 平均跌幅", @"● 上涨概率"];
        NSArray <UIColor *>*colorArr=@[JCLRGB(242, 72, 85),JCLRGB(27, 191, 96),JCLRGB(254, 206, 0)];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *info = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:nil];
            
            NSString *str=arr[idx];
            NSMutableAttributedString *attributedStr=[[NSMutableAttributedString alloc]initWithString:str];
            [attributedStr addAttribute:NSForegroundColorAttributeName value:colorArr[idx] range:NSMakeRange(0, 1)];
            [attributedStr addAttribute:NSForegroundColorAttributeName value:JCLRGB(188, 188, 188) range:NSMakeRange(1, str.length-1)];
            [info setAttributedTitle:attributedStr forState:UIControlStateNormal];
            [self.keyArrM addObject:info];
        }];
        
        JCLChartPath *box = [[JCLChartPath alloc]init]; [self addSubview:box];
        box.boxNumH = 0; box.boxNumV = 0; box.boxW = 1.4; box.boxCol = JCLBGRGB; box.isDash = YES;
        box.style = JCLChartPathBox;
        box.minVal=@"0";
        self.box = box; self.barWidth = box.boxW;
    }
    return self;
}

-(void)setScaleArr:(NSArray *)scaleArr{
    _scaleArr = scaleArr;
    NSMutableArray *array=[NSMutableArray arrayWithCapacity:0];
    for (NSInteger i=0;i<scaleArr.count;i++){
        array[i]=[NSString stringWithFormat:@"%.2lf",fabs([self.rangeArr[i] doubleValue])];
    }
    [self.rangeBar removeFromSuperview]; [self.scaleBar removeFromSuperview]; [self.left removeFromSuperview];
    [self.right removeFromSuperview]; [self.time removeFromSuperview];
    if (scaleArr.count && self.rangeArr.count) {
        self.rangeBar = [self InitaBar:self.rangeArr color:JCLRGB(238, 74, 89) style:0];
        self.scaleBar = [self InitaBar:scaleArr color:JCLRGB(253, 205, 42) style:1];
        
        CGFloat leftMax = fabs([[array valueForKeyPath:@"@max.floatValue"] floatValue]);
        NSArray *leftArr = @[[NSString stringWithFormat:@"%.2lf", leftMax],
                             [NSString stringWithFormat:@"%.2lf", leftMax/2],
                             @"0.00"];
        self.left = [self InitScale:leftArr style:JCLChartScaleLineV alignment:NSTextAlignmentLeft];
        
        CGFloat rightMax = [[scaleArr valueForKeyPath:@"@max.floatValue"] floatValue]*100;
        NSArray *rightArr = @[[NSString stringWithFormat:@"%.2lf", rightMax],
                              [NSString stringWithFormat:@"%.2lf", rightMax/2],
                              @"0.00"];
        self.right = [self InitScale:rightArr style:JCLChartScaleLineV alignment:NSTextAlignmentRight];
        
        NSArray *keyArr = @[@"1日", @"3日", @"5日", @"10日"];
        self.time = [self InitScale:keyArr style:JCLChartScaleBoxH alignment:NSTextAlignmentCenter];
    }
}

-(JCLChartPath *)InitaBar:(NSArray *)arr color:(UIColor *)color style:(NSInteger)style{
    JCLChartPath *bar = [[JCLChartPath alloc]init]; [self addSubview:bar];
    bar.style = JCLChartPathBar;
    bar.barSpac = 0; bar.barWS = 0.4;
    bar.minVal=@"0";
    bar.pointCol = color; bar.lossCol = JCLRGB(42, 188, 100);
    NSMutableArray *arrM = [[NSMutableArray alloc]init];
    [arr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        style == 0 ? [arrM addObject:@[obj, @""]] : [arrM addObject:@[@"", obj]];
    }];
    bar.pointArr = arrM;
    return bar;
}

-(JCLChartScale *)InitScale:(NSArray *)arr style:(JCLChartScaleStyle)style alignment:(NSInteger)alignment{
    JCLChartScale *scale = [[JCLChartScale alloc]init]; [self addSubview:scale];
    scale.style = style; scale.alignment = alignment;
    scale.size = 11; scale.color = JCLRGB(188, 188, 188);
    scale.idxArr = arr;
    return scale;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat boxX = 14, boxY = 14;
    
    CGFloat infoW = 0.28*self.width, infoH = 40;
    self.info.frame = CGRectMake(0, 6, infoW, infoH);
    CGFloat keyW = self.width - infoW - boxX, w = keyW/self.keyArrM.count;
    [self.keyArrM enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(self.info.maxX + idx*w, 6, w, infoH);
    }];
    
    CGSize size = [JCLKitObj JCLTextSize:@"44" font:[JCLKitObj JCLFont:13]];
    CGFloat timeY = self.height - size.height - boxY;
    self.time.frame = CGRectMake(boxX, timeY, self.width - 2*boxX, size.height);
    
    self.box.frame = CGRectMake(boxX, boxY + infoH, self.width - 2*boxX, timeY - boxY - infoH);
    if (self.isBox == NO) {
        self.box.borderState = JCLChartPathBorderLeft;
        self.box.borderState = JCLChartPathBorderRight;
        self.box.borderState = JCLChartPathBorderBottom;
        self.isBox = YES;
    }
    
    CGFloat barX = self.box.x + self.barWidth;
    self.rangeBar.frame = CGRectMake(barX, self.box.y, self.width - barX - boxX - self.barWidth, self.box.height - self.barWidth);
    self.scaleBar.frame = CGRectMake(barX, self.box.y, self.width - barX - boxX - self.barWidth, self.box.height - self.barWidth);
    self.left.frame = CGRectMake(boxX + 2, self.box.y, self.width, self.box.height);
    self.right.frame = CGRectMake(self.rangeBar.x, self.box.y, self.rangeBar.width - 2, self.box.height);
}
@end
