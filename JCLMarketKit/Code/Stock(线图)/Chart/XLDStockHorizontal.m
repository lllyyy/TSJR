//
//  XLDStockHorizontal.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2016/11/24.
//  Copyright © 2016年 ruixue. All rights reserved.
//

#import "XLDStockHorizontal.h"
#import "JCLTableCell.h"
#import "XLDStockNavigation.h"
#import <JCLKlineIdxLib/JCLKlineIdxObj.h>

#import "JCLBaseMenu.h"
#import "JCLTimeChart.h"
#import "JCLKLineChart.h"
#import "JCLIdxMenu.h"
#import "YGCollectMenu.h"
#import "TSJRRealTimeMarket.h"
#import "JCLStockDraw.h" // 绘制
#import "TSJRRealTimeMarket.h"


@interface XLDStockHorizontal()
@property (nonatomic, weak) JCLBaseMenu *menu;
@property (nonatomic, weak) UIButton *minute;
@property (nonatomic, weak) UIView *line;
@property (nonatomic, weak) JCLTimeChart *time;
@property (nonatomic, strong) JCLKLineChart *kLine;
@property (nonatomic, weak) JCLIdxMenu *idxMenu;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger number;

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) XLDStockNavigation *naviga;

@property (nonatomic, strong) NSArray *popArray;
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger authorType;
@property (nonatomic, strong) NSString *close;

@property (nonatomic, strong) NSArray *arr;

@property (nonatomic, strong) NSString *timeType; // KLine 时间类型
@property (nonatomic, strong) NSArray *kLineArr;
@property (nonatomic, strong) NSString *idxStyle;

@property (nonatomic, assign) NSInteger authType;
@property (nonatomic, strong) NSString *authStr;

@property (nonatomic, assign) NSInteger idxType;
@property (nonatomic, strong) NSString *idxStr;

@property(nonatomic, strong) NSArray *minuteArr;
@property(nonatomic, strong) NSArray *idxArr;
@property (nonatomic, assign) BOOL isRefresh;

@property (nonatomic, weak) YGCollectMenu *idxBox;
@property (nonatomic, strong) TSJRRealTimeMarket *modelMarket;
// 绘制
@property (nonatomic, weak) JCLStockDraw *drawPath;
@property (nonatomic, weak) UITableView *table;
@property (nonatomic, strong) NSMutableArray *arrM;
@property (nonatomic, strong) NSArray *times;
@end

@implementation XLDStockHorizontal
- (NSMutableArray *)arrM{ if (_arrM) return _arrM; return _arrM = [[NSMutableArray alloc]init]; }

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = JCL_Cell_COL;
    [self.navi removeFromSuperview];

    self.times = [JCLMarketObj JCLStockTimes:self.code];

    [self drawNavigation];
    [self drawMenu];
    [self drawPopMenu];

    NSString *idx = PreRead(JCLKLineIdx);
    self.idxType = idx.integerValue;
    AppDelegate.shareAppDelegate.timerAtionBlock = ^(){ self.isRefresh ? : [self setNeedData]; };
    
    NSNotificationCenter *not = [NSNotificationCenter defaultCenter];
    [not addObserver:self selector:@selector(gestureNot:) name:KLineGestureNot object:nil];
}

-(void)setNeedData{ [self loadStockInfo]; self.time ? [self drawTimePath] : [self drawKLinePath]; }

-(void)gestureNot:(NSNotification*)sender{ self.isRefresh = [[sender.userInfo objectForKey:@"isHave"] boolValue] ? YES : NO; }
-(void)dealloc{ [[NSNotificationCenter defaultCenter] removeObserver:self name:KLinePushNot object:nil]; }

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
}

-(void)drawNavigation{
    UIView *bgView = [JCLKitObj RXView:self.view color:nil];
    bgView.frame = CGRectMake(0, 0, JCLWIDTH, JCLHEIGHT); self.bgView = bgView;
    
    XLDStockNavigation *navi = [[XLDStockNavigation alloc]initWithFrame:CGRectMake(0, 0, self.bgView.height, [JCLKitObj JCLHeight:50])];
    [self.bgView addSubview:navi]; self.naviga = navi;
    navi.dissActionBlock = ^(){ [self.navigationController popViewControllerAnimated:YES]; };
    [self loadStockInfo];
}

-(void)loadStockInfo{
    
    NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlC,@"quoteRealTime"];
//    [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    [JCLHttps httpPOSTRequest:postUrl params:@{@"userId":userId(),@"symbols":self.code} success:^(id obj) {
        
        MMResultModel *model =(MMResultModel *)obj;
        NSLog(@"modelmodel %@",model.data);
        if (model.code.intValue == 200) {
            self.modelMarket = [TSJRRealTimeMarket modelWithDictionary:model.data[0]];
            [self setupNaviga:self.modelMarket];
         }
        
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
        } failure:^(NSError *error) {
 
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
 
}

