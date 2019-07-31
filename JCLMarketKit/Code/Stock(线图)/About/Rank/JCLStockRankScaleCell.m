//
//  JCLStockRankScaleCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/14.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockRankScaleCell.h"

@interface JCLStockRankScaleCell()
@property(nonatomic, strong) JCLChartPath *ring;
@property(nonatomic, strong) NSMutableArray *arrM;
@property(nonatomic, strong) NSMutableArray *keyArrM;
@property(nonatomic, strong) NSMutableArray *valArrM;
@end

@implementation JCLStockRankScaleCell
+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style{
    static NSString *ID = @"RankScaleCell";
    JCLStockRankScaleCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLStockRankScaleCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(NSMutableArray *)arrM{ if (_arrM) return _arrM; return _arrM = [[NSMutableArray alloc]init]; }
-(NSMutableArray *)keyArrM{ if (_keyArrM) return _keyArrM; return _keyArrM = [[NSMutableArray alloc]init]; }
-(NSMutableArray *)valArrM{ if (_valArrM) return _valArrM; return _valArrM = [[NSMutableArray alloc]init]; }
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setValArr:(NSArray *)valArr{
    _valArr = valArr;
    if (!self.arrM.count) {
        
        NSArray *colorArr = @[JCLRGBA(250, 163, 69, 1), JCLRGBA(238, 74, 89, 1), JCLRGBA(42, 188, 100, 1)];
        [self.arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIColor *color = colorArr[idx];
            if (idx > 0) {
                color = [JCLMarketObj JCLMarketColor:self.valArr[idx] close:@"0"];
            }
            
            JCLChartPath *ring = [[JCLChartPath alloc]init]; [self addSubview:ring];
            ring.style = JCLChartPathRing; ring.ringW = 4;
            ring.ringBgCol = JCLBGRGB; ring.ringValCol = color;
            ring.ringEndVal = [obj floatValue];
            [self.arrM addObject:ring];
            
            UILabel *key = [JCLKitObj JCLLable:self font:13 color:JCLRGBA(174, 174, 174, 1) alignment:NSTextAlignmentCenter]; key.text = self.keyArr[idx];
            [self.keyArrM addObject:key];
            
            UILabel *val = [JCLKitObj JCLLable:ring font:14 color:color alignment:NSTextAlignmentCenter]; val.text = self.valArr[idx];
            [self.valArrM addObject:val];
        }];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    NSArray *arr = self.arrM;
    CGFloat w = self.width/arr.count, h = 0.2*self.width, y = 0.5*(self.height - h - 20);
    [self.arrM enumerateObjectsUsingBlock:^(JCLChartPath *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(idx*w, y, w, self.height - 2*y - 20);
    }];
    
    [self.keyArrM enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGSize size = [JCLKitObj JCLTextSize:obj.text font:obj.font];
        obj.frame = CGRectMake(idx*w, y+h + 8, w, size.height);
    }];
    
    [self.valArrM enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(0, 0, w, h);
    }];
}

@end
