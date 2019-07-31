//
//  JCLKLineChart.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/5/26.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLKLineChart.h"

#import "YGPopList.h"

@interface JCLKLineChart()<UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIView *MABg;
@property (nonatomic, strong) NSMutableArray *MAArrM;
@property (nonatomic, weak) JCLChartPath *MABox;
@property (nonatomic, weak) JCLChartPath *kLine;
@property (nonatomic, weak) JCLChartPath *MALine;
@property (nonatomic, weak) UILabel *maxLab;
@property (nonatomic, weak) UILabel *minLab;

@property (nonatomic, weak) UIView *idxBg;
@property (nonatomic, strong) NSMutableArray *idxArrM;
@property (nonatomic, weak) JCLChartPath *idxBox;
@property (nonatomic, weak) JCLChartPath *idxLine;
@property (nonatomic, weak) JCLChartPath *idxVol;
@property (nonatomic, weak) JCLChartPath *idxMacd;
@property (nonatomic, weak) UILabel *idxLab;

@property (nonatomic, assign) CGFloat boxS;
@property (nonatomic, assign) CGFloat pathS;
@property (nonatomic, assign) CGFloat pathC;
@property (nonatomic, assign) CGFloat pathW;

@property (nonatomic, assign) CGFloat pathIdx;
@property (nonatomic, strong) NSArray *splArr;
@property (nonatomic, strong) NSArray *splMAArr;
@property (nonatomic, strong) NSArray *splIdxArr;

@property(nonatomic,assign)CGFloat min;    @property(nonatomic,assign)CGFloat max;
@property(nonatomic,assign)CGFloat MAMin;    @property(nonatomic,assign)CGFloat MAMax;
@property(nonatomic,assign)CGFloat volMin;    @property(nonatomic,assign)CGFloat volMax;

@property(nonatomic,weak)JCLChartScale *MARange;    @property(nonatomic,weak)JCLChartScale *idxRange;

@property(nonatomic,weak)UIView *XLine;   @property(nonatomic,weak)UIView *YLine;    @property(nonatomic,weak)UILabel *time;
@property(nonatomic, assign) CGFloat pointX;

@property(nonatomic, assign) NSInteger idx;

@property(nonatomic, strong) NSMutableArray *draws; // 存放绘制的线
@property (nonatomic, weak) UIImageView *icon; // 绘制图标
@property (nonatomic, assign) CGPoint beginPoint;
@property (nonatomic, assign) CGPoint endPoint;
@property (nonatomic, weak) CAShapeLayer *lineLayer; // 长按是否结束;
@property (nonatomic, weak) UIView *view;

@property (nonatomic, strong) NSArray *tests;
@end

@implementation JCLKLineChart
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) { self.backgroundColor = JCL_Cell_COL;
        self.boxS = 1;
        self.MABg = [JCLKitObj JCLView:self color:[UIColor clearColor]];
        self.MABox = [self drawPathBox:2 v:3];
        self.idxBg = [JCLKitObj JCLView:self color:[UIColor clearColor]];
        self.idxBox = [self drawPathBox:1 v:3];
    } return self;
}

-(JCLChartPath *)drawPathBox:(CGFloat)h v:(CGFloat)v{
    JCLChartPath *box = [[JCLChartPath alloc]init]; [self addSubview:box];
    box.boxNumH = h; box.boxNumV = v; box.boxW = self.boxS; box.boxCol = JCL_Line_COL; box.isDash = YES;
    box.style = JCLChartPathBox;
    box.layer.borderWidth = self.boxS, box.layer.borderColor = box.boxCol.CGColor;
    return box;
}

-(void)setArr:(NSArray *)arr{
    _arr = arr;
    if (arr.count) {
        if (self.isPage) { self.pathIdx = self.arr.count - self.idx; self.isPage = NO;
        } else if (self.isIdx){
        } else { self.pathIdx = self.arr.count >= self.pathC ? self.arr.count - self.pathC : 0; }
        [self needsDisplay];
    }
}