-(void)setupNaviga:(TSJRRealTimeMarket *)arr{
    NSString *price = arr.latestPrice;
    NSString *close = arr.preClose;
    self.close = close;
    NSString *range = [JCLMarketObj JCLMarketRange:price close:close];
    NSString *scale = [JCLMarketObj JCLMarketScale:range close:close];
    
    if ([arr.symbol isEqualToString:@".DJI"]) {
        self.naviga.textLab.text = [NSString stringWithFormat:@"%@(%@)",@"道琼斯",arr.symbol];
    }else if ([arr.symbol isEqualToString:@".IXIC"]){
          self.naviga.textLab.text = [NSString stringWithFormat:@"%@(%@)",@"纳斯达克",arr.symbol];
    }else if ([arr.symbol isEqualToString:@".INX"]){
        self.naviga.textLab.text = [NSString stringWithFormat:@"%@(%@)",@"标普",arr.symbol];
    }else{
      self.naviga.textLab.text = [NSString stringWithFormat:@"%@(%@)",[[AppDelegate shareAppDelegate].messageNoticeStore fetchMessage:arr.symbol],arr.symbol];
    }
    
    self.naviga.priceLab.text = [NSString stringWithFormat:@"%@ (%@   %@)", [JCLMarketObj JCLMarketPrice:price.floatValue decimal:nil], range, scale];

    self.naviga.numberLab.text = [NSString stringWithFormat:@"量: %@", [JCLMarketObj JCLMarketUnit:arr.volume decimal:nil style:2]];
    //self.naviga.moneyLab.text = [NSString stringWithFormat:@"额: %@", [JCLMarketObj JCLMarketUnit:arr[0][6] decimal:nil style:2]];
    
    UIColor *infoCol = [JCLMarketObj JCLMarketColor:range];
    self.naviga.priceLab.textColor = infoCol; self.naviga.rangeLab.textColor = infoCol; self.naviga.scaleLab.textColor = infoCol;
    [self.naviga setNeedsLayout];
}

-(void)drawMenu{
    self.idxArr = @[@"VOL",@"CCI",@"MACD",@"KDJ",@"RSI",@"PSY",@"WR",@"ASI",@"OBV",@"ROC",@"VR",
                    @"DMI",@"DMA",@"FSL",@"TRIX", @"BRAR",@"CR",@"EMV",@"WVAD",@"MTM",@"BOLL"];
//    self.idxArr = @[@"VOL",@"CCI",@"MACD",@"KDJ",@"RSI",@"PSY",@"WR",@"ASI",@"OBV",@"ROC"];

    
    NSArray *arr = @[@"分时", @"日K", @"周K", @"月K", @"1分钟", @"5分钟", @"15分钟", @"30分钟", @"60分钟"];
    NSArray *val = @[@"", @"day", @"week", @"month", @"1min", @"5min", @"15min", @"30min", @"60min"];

    CGFloat h = [JCLKitObj JCLHeight:40];
    JCLBaseMenu *menu = [[JCLBaseMenu alloc]init]; [self.bgView addSubview:menu];
    menu.frame = CGRectMake(0, self.naviga.maxY, self.bgView.height, h);
    menu.style = MenuStyleBGLine; menu.isAction = YES;
    NSString *idx = PreRead(JCLKLine); menu.idx = idx.integerValue<=8 ? idx.integerValue : 4444;
    menu.arr = arr;
    menu.idxLine.backgroundColor = JCL_Cell_COL;
    menu.tapActionBlock = ^(NSInteger idx){
        self.kLine.isIdx = NO;
        self.page = 0; self.number = 400;
        self.authType = 0;
        NSString *idxStr = [NSString stringWithFormat:@"%ld", (long)idx]; PreWrite(idxStr, JCLKLine);
        self.timeType = val[idx];
        idx == 0 ? [self drawTimePath] : [self drawKLinePath];
    };
    self.menu = menu;
}

-(void)drawPopMenu{
    
    CGFloat w = 0.09*self.bgView.height;
    UITableView *table = [JCLKitObj JCLTable:self.bgView target:self frame:CGRectMake(self.bgView.height-w, self.menu.maxY+4, w, self.bgView.width-14-self.menu.maxY) style:UITableViewStylePlain];
    table.backgroundColor = JCL_Bg_COL;
    table.layer.borderWidth = 1; table.layer.borderColor = JCL_Line_COL.CGColor;
    self.table = table;
}

