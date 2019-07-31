//
//  StockHeader.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/13/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "JCLStockHeader.h"
#import "JCLChartList.h"
#import "YSKitObj.h"

@interface JCLStockHeader()
@property (nonatomic, weak) UIView *rangeBg;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *range;
@property (nonatomic, strong) UILabel *scale;

@property (nonatomic, weak) UIView *stockBg;
@property (nonatomic, strong) NSMutableArray *arrM;

@property (nonatomic, strong) JCLChartList *chart;
@end

@implementation JCLStockHeader
- (NSMutableArray *)arrM{
    if (_arrM)
        return _arrM; return _arrM = [NSMutableArray array]; }
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JCL_Bg_COL;
        self.rangeBg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        self.price = [YSKitObj YSLable:self.rangeBg size:40 color:JCL_Text_COL alignment:2 style:0];
        self.range = [YSKitObj YSLable:self.rangeBg size:15 color:JCL_Text_COL alignment:0 style:0];
        self.scale = [YSKitObj YSLable:self.rangeBg size:15 color:JCL_Text_COL alignment:0 style:0];
        self.price.text = @"--"; self.range.text = @"--"; self.scale.text = @"--";
        
        self.stockBg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        for (NSInteger i = 0; i < 7; i++) {
            UILabel *lable = [YSKitObj YSLable:self.stockBg size:14 color:JCL_Text_COL alignment:0 style:1];
            lable.text = @"--";
            [self.arrM addObject:lable];
        }
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.rangeBg.frame = CGRectMake(0, 0, self.width, 0.17*self.height);
    CGSize rangeSize = [JCLKitObj JCLTextSize:self.range.text font:self.range.font];
    self.price.frame = CGRectMake(30, 0, 0.5*self.width, self.rangeBg.height);
//    self.price.backgroundColor = [UIColor redColor];
    CGFloat y = 0.5*(self.rangeBg.height-2*rangeSize.height);
    self.range.frame = CGRectMake(self.price.maxX+5, y, 0.5*self.width, rangeSize.height);
    self.scale.frame = CGRectMake(self.price.maxX+5, self.range.maxY, 0.5*self.width, rangeSize.height);
    
    CGFloat stockH = 0.2*self.height;
    self.stockBg.frame = CGRectMake(0, self.height-stockH-1, self.width, stockH);
    CGFloat infoS = 14, infoW = (self.width-2*infoS)/3; NSInteger infoCols = 3;
    [self.arrM enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL *stop) {
        CGSize size = [JCLKitObj JCLTextSize:obj.text font:obj.font];
        CGFloat infoH = 1.5*size.height, y = 0.5*(stockH-3*infoH),
        infoX = infoW *(idx % infoCols), infoY = infoH *(idx / infoCols);
        obj.frame = CGRectMake(infoX+infoS, infoY+y, infoW, infoH);
    }];
}

-(void)setCode:(NSString *)code{
    _code = code;
    
//    NSArray *arr = self.infoArr;
    if (self.mstokeModel.symbol.length>0) {
        [self setupInfo];
    }
    
    if (self.chart == nil) {
        [self InitKLine];
    } else {
        [self.chart setNeedData];
    }
}

-(void)setupInfo{
//    NSArray *arr = self.infoArr;
    NSString *price = [JCLMarketObj JCLMarketPrice:self.mstokeModel.latestPrice.floatValue decimal:self.decimal];
    NSString *close = [JCLMarketObj JCLMarketPrice:[self.mstokeModel.preClose floatValue] decimal:self.decimal];
    NSString *range = [JCLMarketObj JCLMarketRange:price close:close is:self.decimal];
    NSString *scale = [JCLMarketObj JCLMarketScale:range close:close];
    
    UIColor *infoColor = price.floatValue != 0 ? [JCLMarketObj JCLMarketColor:range close:@"0"] : JCL_Text_COL;
    NSString *val = price.floatValue > 0 ? price : close;
    self.price.text = val; self.range.text = range; self.scale.text = scale;
    self.price.textColor = infoColor;
    self.range.textColor = infoColor;
    self.scale.textColor = infoColor;
    
    NSString *low = [JCLMarketObj JCLMarketPrice:[self.mstokeModel.low floatValue] decimal:self.decimal];
    NSString *height = [JCLMarketObj JCLMarketPrice:[self.mstokeModel.high floatValue] decimal:self.decimal];
    NSString *open = [JCLMarketObj JCLMarketPrice:[self.mstokeModel.open floatValue] decimal:self.decimal];
    NSString *vol = [JCLMarketObj JCLMarketUnit:self.mstokeModel.volume  decimal:nil style:2];
    NSString *shiying = [JCLMarketObj JCLMarketUnit:0 decimal:nil style:1];
    
    
    NSArray *infoArr = @[[YSKitObj YSStrM:@"最  高  " val:height color:[JCLMarketObj JCLMarketColor:height close:close]],
                         [YSKitObj YSStrM:@"今  开  " val:open color:[JCLMarketObj JCLMarketColor:open close:close]],
                         [YSKitObj YSStrM:@"市盈率  " val:shiying color:JCL_Text_COL],
                         [YSKitObj YSStrM:@"最  低  " val:low color:[JCLMarketObj JCLMarketColor:low close:close]],
                         [YSKitObj YSStrM:@"昨  收  " val:close color:[JCLMarketObj JCLMarketColor:close close:close]],
                         [YSKitObj YSStrM:@" "       val:@"" color:JCL_Text_COL],
                         [YSKitObj YSStrM:@"成交量  " val:vol color:JCL_Text_COL],
                         ];
    [self.arrM enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL *stop) {
        if (idx == 5) {
            [RACObserve(self, valueA) subscribeNext:^(id x) {
                obj.attributedText = [YSKitObj YSStrM:@"总市值  " val:[JCLMarketObj JCLMarketUnit:self.valueA decimal:nil style:2] color:JCL_Text_COL];
            }];
        }
        obj.attributedText = infoArr[idx];
    }];
}