-(void)InitMAKlineVal{
    if (self.arr.count <= self.pathC) {
        self.splArr = self.arr; self.splMAArr = self.MAArr; self.splIdxArr = self.idxArr;
    } else {
        self.splArr = [self.arr objectsAtIndexes:[[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(self.pathIdx, self.pathC)]];
        self.splMAArr = [self.MAArr objectsAtIndexes:[[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(self.pathIdx, self.pathC)]];
        self.splIdxArr = [self.idxArr objectsAtIndexes:[[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(self.pathIdx, self.pathC)]];
    }
    
    NSMutableArray *heightArr = [[NSMutableArray alloc]init]; NSMutableArray *lowArr = [[NSMutableArray alloc]init];
    NSMutableArray *volArr = [[NSMutableArray alloc]init];
    [self.splArr enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"splArr %@",obj);
        
        [heightArr addObject:obj[3]]; [lowArr addObject:obj[4]]; [volArr addObject:obj[6]];
    }];
    self.MAMax = [[heightArr valueForKeyPath:@"@max.floatValue"] floatValue]; self.max = self.MAMax;
    self.MAMin = [[lowArr valueForKeyPath:@"@min.floatValue"] floatValue]; self.min = self.MAMin;
    NSArray *MAArr = [self InitMAVal:self.splMAArr];
    if (MAArr.count) {
        self.MAMax = self.MAMax > [MAArr[0] floatValue] ? self.MAMax : [MAArr[0] floatValue];
        self.MAMin = self.MAMin < [MAArr[1] floatValue] ? self.MAMin : [MAArr[1] floatValue];
    }
    if (self.MAMax == self.MAMin) { self.MAMax = self.MAMax+1; }
    
    self.volMax = [[volArr valueForKeyPath:@"@max.floatValue"] floatValue]; self.volMin = 0;
    if (self.idxStyle == IdxStyleOfVOL) {
        NSArray *idxArr = [self InitMAVal:self.splIdxArr];
        if (idxArr.count) {
            self.volMax = self.volMax > [idxArr[0] floatValue] ? self.volMax : [idxArr[0] floatValue];
        }
    }
}

-(NSArray *)InitMAVal:(NSArray *)arr{
    NSMutableArray *MA5Arr = [[NSMutableArray alloc]init]; NSMutableArray *MA10Arr = [[NSMutableArray alloc]init];
    NSMutableArray *MA20Arr = [[NSMutableArray alloc]init];
    [arr enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL *stop) {
        if (![obj[0] isEqualToString:@""]) { [MA5Arr addObject:obj[0]]; }
        if (![obj[1] isEqualToString:@""]) { [MA10Arr addObject:obj[1]]; }
        if (![obj[2] isEqualToString:@""]) { [MA20Arr addObject:obj[2]]; }
    }];
    
    CGFloat MA5Max = [[MA5Arr valueForKeyPath:@"@max.floatValue"] floatValue], MA5Min = [[MA5Arr valueForKeyPath:@"@min.floatValue"] floatValue];
    CGFloat MA10Max = [[MA10Arr valueForKeyPath:@"@max.floatValue"] floatValue], MA10Min = [[MA10Arr valueForKeyPath:@"@min.floatValue"] floatValue];
    CGFloat MA20Max = [[MA20Arr valueForKeyPath:@"@max.floatValue"] floatValue], MA20Min = [[MA20Arr valueForKeyPath:@"@min.floatValue"] floatValue];
    if (MA10Max != 0 && MA10Min != 0) { MA20Max = MA20Max > MA10Max ? MA20Max : MA10Max; MA20Min = MA20Min < MA10Min ? MA20Min : MA10Min; }
    if (MA5Max != 0 && MA5Min != 0) { MA20Max = MA20Max > MA5Max ? MA20Max : MA5Max; MA20Min = MA20Min < MA5Min ? MA20Min : MA5Min; }
    return MA20Max != 0 && MA20Min != 0 ? @[[NSString stringWithFormat:@"%lf", MA20Max], [NSString stringWithFormat:@"%lf", MA20Min]] : nil;
}

-(void)InitKline{
    [self InitMAKlineVal];
    [self.kLine removeFromSuperview]; [self.MALine removeFromSuperview]; [self.idxVol removeFromSuperview]; [self.idxLine removeFromSuperview];
    [self.idxMacd removeFromSuperview]; [self.minLab removeFromSuperview]; [self.maxLab removeFromSuperview]; [self.idxLab removeFromSuperview];
    self.kLine = [self drawPathKline:self.MABox arr:self.splArr];
    self.MALine = [self drawPathBroken:self.MABox arr:self.splMAArr isIdx:YES];
    self.idxLab = [JCLKitObj JCLLable:self.idxBg font:11 color:JCL_Text_COL alignment:0];
    
    switch (self.idxStyle) {
        case IdxStyleOfVOL: self.idxVol = [self drawPathVol:self.idxBox arr:self.splArr]; break;
        case IdxStyleOfMACD: self.idxMacd = [self drawPathMacd:self.idxBox arr:self.splIdxArr];
            break;
        default: break;
    }
    
    self.idxLine = [self drawPathBroken:self.idxBox arr:self.splIdxArr isIdx:NO];
}

