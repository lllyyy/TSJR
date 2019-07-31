//
//  QuotationPlateHeader.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2016/11/7.
//  Copyright © 2016年 ruixue. All rights reserved.
//

#import "JCLMarketPlateHeader.h"

@interface JCLMarketPlateHeader()
@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UILabel *rangeLab;
@property (nonatomic, strong) UILabel *scaleLab;

@property (nonatomic, strong) NSMutableArray *arrM;
@end

@implementation JCLMarketPlateHeader
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JCL_Cell_COL;
        self.priceLab = [YSKitObj YSLable:self size:28 color:JCL_Text_COL alignment:0 style:0];
        self.rangeLab = [YSKitObj YSLable:self size:13 color:JCL_Text_COL alignment:0 style:0];
        self.scaleLab = [YSKitObj YSLable:self size:13 color:JCL_Text_COL alignment:0 style:0];

        [JCLKitObj RXTap:self target:self action:@selector(pushAction) number:1];
    }
    return self;
}

-(void)pushAction{ !self.pushActionBlock ? : self.pushActionBlock(); }

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize priceSize = [JCLKitObj JCLTextSize:@"44444.44" font:self.priceLab.font];
    CGSize rangeSize = [JCLKitObj JCLTextSize:@"44444.44" font:self.rangeLab.font];
    
    CGFloat priceS = 14, priceY = 0.5*(self.height - (priceSize.height + rangeSize.height));
    self.priceLab.frame = CGRectMake(priceS, priceY, priceSize.width, priceSize.height);

    CGFloat rangeW = 0.5*(priceSize.width);
    self.rangeLab.frame = CGRectMake(self.priceLab.x, self.priceLab.maxY, rangeW, rangeSize.height);
    self.scaleLab.frame = CGRectMake(self.rangeLab.maxX + 10, self.priceLab.maxY, rangeW, rangeSize.height);
    
    CGFloat infoW = 0.5*(0.5*self.width); NSInteger infoCols = 2;
    for (NSInteger i = 0; i < 4; i++) {
        UILabel *info = [YSKitObj YSLable:self size:14 color:JCLRGBA(29, 30, 31, 1) alignment:0 style:1];
        info.textColor = JCL_Text_COL;
        CGSize infoSize = [JCLKitObj JCLTextSize:@"4444.44" font:info.font];
        CGFloat infoH = 1.4*infoSize.height, infoS = 0.5*(self.height - infoH*2), infoX = infoW *(i % infoCols), infoY = infoH *(i / infoCols);
        info.frame = CGRectMake(0.5*self.width + infoX, infoS + infoY, infoW, infoH);
        [self.arrM addObject:info];
    }
}

-(NSMutableArray *)arrM{ if (_arrM) return _arrM; return _arrM = [[NSMutableArray alloc]init]; }
-(void)drawRect:(CGRect)rect{
    if (self.arr.count > 6) {
        NSString *price = self.arr[4]; NSString *close = self.arr[1];
        NSString *range = [JCLMarketObj JCLMarketRange:price close:close];
        NSString *scale = [JCLMarketObj JCLMarketScale:range close:close];
        self.priceLab.text = [JCLMarketObj JCLMarketPrice:price.floatValue decimal:@""]; self.rangeLab.text = range; self.scaleLab.text = scale;
        
        UIColor *color = [JCLMarketObj JCLMarketColor:range close:@"0"];
        self.priceLab.textColor = color; self.rangeLab.textColor = color; self.scaleLab.textColor = color;
        
        NSString *height = [JCLMarketObj JCLMarketPrice:[self.arr[2] floatValue] decimal:@""];
        NSString *open = [JCLMarketObj JCLMarketPrice:[self.arr[0] floatValue] decimal:@""];
        NSString *low = [JCLMarketObj JCLMarketPrice:[self.arr[3]  floatValue] decimal:@""];
        NSString *money = [JCLMarketObj JCLMarketUnit:self.arr[6] decimal:@"" style:2];
        NSArray *infoArr = @[[self RXAttributed:@"低 " value:low color:color],
                             [self RXAttributed:@"高 " value:height color:color],
                             [self RXAttributed:@"开 " value:open color:color],
                             [self RXAttributed:@"额 " value:money color:JCL_Text_COL]];
        [self.arrM enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL *stop) {
            obj.attributedText = infoArr[idx];
        }];
    }
}

-(NSMutableAttributedString *)RXAttributed:(NSString *)key value:(NSString *)value color:(UIColor *)color{
    NSString *after = [NSString stringWithFormat:@"%@", value];
    NSString *before = [NSString stringWithFormat:@"%@%@", key, after];
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithString:before];
    [strM addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DINPro-Medium" size:[JCLKitObj JCLSize:13]] range:[before rangeOfString:after]];
    [strM addAttribute:NSForegroundColorAttributeName value:color range:[before rangeOfString:after]];
    return strM;
}
@end