-(void)setIsKline:(BOOL)isKline{
    _isKline = isKline;
    [self.chart removeFromSuperview]; [self InitKLine];
}

-(void)InitKLine{
    JCLChartList *chart = [[JCLChartList alloc]init];
    [self addSubview:chart];
    chart.frame = CGRectMake(0, self.rangeBg.maxY+1, self.width, self.stockBg.y-self.rangeBg.maxY-2);
    chart.decimal = self.decimal;
    chart.code = self.code;
    self.chart = chart;
    
    NSNotificationCenter *not = [NSNotificationCenter defaultCenter];
    [not addObserver:self selector:@selector(longNot:) name:KLineLongNot object:nil];
}

-(void)longNot:(NSNotification*)sender{
    if ([[sender.userInfo objectForKey:@"isHave"] boolValue]) {
        NSArray *arr = self.infoArr;
        NSArray *obj = [sender.userInfo objectForKey:@"obj"];
        if (obj.count > 5) {
            NSString *price, *close, *range, *scale, *name;
            NSString *number, *average, *low, *height, *open, *money;
            if (obj.count < 13) {
                price = [JCLMarketObj JCLMarketPrice:[obj[2] floatValue] decimal:self.decimal];
                close = [JCLMarketObj JCLMarketPrice:[arr[1] floatValue] decimal:self.decimal];
                low = [JCLMarketObj JCLMarketPrice:[arr[3] floatValue] decimal:self.decimal];
                height = [JCLMarketObj JCLMarketPrice:[arr[2] floatValue] decimal:self.decimal];
                average = [JCLMarketObj JCLMarketPrice:[obj[3] floatValue] decimal:self.decimal];
                name = @"均 ";
                number = [JCLMarketObj JCLMarketUnit:obj[4] decimal:nil style:2];
                open = [JCLMarketObj JCLMarketPrice:[arr[0] floatValue] decimal:self.decimal];
                money = [JCLMarketObj JCLMarketUnit:obj[5] decimal:nil style:2];
            } else {
                price = [JCLMarketObj JCLMarketPrice:[obj[10] floatValue] decimal:self.decimal];
                close = [JCLMarketObj JCLMarketPrice:[obj[13] floatValue] decimal:self.decimal];
                low = [JCLMarketObj JCLMarketPrice:[obj[9] floatValue]    decimal:self.decimal];
                height = [JCLMarketObj JCLMarketPrice:[obj[8] floatValue] decimal:self.decimal];
                average = [JCLMarketObj JCLMarketPrice:[obj[10] floatValue] decimal:self.decimal];
                name = @"收 ";
                number = [JCLMarketObj JCLMarketUnit:obj[11] decimal:nil style:2];
                open = [JCLMarketObj JCLMarketPrice:[obj[7] floatValue] decimal:self.decimal];
                money = [JCLMarketObj JCLMarketUnit:obj[12] decimal:nil style:2];
            }
            
            UIColor *color;
            if ([average isEqualToString:@"--"]) {
                color = JCLRGBA(188, 188, 188, 1);
            } else {
                color = [JCLMarketObj JCLMarketColor:average close:close];
            }
            
            NSString *shizhi = [JCLMarketObj JCLMarketUnit:arr[13] decimal:nil style:2];
            NSString *shiying = [JCLMarketObj JCLMarketUnit:arr[12] decimal:nil style:2];
            
            NSArray *infoArr = @[[YSKitObj YSStrM:@"最  高  " val:height color:[JCLMarketObj JCLMarketColor:height close:close]],
                                 [YSKitObj YSStrM:@"今  开  " val:open color:[JCLMarketObj JCLMarketColor:open close:close]],
                                 [YSKitObj YSStrM:@"市盈率  " val:shiying color:JCL_Text_COL],
                                 [YSKitObj YSStrM:@"最  低  " val:low color:[JCLMarketObj JCLMarketColor:low close:close]],
                                 [YSKitObj YSStrM:@"昨  收  " val:close color:[JCLMarketObj JCLMarketColor:close close:close]],
                                 [YSKitObj YSStrM:@"总市值  " val:shizhi color:JCL_Text_COL],
                                 [YSKitObj YSStrM:@"成交量  " val:number color:JCL_Text_COL],
                                 ];
            [self.arrM enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL *stop) { obj.attributedText = infoArr[idx]; }];
            
            range = [JCLMarketObj JCLMarketRange:price close:close is:self.decimal];
            scale = [JCLMarketObj JCLMarketScale:range close:close];
            
            self.price.text = price;
            self.range.text = range;
            self.scale.text = scale;
            UIColor *infoColor = [JCLMarketObj JCLMarketColor:range close:@"0"];
            self.price.textColor = infoColor; self.range.textColor = infoColor; self.scale.textColor = infoColor;
        }
    } else {
        [self setupInfo];
    }
}

@end