-(NSMutableArray *)MAArrM{ if (_MAArrM) return _MAArrM; return _MAArrM = [[NSMutableArray alloc]init]; }
-(NSMutableArray *)idxArrM{ if (_idxArrM) return _idxArrM; return _idxArrM = [[NSMutableArray alloc]init]; }
-(void)InitIdxVal:(NSInteger)index{
    if(index<0){
        return;
    }
    if (!self.MAArrM.count) {
        NSArray *MACols = @[JCLHexCol(@"#D9AC8A"), JCLHexCol(@"#7A62B2"), JCLHexCol(@"#3F8FAD"), JCLHexCol(@"#DE492E")];
        [MACols enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.MAArrM addObject:[JCLKitObj JCLLable:self.MABg font:11 color:obj alignment:0]];
            [self.idxArrM addObject:[JCLKitObj JCLLable:self.idxBg font:11 color:obj alignment:0]];
        }];
    }
    
    NSArray *key = @[@"", @"MA5", @"MA10", @"MA20"];
    [self setupIdxVal:self.MAArrM key:key val:self.splMAArr[index]];
    switch (self.idxStyle) {
        case IdxStyleOfMACD:key = @[@"MACD(12,26,9) ", @"DIF", @"DEA", @"MACD"]; break;
        case IdxStyleOfKDJ: key = @[@"KDJ(3,3,9)   ", @"K", @"D", @"J"]; break;
        case IdxStyleOfCCI: key = @[@"", @"CCI(14)"]; break;
        case IdxStyleOfRSI: key = @[@"RSI(6,12,24) ", @"RSI1", @"RSI2", @"RSI3"]; break;
        case IdxStyleOfPSY: key = @[@"PSY(6,12) ", @"PSY", @"RSYMA"]; break;
        case IdxStyleOfWR : key = @[@"WR(10,6) ", @"WR1", @"WR2"]; break;
        case IdxStyleOfASI: key = @[@"ASI(6) ", @"ASI", @"MASI"]; break;
        case IdxStyleOfOBV: key = @[@"OBV(30) ", @"OBV", @"MAOBV"]; break;
        case IdxStyleOfROC: key = @[@"ROC(6,12) ", @"ROC", @"MAROC"]; break;
        case IdxStyleOfVR:  key = @[@"VR(6,25) ", @"VR", @"MAVR"]; break;
        case IdxStyleOfDMI: key = @[@"DMI(6,14) ", @"PDI", @"MDI",@"ADX",@"ADXR"]; break;
        case IdxStyleOfDMA: key = @[@"DMA(10,10,50) ", @"DIF", @"AMA"]; break;
        case IdxStyleOfFSL: key = @[@"FSL ", @"SWL", @"SWS"]; break;
        case IdxStyleOfTRIX:key = @[@"TRIX(9,12) ", @"TRIX", @"MATRIX"]; break;
        case IdxStyleOfBRAR:key = @[@"BRAR(26) ", @"BR", @"AR"]; break;
        case IdxStyleOfCR:  key = @[@"CR(26,10,20,40,62) ", @"CR", @"MA1",@"MA2",@"MA3",@"MA4"]; break;
        case IdxStyleOfEMV: key = @[@"EMV(9,14) ", @"EMV", @"MAEMV"]; break;
        case IdxStyleOfWVAD:key = @[@"WVAD(6,24) ", @"WVAD", @"MAWVAD"]; break;
        case IdxStyleOfMTM: key = @[@"MTM(6,12) ", @"MTM", @"MTMMA"]; break;
        case IdxStyleOfBOLL:key = @[@"BOLL(20) ", @"MID", @"UPPER",@"LOWER"]; break;
        default: break;
    }
    [self setupIdxVal:self.idxArrM key:key val:self.splIdxArr[index]];
}

-(void)setupIdxVal:(NSArray *)arr key:(NSArray *)key val:(NSArray *)val{
    if(!key.count || !arr.count || !val.count){
        return;
    }
    self.idxLab.text = key[0];
    CGSize size = [JCLKitObj JCLStrSize:self.idxLab.text font:self.idxLab.font];
    self.idxLab.frame = CGRectMake(0, 0, size.width, self.idxBg.height);
    __block CGFloat x = size.width;
    [arr enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL *stop) {
        if (val.count>idx) {
            if(key.count<idx+1) return;
            obj.text = [NSString stringWithFormat:@"%@: %@", key[idx+1], [JCLMarketObj JCLMarketUnit:val[idx] decimal:self.decimal style:1]];
            CGSize size = [JCLKitObj JCLStrSize:obj.text font:obj.font];
            obj.frame = CGRectMake(x, 0, size.width, self.idxBg.height);
            x = x + size.width + 10;
        } else {
            obj.text = @"";
        }
    }];
}

