//
//  JCLStockRankNotionCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/17.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockRankNotionCell.h"

@interface JCLStockRankNotionCell()
@property(nonatomic, weak) JCLChartPath *pie;
@property(nonatomic, weak) UILabel *title;
@property(nonatomic, assign) BOOL isPie;
@property(nonatomic, strong) NSMutableArray *infoArrM;
@property(nonatomic, strong) NSMutableArray *stockArrM;

@property(nonatomic, strong) NSArray *stockInfo;
@end

@implementation JCLStockRankNotionCell
+ (instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style{
    static NSString *ID = @"RankNotionCell";
    JCLStockRankNotionCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLStockRankNotionCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.title = [JCLKitObj JCLLable:self font:13 color:JCLRGB(77, 82, 91) alignment:2];
        self.title.text = @"参与个股: ";
    }
    return self;
}

-(NSMutableArray *)infoArrM{ if (_infoArrM) return _infoArrM; return _infoArrM = [[NSMutableArray alloc]init]; }
-(NSMutableArray *)stockArrM{ if (_stockArrM) return _stockArrM; return _stockArrM = [[NSMutableArray alloc]init]; }
-(void)setArr:(NSArray *)arr{
    _arr = arr;
    
    [self.pie removeFromSuperview];
    [JCLKitObj JCLRemoveKit:self.infoArrM]; [JCLKitObj JCLRemoveKit:self.stockArrM];
    if (arr.count && !self.infoArrM.count){
        NSMutableArray *arrM = [[NSMutableArray alloc]init];
        [arr enumerateObjectsUsingBlock:^(JCLStockRankModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arrM addObject:obj.amount_buy];
        }];
        JCLChartPath *pie = [[JCLChartPath alloc]init]; [self addSubview:pie];
        pie.style = JCLChartPathPie;
        pie.pieArr = arrM;
        pie.pieCols = @[ JCLRGB(219, 103, 170),JCLRGB(250, 163, 70), JCLRGB(67, 122, 204), JCLRGB(105, 219, 130), JCLRGB(111, 104, 219)];
        pie.pieIdx = 0;
        pie.aniTime = 0.6;
        pie.isPieAnima = YES;
        self.pie = pie;
        
        JCLStockRankModel *model = arr[0];
        CGFloat sum = [[arrM valueForKeyPath:@"@sum.floatValue"] floatValue];
        
        NSArray *infoArr = [self setupInfoArr:model sum:sum];
        [infoArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *info = [JCLKitObj JCLLable:self font:13 color:JCLRGB(77, 82, 91) alignment:1];
            info.text = infoArr[idx];
            [self.infoArrM addObject:info];
        }];
        
        NSArray *stocks = [self setupStocksArr:model];
        [stocks enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *info = [JCLKitObj JCLLable:self font:12 color:JCLRGB(77, 82, 91) alignment:1];
            info.text = stocks[idx][0]; info.tag = idx;
            info.layer.cornerRadius = 8; info.layer.borderWidth = 1.4; info.layer.borderColor = JCLRGB(237, 142, 52).CGColor;
            [JCLKitObj RXTap:info target:self action:@selector(tapAciton:) number:1];
            [self.stockArrM addObject:info];
        }];
        
        pie.pathActionBlock = ^(NSInteger idx){
            JCLStockRankModel *model = arr[idx];
            NSArray *infoArr = [self setupInfoArr:model sum:sum];
            
            [self.infoArrM enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.text = infoArr[idx];
            }];
            
            [JCLKitObj JCLRemoveKit:self.stockArrM];
            NSArray *stocks = [self setupStocksArr:model];
            [stocks enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UILabel *info = [JCLKitObj JCLLable:self font:12 color:JCLRGB(77, 82, 91) alignment:1];
                info.text = stocks[idx][0]; info.tag = idx;
                info.layer.cornerRadius = 8; info.layer.borderWidth = 1.4; info.layer.borderColor = JCLRGB(237, 142, 52).CGColor;
                [JCLKitObj RXTap:info target:self action:@selector(tapAciton:) number:1];
                [self.stockArrM addObject:info];
            }];
            
            [self layoutSubviews];
        };
    }
}
-(void)tapAciton:(UITapGestureRecognizer *)tap{
    UILabel *obj = (UILabel *)tap.view;
    !self.tapAction ? : self.tapAction(self.stockInfo[obj.tag]);
}

-(NSArray *)setupInfoArr:(JCLStockRankModel *)model sum:(CGFloat)sum{
    return @[[NSString stringWithFormat:@"所属概念: %@", model.theme_name],
             [NSString stringWithFormat:@"净买入额(万): %.2lf", model.amount_buy.floatValue/10000],
             [NSString stringWithFormat:@"占总成交额比: %@%%", model.proportion_net_buy]];
}

-(NSArray *)setupStocksArr:(JCLStockRankModel *)model{
    NSArray *arr = [model.stocks componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
    NSMutableArray *stocks = [[NSMutableArray alloc]init];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *code = [NSString stringWithFormat:@"%@%@", [obj substringFromIndex:7], [obj substringToIndex:6]];
        NSArray *infos = [JCLMarketObj JCLStockInfo:code];
        if(infos.count){
            [stocks addObject:@[infos[3], code]];
        }
    }];
    self.stockInfo = stocks;
    return stocks;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat pieY = 14;
    
    CGSize size = [JCLKitObj JCLTextSize:self.title.text spac:0 font:self.title.font width:self.width];
    __block CGFloat h = 1.2*size.height, y = self.height - pieY - 3*h;
    self.title.frame = CGRectMake(0, y, 0.26*self.width, h);
    __block CGFloat x = self.title.maxX+4;
    [self.stockArrM enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGSize size = [JCLKitObj JCLTextSize:obj.text spac:0 font:obj.font width:self.width];
        CGFloat sizeW = size.width+8;
        
        if (x > self.width - size.width-10) {
            x = self.title.maxX+4;
            y = y+h+4;
        }
        
        obj.frame = CGRectMake(x, y, sizeW, h);
        x += sizeW+4;
    }];
    
    CGFloat infoY = self.title.y - 3*h - 6;
    [self.infoArrM enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(0, infoY + idx*h, self.width, h);
    }];
    
    self.pie.frame = CGRectMake(0, pieY, self.width, infoY - 2*pieY);
}
@end