-(void)loadTime{
    if (self.code.length) {
//        /quoteapi/timeLine
//        获取分时数据
        NSMutableArray *array = [NSMutableArray new];
        NSString *postUrlA = [NSString stringWithFormat:@"%@/%@",baseApiURlC,@"timeLine"];
        
        [JCLHttps httpPOSTRequest:postUrlA params:@{@"userId":userId(),@"symbols":self.code} success:^(id obj) {
            MMResultModel *model =(MMResultModel *)obj;
            if (model.code.intValue == 200) {
                [array removeAllObjects];
                for (id objc in model.data[0][@"intraday"][@"items"]) {
                    NSMutableArray *arrayA = [NSMutableArray new];
                    TSJRRealTimeMarket *mm = [TSJRRealTimeMarket modelWithDictionary:objc];
                    [arrayA addObject:mm.time];
                    [arrayA addObject:mm.price];
                    [arrayA addObject:mm.avgPrice];
                    [arrayA addObject:mm.volume];
                    [arrayA addObject:@"0.00"];
                    [array addObject:arrayA];
                    
                }
                 self.time.close = @"20";
                NSLog(@"=====Array = %@",array);
                self.time.arr =array;
            }
            
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
        } failure:^(NSError *error) {
//            [JCLFramework showErrorHud:@"服务器异常"];
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
        
//        [JCLStockDataObj JCLGetStockTimeInfo:JCLMarketURL code:self.code success:^(NSArray * obj) {
//            NSArray *arr = [JCLHttpsObj JCLHandleStr:obj begin:2 end:1];
//            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                self.time.close = @"31.13";
//            }];
//            self.time.arr = [JCLHttpsObj JCLHandleStr:obj begin:4 end:obj.count - 5];
//        } failure:^(NSError *error) { }];
    }
}

-(void)loadKlineStr{
 
    
    NSMutableArray *array = [NSMutableArray new];
    NSString *postUrlA = [NSString stringWithFormat:@"%@/%@",baseApiURlC,@"kline"];
    [JCLHttps httpPOSTRequest:postUrlA params:@{@"userId":userId(),@"limit":@"500",@"period":self.timeType,@"symbols":self.code} success:^(id obj) {
        MMResultModel *model = obj;
        if (model.code.integerValue == 200) {
              [array removeAllObjects];
            for(id objc in model.data[0][@"items"]) {
              
                NSMutableArray *arrayA = [NSMutableArray new];
                TSJRRealTimeMarket *mm = [TSJRRealTimeMarket modelWithDictionary:objc];
                [arrayA addObject:mm.time];
                [arrayA addObject:@"0"];
                [arrayA addObject:mm.open];
                [arrayA addObject:mm.high];
                [arrayA addObject:mm.low];
                [arrayA addObject:mm.close];
                [arrayA addObject:mm.volume];
                [arrayA addObject:@"0.00"];
                [arrayA addObject:mm.low];
                [array addObject:arrayA];
            }
//            if (self.page <= 0) {
//
//                [arrM addObjectsFromArray:arr];
//            }
//            else {
//                [arrM addObjectsFromArray:self.arrM];
//
//            }
//
//            self.arrM = arrM;
//            [self klineData];
            
            
            self.arrM = array;
            if (self.arrM.count) {
                [self klineData];
            }
        }
        
    } failure:^(NSError *error) {
        [JCLFramework showErrorHud:@"服务器异常"];
        
    }];
    
    
//    [JCLStockDataObj JCLGetStockKLineInfo:JCLMarketURL code:self.code
//                                     page:self.page number:self.number
//                                 timeType:self.timeType
//                                 authType:[NSString stringWithFormat:@"%ld", (long)self.authType]
//                                  success:^(NSArray * obj) {
//                                      if (obj.count > 5) {
//                                          NSArray *arr = [JCLHttpsObj JCLHandleStr:obj begin:4 end:obj.count - 5];
//                                          NSMutableArray *arrM = [[NSMutableArray alloc]init];
//
//                                          if (self.page <= 0) {
//
//                                              [arrM addObjectsFromArray:arr];
//                                          }
//                                          else {
//                                              [arrM addObjectsFromArray:self.arrM];
//
//                                          }
//
//                                          self.arrM = arrM;
////                                          if (!arr.count) {
////                                              self.kLine.isIdx = NO;
////                                          }
//
//                                          [self klineData];
//                                      }
//                                  } failure:^(NSError *error) { }];
}

-(void)klineData{
    self.kLine.MAArr = [JCLKlineIdxObj InitMAData:self.arrM idx:5];
    self.kLine.isMinute = self.timeType.integerValue <100 ? YES : NO;
    self.kLine.idxStyle = (JCLKLineIdxStyle)self.idxType;
    self.kLine.idxArr = self.idxType > 0 ? [JCLKlineIdxObj InitIdxData:self.arrM kline:self.timeType idx:self.idxArr[self.idxType]] : [JCLKlineIdxObj InitMAData:self.arrM idx:6];
    self.kLine.arr = self.arrM;
}

-(void)drawTimePath{
    self.table.hidden = YES;
    [self.kLine removeFromSuperview]; self.kLine = nil;
    if (self.time == nil) {
        JCLTimeChart *chart = [[JCLTimeChart alloc]init];
        [self.bgView addSubview:chart];
        chart.times = self.times;
        CGFloat x = 10, y = 10;
        chart.frame = CGRectMake(x, self.menu.maxY + y, self.bgView.height - 2*x, self.bgView.width - self.menu.maxY - 2*y);
        chart.longActionBlock = ^(BOOL isHave, NSArray *obj){
            if (isHave) {
                NSString *price = obj[2];
                NSString *close = self.close;
                NSString *range = [JCLMarketObj JCLMarketRange:price close:close];
                NSString *scale = [JCLMarketObj JCLMarketScale:range close:close];
                
                self.naviga.priceLab.text = [NSString stringWithFormat:@"%@ (%@   %@)", [JCLMarketObj JCLMarketPrice:price.floatValue decimal:nil], range, scale];

                self.naviga.numberLab.text = [NSString stringWithFormat:@"量: %@", [JCLMarketObj JCLMarketUnit:obj[4] decimal:nil style:2]];
//                self.naviga.moneyLab.text = [NSString stringWithFormat:@"额: %@", [JCLMarketObj JCLMarketUnit:obj[5] decimal:nil style:2]];
                
                UIColor *infoCol = [JCLMarketObj JCLMarketColor:range];
                self.naviga.priceLab.textColor = infoCol; self.naviga.rangeLab.textColor = infoCol; self.naviga.scaleLab.textColor = infoCol;
                [self.naviga setNeedsLayout];
            } else {
                [self setupNaviga:self.modelMarket];
            }
        };
        self.time = chart;
    }
    [self loadTime];
}

-(void)drawKLinePath{
    self.table.hidden = NO;
    [self.time removeFromSuperview]; self.time = nil;
    if (self.kLine == nil) {
        JCLKLineChart *kLine = [[JCLKLineChart alloc]init]; [self.bgView addSubview:kLine];
        CGFloat x = 10, y = 10;
        kLine.frame = CGRectMake(x, self.menu.maxY + 6, self.bgView.height - self.table.width - 1.5*x, self.bgView.width - self.menu.maxY - 1.6*y);
        kLine.isScroll = YES;
        
        kLine.pageActionBlock = ^(){
            self.kLine.isIdx = NO; self.page +=self.number; [self loadKlineStr];
        };
        kLine.longActionBlock = ^(BOOL isHave, NSArray *obj){
            if (isHave) {
                if(obj.count>=13){
                    NSString *price = obj[10];
                    NSString *close = obj[13];
                    NSString *range = [JCLMarketObj JCLMarketRange:price close:close];
                    NSString *scale = [JCLMarketObj JCLMarketScale:range close:close];
                    self.naviga.priceLab.text = [NSString stringWithFormat:@"%@ (%@   %@)", [JCLMarketObj JCLMarketPrice:price.floatValue decimal:nil], range, scale];

                    self.naviga.numberLab.text = [NSString stringWithFormat:@"量: %@", [JCLMarketObj JCLMarketUnit:obj[11] decimal:nil style:2]];
                    
                    UIColor *infoCol = [JCLMarketObj JCLMarketColor:range];
                    self.naviga.priceLab.textColor = infoCol; self.naviga.rangeLab.textColor = infoCol; self.naviga.scaleLab.textColor = infoCol;
                    [self.naviga setNeedsLayout];
                }
            } else {
                [self setupNaviga:self.modelMarket];
            }
        };
        self.kLine = kLine;
    }
    [self loadKlineStr];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return self.idxArr.count; }
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ return self.table.height/7; }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JCLTableCell *cell = [JCLTableCell cellWithTableView:tableView style:UITableViewCellStyleDefault];
    cell.title.text = self.idxArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger idx = indexPath.row;
    NSString *idxStr = [NSString stringWithFormat:@"%ld", idx]; PreWrite(idxStr, JCLKLineIdx);
    self.idxType = idx;
    self.kLine.isIdx = YES;
    NSLog(@"%@",self.idxArr[idx]);
    [self loadKlineStr];
}

-(BOOL)prefersStatusBarHidden{ return YES; }
@end