-(JCLChartPath *)drawPathKline:(UIView *)parent arr:(NSArray *)arr{
    JCLChartPath *kline = [[JCLChartPath alloc]init]; [parent addSubview:kline];
    CGFloat s = self.boxS; kline.frame = CGRectMake(s, s, parent.width-2*s, parent.height-2*s);
    kline.pathW = self.pathW; kline.pathS = self.pathS;
    kline.min = self.min; kline.max = self.max;
    kline.minVal = [NSString stringWithFormat:@"%lf", self.MAMin], kline.maxVal = [NSString stringWithFormat:@"%f", self.MAMax];
    kline.style = JCLChartPathKline;
    kline.pointArr = arr;
    return kline;
}

-(JCLChartPath *)drawPathVol:(UIView *)parent arr:(NSArray *)arr{
    JCLChartPath *vol = [[JCLChartPath alloc]init]; [parent addSubview:vol];
    CGFloat s = self.boxS; vol.frame = CGRectMake(s, s, parent.width-2*s, parent.height-2*s);
    vol.pathW = self.pathW; vol.pathS = self.pathS;
    vol.minVal = [NSString stringWithFormat:@"%lf", self.volMin], vol.maxVal = [NSString stringWithFormat:@"%f", self.volMax];
    vol.style = JCLChartPathVol;
    NSLog(@"arrarr %@",arr);
    vol.pointArr = arr;
    return vol;
}

-(JCLChartPath *)drawPathBroken:(UIView *)parent arr:(NSArray *)arr isIdx:(BOOL)isIdx{
    JCLChartPath *broken = [[JCLChartPath alloc]init]; [parent addSubview:broken];
    CGFloat s = self.boxS; broken.frame = CGRectMake(s, s, parent.width-2*s, parent.height-2*s);
    broken.style = JCLChartPathBroken; broken.pathW = self.pathW; broken.pathS = self.pathS; broken.pointW = 1;
    if (isIdx) { broken.minVal = [NSString stringWithFormat:@"%lf", self.MAMin], broken.maxVal = [NSString stringWithFormat:@"%f", self.MAMax]; }
    if (self.idxStyle == IdxStyleOfVOL && !isIdx) { broken.maxVal = [NSString stringWithFormat:@"%f", self.volMax]; broken.minVal = @"0"; }
    if (self.idxStyle == IdxStyleOfMACD && !isIdx) { broken.isMacd = YES; }
    broken.pointCols = @[JCLHexCol(@"#D9AC8A"), JCLHexCol(@"#7A62B2"), JCLHexCol(@"#3F8FAD"), JCLHexCol(@"#DE492E")];
    broken.pointArr = arr;
    broken.animaActionBlock = ^(){
        [self InitRangeVal];
    };
    return broken;
}

-(JCLChartPath *)drawPathMacd:(UIView *)parent arr:(NSArray *)arr{
    JCLChartPath *macd = [[JCLChartPath alloc]init]; [parent addSubview:macd];
    CGFloat s = self.boxS; macd.frame = CGRectMake(s, s, parent.width-2*s, parent.height-2*s);
    macd.style = JCLChartPathMacd; macd.pathW = self.pathW; macd.isMacd = YES;
    macd.pointArr = arr;
    return macd;
}

-(void)InitRangeVal{
    [self.MARange removeFromSuperview];  [self.idxRange removeFromSuperview];
    NSArray *MAArr = @[[JCLMarketObj JCLMarketPrice:self.MAMax decimal:self.decimal],
                       [JCLMarketObj JCLMarketPrice:0.5*(self.MAMax+self.MAMin) decimal:self.decimal],
                       [JCLMarketObj JCLMarketPrice:self.MAMin decimal:self.decimal]];
    self.MARange = [self InitScale:self.kLine arr:MAArr];
    
    NSArray *idxArr;
    NSString *max, *middle, *min;
    if (self.idxStyle == IdxStyleOfVOL){
        max = [NSString stringWithFormat:@" %lf", self.volMax];
        idxArr = @[[JCLMarketObj JCLMarketUnit:max decimal:self.decimal style:2], @""];
    } else {
        max = self.idxLine.maxVal; min = self.idxLine.minVal;
        middle = [NSString stringWithFormat:@" %.2lf", 0.5*(self.idxLine.maxVal.floatValue+self.idxLine.minVal.floatValue)];
        idxArr = @[[JCLMarketObj JCLMarketUnit:max decimal:self.decimal style:1], @"",
                   [JCLMarketObj JCLMarketUnit:min decimal:self.decimal style:1]];
    }
    self.idxRange = [self InitScale:self.idxLine arr:idxArr];
}

