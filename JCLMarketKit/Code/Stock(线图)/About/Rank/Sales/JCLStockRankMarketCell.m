//
//  JCLStockRankMarketCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/17.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockRankMarketCell.h"
#import "JCLStockRankModel.h"
#import "JCLPopCollectList.h"

@interface JCLStockRankMarketCell()
@property(nonatomic, weak)   UIView *bg;
@property(nonatomic, weak)   JCLChartPath *pie;
@property(nonatomic, assign) BOOL isPie;

@property(nonatomic, strong) NSMutableArray *arrM;

@property(nonatomic, strong) NSMutableArray *wunai1;
@property(nonatomic, strong) NSMutableArray *wunai2;
@property(nonatomic, strong) NSMutableArray *wunai3;

@property (nonatomic, weak) JCLPopCollectList *pop;
@end

@implementation JCLStockRankMarketCell
+ (instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style{
    static NSString *ID = @"RankMarketCell";
    JCLStockRankMarketCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLStockRankMarketCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(NSMutableArray *)arrM{ if (_arrM) return _arrM; return _arrM = [[NSMutableArray alloc]init]; }
-(void)setArr:(NSArray *)arr{
    _arr = arr;
    
    [self.pie removeFromSuperview]; [self.arrM removeAllObjects];     [self removeAction];
    [JCLKitObj JCLRemoveKit:self.wunai1]; [JCLKitObj JCLRemoveLayer:self.wunai2]; [JCLKitObj JCLRemoveLayer:self.wunai3];
    if (arr.count && !self.arrM.count) {
        [arr enumerateObjectsUsingBlock:^(JCLStockRankModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.arrM addObject:obj.amount_buy];
        }];
        
        
        self.isPie = YES;
    }
}

-(NSMutableArray *)wunai1{ if (_wunai1) return _wunai1; return _wunai1 = [[NSMutableArray alloc]init]; }
-(NSMutableArray *)wunai2{ if (_wunai2) return _wunai2; return _wunai2 = [[NSMutableArray alloc]init]; }
-(NSMutableArray *)wunai3{ if (_wunai3) return _wunai3; return _wunai3 = [[NSMutableArray alloc]init]; }
-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    if (self.isPie && self.arrM.count) {
        
        NSArray *arr = self.arrM;
        CGFloat centX = 0.5*self.width, centY = 0.5*self.height;
        CGFloat wh = 0.18*self.width;
        
        
        NSMutableArray *textArrM = [[NSMutableArray alloc]init]; NSMutableArray *buyArrM = [[NSMutableArray alloc]init];
        NSMutableArray *dealArrM = [[NSMutableArray alloc]init];
        [self.arr enumerateObjectsUsingBlock:^(JCLStockRankModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [textArrM addObject:obj.industry_name]; [buyArrM addObject:obj.amount_buy];  [dealArrM addObject:obj.proportion_net_buy];
        }];
        
        NSArray *cols = @[JCLRGBA(219, 103, 170, 1),JCLRGBA(250, 163, 70, 1), JCLRGBA(67, 122, 204, 1), JCLRGBA(105, 219, 130, 1), JCLRGBA(111, 104, 219, 1)];
        //        NSArray *moveArr = [JCLChartManage JCLAnglePoint:arr point:CGPointMake(centX, centY) radius:0.58*self.pie.height];
        //        NSArray *addArr = [JCLChartManage JCLAnglePoint:arr point:CGPointMake(centX, centY) radius:0.46*self.pie.height];
        //        [moveArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //            CAShapeLayer *layer1 = [self InitLinePath:@[obj, addArr[idx]] width:1.4 strokeCol:JCLRGBA(224, 224, 224, 1) fillCol:[UIColor clearColor]];
        //
        //            CGPoint point1 = CGPointFromString(addArr[idx]); CGFloat wh = 5;
        //            UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(point1.x - 0.5*wh, point1.y - 0.5*wh, wh, wh)];
        //            CAShapeLayer *layer = [JCLChartManage JCLInitLayer:self path:path width:0 strokeCol:JCLBGRGB fillCol:JCLBGRGB];
        //            UILabel *info = [JCLKitObj JCLLable:self font:10 color:cols[idx] alignment:1];
        //            info.text = [NSString stringWithFormat:@"净买入额(万): %.2lf \r 占总成交额比: %@%%",
        //                         [buyArrM[idx] floatValue]/10000, dealArrM[idx]];
        //
        //            CGPoint point = CGPointFromString(obj);
        //            CGFloat x1 = point.x < 0.5*self.width ? 0.5*self.width - point.x : point.x - 0.5*self.width;
        //            CGSize size = [JCLKitObj JCLTextSize:info.text font:info.font width:0.5*self.width - x1 - 10];
        //            CGFloat x = point.x < 0.5*self.width ? point.x - size.width : point.x;
        //            CGFloat y = point.y - 0.5*size.height;
        //            info.frame = CGRectMake(x - 2, y, size.width, size.height);
        //            [self.wunai1 addObject:info]; [self.wunai2 addObject:layer]; [self.wunai3 addObject:layer1];
        //        }];
        
        
        if (arr.count == 1) {
            UILabel *title = [JCLKitObj JCLLable:self font:8 color:cols[0] alignment:0];
            title.text = [NSString stringWithFormat:@"%@", textArrM[0]];
            CGSize size = [JCLKitObj JCLTextSize:title.text font:title.font width:self.width];
            title.frame = CGRectMake(45, 10, self.width-10, size.height);
            
            UILabel *info = [JCLKitObj JCLLable:self font:8 color:JCLRGBA(144, 144, 144, 144) alignment:0];
            info.text = [NSString stringWithFormat:@"净买入额(万): %.2lf \r占总成交额比: %@%%",
                         [buyArrM[0] floatValue]/10000, dealArrM[0]];
            info.frame = CGRectMake(10, title.maxY-10, self.width-10, 40);
            [self.wunai1 addObject:info]; [self.wunai1 addObject:title];
        }
        
        if (arr.count == 2) {
            UILabel *title = [JCLKitObj JCLLable:self font:8 color:cols[0] alignment:0];
            title.text = [NSString stringWithFormat:@"%@", textArrM[0]];
            CGSize size = [JCLKitObj JCLTextSize:title.text font:title.font width:self.width];
            title.frame = CGRectMake(45, 10, self.width-10, size.height);
            
            UILabel *info = [JCLKitObj JCLLable:self font:8 color:JCLRGBA(144, 144, 144, 144) alignment:0];
            info.text = [NSString stringWithFormat:@"净买入额(万): %.2lf \r占总成交额比: %@%%",
                         [buyArrM[0] floatValue]/10000, dealArrM[0]];
            info.frame = CGRectMake(10, title.maxY-10,0.3* self.width, 40);
            
            UILabel *title1 = [JCLKitObj JCLLable:self font:8 color:cols[1] alignment:0];
            title1.text = [NSString stringWithFormat:@"%@", textArrM[1]];
            title1.frame = CGRectMake(self.width-90, 10, self.width-10, size.height);
            
            UILabel *info1 = [JCLKitObj JCLLable:self font:8 color:[UIColor blackColor] alignment:0];
            info1.text = [NSString stringWithFormat:@"净买入额(万): %.2lf \r占总成交额比: %@%%",
                          [buyArrM[1] floatValue]/10000, dealArrM[1]];
            info1.frame = CGRectMake(0.66*self.width-10, title1.maxY- 10,0.34* self.width + 10, 40);
            [self.wunai1 addObject:info]; [self.wunai1 addObject:info1];
            [self.wunai1 addObject:title];  [self.wunai1 addObject:title1];
        }
        
        if (arr.count == 3) {
            UILabel *title = [JCLKitObj JCLLable:self font:8 color:cols[0] alignment:0];
            title.text = [NSString stringWithFormat:@"%@", textArrM[0]];
            CGSize size = [JCLKitObj JCLTextSize:title.text font:title.font width:self.width];
            title.frame = CGRectMake(45, 10, self.width-10, size.height);
            
            
            UILabel *info = [JCLKitObj JCLLable:self font:8 color:JCLRGBA(144, 144, 144, 144) alignment:0];
            info.text = [NSString stringWithFormat:@"净买入额(万): %.2lf \r占总成交额比: %@%%",
                         [buyArrM[0] floatValue]/10000, dealArrM[0]];
            info.frame = CGRectMake(10, title.maxY-10, self.width-10, 40);
            
            UILabel *title2 = [JCLKitObj JCLLable:self font:8 color:cols[2] alignment:0];
            title2.text = [NSString stringWithFormat:@"%@", textArrM[2]];
            title2.frame = CGRectMake(45,  0.5*(self.height-30-size.height), self.width-10, size.height);
            
            UILabel *info2 = [JCLKitObj JCLLable:self font:8 color:[UIColor blackColor] alignment:0];
            info2.text = [NSString stringWithFormat:@"净买入额(万): %.2lf \r占总成交额比: %@%%",
                          [buyArrM[2] floatValue]/10000, dealArrM[2]];
            info2.frame = CGRectMake(10, title2.maxY-10, self.width-10, 40);
            
            UILabel *title1 = [JCLKitObj JCLLable:self font:8 color:cols[1] alignment:0];
            title1.text = [NSString stringWithFormat:@"%@", textArrM[1]];
            title1.frame = CGRectMake(45, self.height-40 - size.height, self.width-10, size.height);
            
            UILabel *info1 = [JCLKitObj JCLLable:self font:8 color:[UIColor blackColor] alignment:0];
            info1.text = [NSString stringWithFormat:@"净买入额(万): %.2lf \r占总成交额比: %@%%",
                          [buyArrM[1] floatValue]/10000, dealArrM[1]];
            info1.frame = CGRectMake(10, self.height-50, self.width-10, 40);
            [self.wunai1 addObject:info]; [self.wunai1 addObject:info1];             [self.wunai1 addObject:info2];
            [self.wunai1 addObject:title];  [self.wunai1 addObject:title1]; [self.wunai1 addObject:title2];
        }
        
        if (arr.count == 4) {
            UILabel *title = [JCLKitObj JCLLable:self font:8 color:cols[0] alignment:0];
            title.text = [NSString stringWithFormat:@"%@", textArrM[0]];
            CGSize size = [JCLKitObj JCLTextSize:title.text font:title.font width:self.width];
            title.frame = CGRectMake(45, 10, self.width-10, size.height);
            
            UILabel *info = [JCLKitObj JCLLable:self font:8 color:[UIColor blackColor] alignment:0];
            info.text = [NSString stringWithFormat:@"净买入额(万): %.2lf \r占总成交额比: %@%%",
                         [buyArrM[0] floatValue]/10000, dealArrM[0]];
            info.frame = CGRectMake(10, title.maxY-10, self.width-10, 40);
            
            
            UILabel *title1 = [JCLKitObj JCLLable:self font:8 color:cols[1] alignment:0];
            title1.text = [NSString stringWithFormat:@"%@", textArrM[1]];
            title1.frame = CGRectMake(45, self.height-40 - size.height, self.width-10, size.height);
            UILabel *info1 = [JCLKitObj JCLLable:self font:8 color:[UIColor blackColor] alignment:0];
            info1.text = [NSString stringWithFormat:@"净买入额(万): %.2lf \r占总成交额比: %@%%",
                          [buyArrM[1] floatValue]/10000, dealArrM[1]];
            info1.frame = CGRectMake(10, title1.maxY-10, self.width-10, 40);
            
            UILabel *title2 = [JCLKitObj JCLLable:self font:8 color:cols[2] alignment:0];
            title2.text = [NSString stringWithFormat:@"%@", textArrM[2]];
            title2.frame = CGRectMake(self.width - 90, 10, self.width-10, size.height);
            UILabel *info2 = [JCLKitObj JCLLable:self font:8 color:[UIColor blackColor] alignment:2];
            info2.text = [NSString stringWithFormat:@"净买入额(万): %.2lf \r占总成交额比: %@%%",
                          [buyArrM[2] floatValue]/10000, dealArrM[2]];
            info2.frame = CGRectMake(0, title2.maxY-10, self.width - 10, 40);
            
            UILabel *title3 = [JCLKitObj JCLLable:self font:8 color:cols[3] alignment:0];
            title3.text = [NSString stringWithFormat:@"%@", textArrM[3]];
            title3.frame = CGRectMake(self.width - 90, self.height-40 - size.height, self.width-10, size.height);
            UILabel *info3 = [JCLKitObj JCLLable:self font:8 color:[UIColor blackColor] alignment:2];
            info3.text = [NSString stringWithFormat:@"净买入额(万): %.2lf \r占总成交额比: %@%%",
                          [buyArrM[1] floatValue]/10000, dealArrM[3]];
            info3.frame = CGRectMake(0, title3.maxY-10, self.width - 10, 40);
            [self.wunai1 addObject:info]; [self.wunai1 addObject:info1]; [self.wunai1 addObject:info2]; [self.wunai1 addObject:info3];
            [self.wunai1 addObject:title];  [self.wunai1 addObject:title1]; [self.wunai1 addObject:title2]; [self.wunai1 addObject:title3];
        }
        
        if (arr.count == 5) {
            UILabel *title = [JCLKitObj JCLLable:self font:8 color:cols[0] alignment:0];
            title.text = [NSString stringWithFormat:@"%@", textArrM[0]];
            CGSize size = [JCLKitObj JCLTextSize:title.text font:title.font width:self.width];
            title.frame = CGRectMake(45, 10, self.width-10, size.height);
            
            UILabel *info = [JCLKitObj JCLLable:self font:8 color:[UIColor blackColor] alignment:0];
            info.text = [NSString stringWithFormat:@"净买入额(万): %.2lf \r占总成交额比: %@%%",
                         [buyArrM[0] floatValue]/10000, dealArrM[0]];
            info.frame = CGRectMake(10, title.maxY-10, self.width-10, 40);
            
            UILabel *title2 = [JCLKitObj JCLLable:self font:8 color:cols[2] alignment:0];
            title2.text = [NSString stringWithFormat:@"%@", textArrM[2]];
            title2.frame = CGRectMake(45,  0.5*(self.height-30-size.height), self.width, size.height);
            UILabel *info2 = [JCLKitObj JCLLable:self font:8 color:[UIColor blackColor] alignment:0];
            info2.text = [NSString stringWithFormat:@"净买入额(万): %.2lf \r占总成交额比: %@%%",
                          [buyArrM[2] floatValue]/10000, dealArrM[2]];
            info2.frame = CGRectMake(10, title2.maxY-10, self.width-10, 40);
            
            UILabel *title1 = [JCLKitObj JCLLable:self font:8 color:cols[1] alignment:0];
            title1.text = [NSString stringWithFormat:@"%@", textArrM[1]];
            title1.frame = CGRectMake(45, self.height-40 - size.height, self.width-10, size.height);
            
            UILabel *info1 = [JCLKitObj JCLLable:self font:8 color:[UIColor blackColor] alignment:0];
            info1.text = [NSString stringWithFormat:@"净买入额(万): %.2lf \r占总成交额比: %@%%",
                          [buyArrM[1] floatValue]/10000, dealArrM[1]];
            info1.frame = CGRectMake(10, title1.maxY-10, self.width-10, 40);
            
            
            UILabel *title4 = [JCLKitObj JCLLable:self font:8 color:cols[3] alignment:0];
            title4.text = [NSString stringWithFormat:@"%@", textArrM[3]];
            title4.frame = CGRectMake(self.width - 90, 10, self.width-10, size.height);
            
            UILabel *info4 = [JCLKitObj JCLLable:self font:8 color:[UIColor blackColor] alignment:2];
            info4.text = [NSString stringWithFormat:@"净买入额(万): %.2lf \r占总成交额比: %@%%",
                          [buyArrM[3] floatValue]/10000, dealArrM[3]];
            info4.frame = CGRectMake(0, title4.maxY-10, self.width - 10, 40);
            
            UILabel *title3 = [JCLKitObj JCLLable:self font:8 color:cols[4] alignment:0];
            title3.text = [NSString stringWithFormat:@"%@", textArrM[4]];
            title3.frame = CGRectMake(self.width - 90, self.height-40 - size.height, self.width-10, size.height);
            UILabel *info3 = [JCLKitObj JCLLable:self font:8 color:[UIColor blackColor] alignment:2];
            info3.text = [NSString stringWithFormat:@"净买入额(万): %.2lf \r占总成交额比: %@%%",
                          [buyArrM[4] floatValue]/10000, dealArrM[4]];
            info3.frame = CGRectMake(0, title3.maxY-10, self.width - 10, 40);
            [self.wunai1 addObject:info]; [self.wunai1 addObject:info1]; [self.wunai1 addObject:info2]; [self.wunai1 addObject:info3];
            [self.wunai1 addObject:info4];
            [self.wunai1 addObject:title];  [self.wunai1 addObject:title1]; [self.wunai1 addObject:title2]; [self.wunai1 addObject:title3];
            [self.wunai1 addObject:title4];
            
        }
        
        JCLChartPath *pie = [[JCLChartPath alloc]init]; [self addSubview:pie];
        pie.style = JCLChartPathPie;
        pie.pieArr = self.arrM;
        pie.pieCols = @[JCLRGBA(219, 103, 170, 1),JCLRGBA(250, 163, 70, 1), JCLRGBA(67, 122, 204, 1), JCLRGBA(105, 219, 130, 1), JCLRGBA(111, 104, 219, 1)];
        self.pie = pie;
        CGFloat y = 0.12*self.width;
        self.pie.frame = CGRectMake(0, y, self.width, self.height - 2*y);
        
        NSArray *XYArr = [JCLChartManage JCLAnglePoint:arr point:CGPointMake(centX, centY) radius:0.36*self.pie.height];
        [XYArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *info = [JCLKitObj JCLLable:self font:9 color:[UIColor whiteColor] alignment:1]; info.text = textArrM[idx];
            CGSize size = [JCLKitObj JCLTextSize:info.text font:info.font width:self.width];
            CGPoint point = CGPointFromString(obj);
            CGFloat x = point.x - 0.5*size.width, y = point.y - 0.5*size.height ;
            info.frame = CGRectMake(x, y, size.width, size.height); info.tag = idx;
            [JCLKitObj RXTap:info target:self action:@selector(tapAction1:) number:1];
            [self.wunai1 addObject:info];
        }];
        
        self.isPie = NO;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(centX - 0.5*wh, centY - 0.5*wh, wh, wh)];
        [JCLChartManage JCLInitLayer:self path:path width:0 strokeCol:[UIColor whiteColor] fillCol:[UIColor whiteColor]];
        
        __weak typeof(self) weakSelf = self;
        self.pie.pathActionBlock = ^(NSInteger idx){
            [self removeAction];
            [weakSelf InitInfo:idx];
        };
    }
}
-(void)tapAction1:(UITapGestureRecognizer *)tap{
    UILabel *obj = (UILabel *)tap.view;
    [self InitInfo:obj.tag];
}

