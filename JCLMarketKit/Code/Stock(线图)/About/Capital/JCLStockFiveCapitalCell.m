//
//  JCLStockFiveCapitalCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/29.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockFiveCapitalCell.h"

@interface JCLStockFiveCapitalCell()
@property(nonatomic, weak) UILabel *title;
@property(nonatomic, weak) JCLChartPath *box;
@property(nonatomic, weak) JCLChartPath *bar;

@property(nonatomic, weak) JCLChartScale *time;
@property(nonatomic, assign) BOOL isBox;
@property(nonatomic, assign) CGFloat barWidth;
@property(nonatomic, strong) NSMutableArray *keyArrM;
@end

@implementation JCLStockFiveCapitalCell
+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style{
    static NSString *ID = @"FiveCapitalCell";
    JCLStockFiveCapitalCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLStockFiveCapitalCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCL_Cell_COL;
        JCLChartPath *box = [[JCLChartPath alloc]init]; [self addSubview:box];
        box.boxNumH = 1; box.boxNumV = 0; box.boxW = 1; box.boxCol = JCLRGBA(233, 233, 233, 1);
        box.style = JCLChartPathBox;
        self.box = box; self.barWidth = box.boxW;
        
        self.title = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:1]; self.title.text = @"近五日资金流向";
        NSArray *colors = @[JCLRGBA(242, 79, 88, 1), JCLRGBA(28, 185, 113, 1)];
        NSArray *keyArr = @[[NSString stringWithFormat:@"● 资金流入"], [NSString stringWithFormat:@"● 资金流出"]];
        [keyArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *info = [JCLKitObj JCLButton:self img:@"" size:15 target:self action:nil];
            info.title = obj; info.color = colors[idx];
            [self.keyArrM addObject:info];
        }];
    }
    return self;
}

-(NSMutableArray *)keyArrM{ if (_keyArrM) return _keyArrM; return _keyArrM = [[NSMutableArray alloc]init]; }
-(void)setValArr:(NSArray *)valArr{
    _valArr = valArr;
    if (valArr.count && self.time == nil) {
        JCLChartPath *bar = [[JCLChartPath alloc]init]; [self addSubview:bar];
        bar.style = JCLChartPathBar;
        bar.barSpac = 0; bar.barWS = 0.6; bar.isUpDownBar = YES; bar.minVal = @"0";
        bar.pointArr = valArr;
        
        __block NSInteger idx = 0;
        __weak typeof(bar)barObj = bar;
        bar.pathPointBlock = ^(CGFloat x, CGFloat y){
            if (idx > valArr.count-1) { return ; }
            UILabel *info = [JCLKitObj JCLLable:barObj font:9 color:JCL_Text_COL alignment:1];
            NSString *val = valArr[idx][0];
            info.text = [JCLMarketObj JCLMarketUnit:[NSString stringWithFormat:@"%f", fabs(val.floatValue)] decimal:@"" style:1];
            CGSize size = [JCLKitObj JCLTextSize:info.text font:info.font];
            CGFloat infoY = val.floatValue > 0 ? y - size.height - 2 : y + size.height - 10;
            info.frame = CGRectMake(x - 0.5*size.width, infoY, size.width, size.height);
            idx += 1;
        };
        self.bar = bar;
        
        self.time = [self InitScale:self.timeArr style:JCLChartScaleBoxH alignment:NSTextAlignmentCenter];
    }
}

-(JCLChartScale *)InitScale:(NSArray *)arr style:(JCLChartScaleStyle)style alignment:(NSInteger)alignment{
    JCLChartScale *scale = [[JCLChartScale alloc]init]; [self addSubview:scale];
    scale.style = style; scale.alignment = alignment;
    scale.size = 11; scale.idxArr = arr;
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
    self.time.frame = CGRectMake(2*boxX, timeY + 2, self.width - 4*boxX, size.height);
    
    self.title.frame = CGRectMake(0, boxY, self.width, size.height);
    CGFloat chartY = self.title.maxY + boxY;
    self.box.frame = CGRectMake(boxX, chartY, self.width - 2*boxX, timeY - chartY);
    if (self.isBox == NO) {
        self.box.borderState = JCLChartPathBorderBottom;
        self.isBox = YES;
    }
    
    CGFloat barY = self.box.y + self.barWidth;
    self.bar.frame = CGRectMake(self.time.x, barY + 20, self.time.width - 2*self.barWidth, self.box.height - 2*self.barWidth - 2*20);
}
@end