-(JCLChartScale *)InitScale:(UIView *)parent arr:(NSArray *)arr{
    JCLChartScale *scale = [[JCLChartScale alloc]init]; [parent addSubview:scale]; scale.frame = parent.frame;
    scale.style = JCLChartScaleLineV; scale.alignment = 0; scale.size = 8; scale.color = nil;
    scale.idxArr = arr;
    return scale;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.MABg.frame = CGRectMake(0, 0, self.width, 0.1*self.height);
    self.MABox.frame = CGRectMake(0, self.MABg.maxY, self.width, 0.56*self.height);
    
    self.idxBg.frame = CGRectMake(0, self.MABox.maxY, self.width, 0.1*self.height);
    self.idxBox.frame = CGRectMake(0, self.idxBg.maxY, self.width, 0.24*self.height);
    
    if (self.pathS < 1) { self.pathC = self.isScroll ? 90 : 50; }
    self.pathS = 1; self.pathW = (self.width-2 - self.pathS*(self.pathC-1)) / self.pathC;
}

-(void)setIsScroll:(BOOL)isScroll{
    _isScroll = isScroll;
    [self gestureRecognizer];
}

-(void)gestureRecognizer{
    UILongPressGestureRecognizer *longPress = [JCLKitObj RXLongPress:self target:self action:@selector(longAction:)];
    UITapGestureRecognizer *taps = [JCLKitObj RXTap:self target:self action:@selector(tapsAction:) number:2];
    [JCLKitObj RXPinch:self target:self action:@selector(pinchAction:)];
    if (self.isScroll) {
        UIPanGestureRecognizer *pan = [JCLKitObj RXPan:self target:self action:@selector(panAction:)];
        [pan requireGestureRecognizerToFail:longPress];
        [taps requireGestureRecognizerToFail:pan];
    }
}

-(void)longAction:(UILongPressGestureRecognizer*)sender{
    if (self.drawStyle==0) {
        CGPoint point = [sender locationInView:self];
        if(sender.state == UIGestureRecognizerStateBegan){
            self.XLine = [JCLKitObj JCLView:self color:JCL_Line_COL];
            self.time = [JCLKitObj JCLLable:self font:10 color:JCL_Text_COL alignment:1];
            self.time.backgroundColor = JCL_Line_COL; self.time.layer.cornerRadius = 4;
            [self drawCrossLine:point]; [self gestureNot:YES];
        } if (sender.state == UIGestureRecognizerStateChanged) {
            [self drawCrossLine:point];
        } else if (sender.state == UIGestureRecognizerStateEnded) {
            self.pathIdx >= self.arr.count - self.pathC ?  [self gestureNot:NO] : [self gestureNot:YES];
            if (!self.isScroll) { [self longNot:NO obj:@[]]; } !self.longActionBlock ? : self.longActionBlock(NO, @[]);
            [self.XLine removeFromSuperview]; [self.YLine removeFromSuperview]; [self.time removeFromSuperview];
        }
    }
}

-(void)drawCrossLine:(CGPoint)point{
    __block CGFloat pointX = 0.0; CGFloat wh = 1.2, y = self.MABox.y+1;
    [self.kLine.XYArr enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL *stop) {
        
        NSLog(@"oXYArrXYArrbj %@",obj);
        
        CGPoint objPoint = CGPointFromString([obj objectAtIndex:2]);
        pointX = objPoint.x;
        if (pointX == point.x || point.x-pointX <= self.pathW/2) {
            self.XLine.frame = CGRectMake(objPoint.x - 0.5*wh + 1, y, wh, self.height - y -1);
            self.YLine.frame = CGRectMake(0, y + objPoint.y - wh, self.kLine.width, wh);
            if (self.isMinute) {
                NSLog(@"-=self.time.text=--= %@", [JCLKitObj timeStampString:obj[5]]);
                NSString *val =  [[JCLKitObj timeStampString:obj[5]] substringWithRange:NSMakeRange(5, 5)];
                 NSLog(@"-valval--= %@", val);
               self.time.text =  [NSString stringWithFormat:@"%@",val];
            } else {
                 self.time.text =  [NSString stringWithFormat:@"%@",[self getDate:obj[5]]];
            }
            CGSize size = [JCLKitObj JCLTextSize:self.time.text font:self.time.font];
            CGFloat x = pointX < 0.5*self.width ? point.x + 2 : point.x - 1.4*size.width - 2;
            self.time.frame = CGRectMake(x, y, size.width, 1.4*size.height);
            [self InitIdxVal:idx];
            [self longNot:YES obj:obj]; !self.longActionBlock ? : self.longActionBlock(YES, obj);
            *stop = YES;
        }
    }];
}