-(CAShapeLayer *)InitLinePath:(NSArray *)arr width:(CGFloat)width strokeCol:(UIColor *)strokeCol fillCol:(UIColor *)fillCol{
    return [JCLChartManage JCLInitLayer:self path:[JCLChartManage JCLInitLine:arr isClose:NO] width:width strokeCol:strokeCol fillCol:fillCol];
}

-(void)InitInfo:(NSInteger)idx{
    [self removeAction];
    
    self.bg = [JCLKitObj JCLView:self color:JCLRGBA(0, 0, 0, 0)];
    self.bg.frame = self.bounds;
    [JCLKitObj RXTap:self.bg target:self action:@selector(removeAction) number:1];
    
    JCLStockRankModel *model = self.arr[idx];
    NSArray *arr = [model.stocks componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
    NSMutableArray *arrM = [[NSMutableArray alloc]init];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *code = [NSString stringWithFormat:@"%@%@", [obj substringFromIndex:7], [obj substringToIndex:6]];
        NSArray *infos = [JCLMarketObj JCLStockInfo:code];
        [arrM addObject:@[infos[3], code]];
    }];
    
    
    
    JCLPopCollectList *info = [[JCLPopCollectList alloc]init];[self addSubview:info];
    info.arr = arrM;
    
    CGFloat centX = 0.5*self.width, centY = 0.5*self.height;
    NSArray *XYArr = [JCLChartManage JCLAnglePoint:self.arrM point:CGPointMake(centX, centY) radius:0.36*self.pie.height];
    CGPoint point = CGPointFromString(XYArr[idx]);
    CGFloat count = arrM.count;
    CGFloat num = count/2; NSInteger numb = num,
    number = num > numb ? numb+1 : numb;
    number = number == 0 ? 1 : number;
    CGFloat w = 0.36*self.width, h = (number+1)*34;
    CGFloat x = point.x < 0.5*self.width ? point.x - w : point.x;
    CGFloat y = point.y - h;
    if (h > self.height - 44) {
        y = 22, h = self.height - 44;
    }
    if (y < 0) {
        y = 22;
    }
    info.frame = CGRectMake(x - 2, y, w, h);
    self.pop = info;
}

-(void)removeAction{ [self.bg removeFromSuperview];  [self.pop removeFromSuperview]; }
@end