-(NSString *)getDate:(NSString *)date{
    NSString *val = [[date substringToIndex:6] substringFromIndex:4];
    return [NSString stringWithFormat:@"%@-%@-%@", [date substringToIndex:4], val, [date substringFromIndex:6]];
}

-(void)longNot:(BOOL)isHave obj:(NSArray *)obj{
    NSDictionary *dic = @{@"isHave":[NSNumber numberWithBool:isHave], @"obj":obj};
    [[NSNotificationCenter defaultCenter] postNotificationName:KLineLongNot object:nil userInfo:dic];
}

-(void)panAction:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan translationInView:self];
    if (self.drawStyle==0) {
        if (pan.state == UIGestureRecognizerStateBegan) { [self gestureNot:YES];
        } if (pan.state == UIGestureRecognizerStateChanged) {
            CGFloat number = fabs(self.pointX - point.x)/(self.pathW+self.pathS);
            if (point.x > self.pointX) {
                self.pathIdx -= number; self.pathIdx = self.pathIdx < 0 ? 0 : self.pathIdx;
            } else {
                self.pathIdx += number; self.pathIdx = self.pathIdx > self.arr.count - self.pathC ? self.arr.count - self.pathC : self.pathIdx;
            }
            self.pointX = point.x; [self needsDisplay];
        } if (pan.state == UIGestureRecognizerStateEnded) { self.pointX = 0.00;
            if (self.pathIdx >= self.arr.count - self.pathC) {
                [self gestureNot:NO];
            } else {
                [self gestureNot:YES];
            }
        }
    }
}

-(void)pinchAction:(UIPinchGestureRecognizer *)pinch{
    if (pinch.state == UIGestureRecognizerStateBegan) { [self gestureNot:YES];
    } if (pinch.state == UIGestureRecognizerStateChanged) {
        NSInteger number = self.pathC;
        CGFloat scaleNum = 0.0;
        if (pinch.scale > 1) {
            if (self.pathC <= 20) { return; }
            scaleNum = number - 2; if (self.arr.count >= self.pathC) { self.pathIdx = self.pathIdx + number - scaleNum; }
        } else {
            if (self.pathC >= 200) { return; }
            scaleNum = number + 2; self.pathIdx = self.pathIdx - (scaleNum - number);
        }
        self.pathC = scaleNum; self.pathW = (self.kLine.width - self.pathS*(self.pathC - 1))/self.pathC;
        [self needsDisplay];
    } else if (pinch.state == UIGestureRecognizerStateEnded) {
        if (self.pathIdx >= self.arr.count - self.pathC) {
            [self gestureNot:NO];
        } else {
            [self gestureNot:YES];
        }
    }
}

-(void)needsDisplay{
    if (self.arr.count >= self.pathC && self.pathIdx <= 0) {
        if (!self.isPage) {
            self.idx = self.arr.count;
            !self.pageActionBlock ? : self.pageActionBlock();
            self.isPage = YES;
        }
    } else {
        [self InitKline];
        NSInteger idx = self.arr.count <= self.pathC ? self.arr.count-1 : self.pathC-1;
        [self InitIdxVal:idx];
    }
}

-(void)gestureNot:(BOOL)isHave{
    NSDictionary *dic = @{@"isHave":[NSNumber numberWithBool:isHave]};
    [[NSNotificationCenter defaultCenter] postNotificationName:KLineGestureNot object:nil userInfo:dic];
}

-(void)tapsAction:(UIGestureRecognizer*)tap{
    if (self.drawStyle==0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:KLinePushNot object:nil];
    }
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([gestureRecognizer.view isKindOfClass:[UITableView class]]) { return NO; } else { return YES; }
}
@end

