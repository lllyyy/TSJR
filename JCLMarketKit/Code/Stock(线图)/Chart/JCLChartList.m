//
//  StockChartMenu.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/17/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "JCLChartList.h"
#import "JCLBaseMenu.h"
#import "JCLTimeChart.h"
#import "JCLKLineChart.h"
#import "JCLIdxMenu.h"
#import "JCLTableCell.h"
#import "YGCollectMenu.h"
#import <JCLKlineIdxLib/JCLKlineIdxObj.h>
#import "TSJRRealTimeMarket.h"


@interface JCLChartList()
@property (nonatomic, weak) JCLBaseMenu *menu;
@property (nonatomic, weak) UIButton *minute;
@property (nonatomic, weak) UIView *line;
@property (nonatomic, weak) JCLTimeChart *time;
@property (nonatomic, weak) JCLKLineChart *kLine;
@property (nonatomic, weak) JCLIdxMenu *idxMenu;

@property (nonatomic, strong) UIView *popView;
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSArray *popArray;

@property (nonatomic, strong) UIButton *authBut;
@property (nonatomic, assign) NSInteger authType;
@property (nonatomic, strong) NSString *authStr;
@property (nonatomic, strong) UIButton *idxBut;
@property (nonatomic, assign) NSInteger idxType;
@property (nonatomic, strong) NSString *idxStr;

@property (nonatomic, strong) NSString *timeType; // KLine 时间类型
@property (nonatomic, strong) NSArray *kLineArr;
@property (nonatomic, strong) NSString *idxStyle;

@property(nonatomic, strong) NSArray *minuteArr;
@property(nonatomic, strong) NSArray *idxArr;
@property(nonatomic, strong) NSMutableArray *arrM;

@property (nonatomic, weak) YGCollectMenu *idxBox;
@property (nonatomic, weak) UIView *line1;
@property (nonatomic, strong) NSArray *times;
@end

@implementation JCLChartList
-(instancetype)initWithFrame:(CGRect)frame{ if (self = [super initWithFrame:frame]) { self.backgroundColor = JCL_Cell_COL; } return self; }
-(void)drawRect:(CGRect)rect{
    self.times = [JCLMarketObj JCLStockTimes:self.code];
    
    NSLog(@"--%@",self.times);
    
    self.minuteArr = @[@"1分钟", @"5分钟", @"15分钟", @"30分钟", @"60分钟"];
    self.idxArr = @[@"VOL",@"CCI",@"MACD",@"KDJ",@"RSI",@"PSY",@"WR",@"ASI",@"OBV",@"ROC",@"VR",
                    @"DMI",@"DMA",@"FSL",@"TRIX", @"BRAR",@"CR",@"EMV",@"WVAD",@"MTM",@"BOLL"];
    
    NSArray *arr = @[@"分时", @"日K", @"周K", @"月K"];
    CGFloat w = self.width/(arr.count+1), h = [JCLKitObj JCLHeight:40];
    JCLBaseMenu *menu = [[JCLBaseMenu alloc]init]; [self addSubview:menu];
    menu.frame = CGRectMake(0, 0, self.width-w, h); menu.backgroundColor = JCL_Cell_COL;
    menu.style = MenuStyleIdxLine; menu.isAction = YES;
    NSString *idx = PreRead(JCLKLine); menu.idx = idx.integerValue<4 ? idx.integerValue : 4444;
    menu.arr = arr;
    menu.tapActionBlock = ^(NSInteger idx){
        self.authType = 0; self.menu.idxLine.hidden = NO; self.line.hidden = YES;
        self.minute.title = @"分钟"; self.minute.color = JCL_Text_COL;
        NSString *idxStr = [NSString stringWithFormat:@"%ld", (long)idx];
        PreWrite(idxStr, JCLKLine);
        switch (idx) {
            case 1: self.timeType = @"day"; break;
            case 2: self.timeType = @"week"; break;
            case 3: self.timeType = @"month"; break;
            default: break;
        }
        idx == 0 ? [self drawTimeChart] : [self drawKLineChart];
    };
    self.menu = menu;
    
    UIButton *minute = [JCLKitObj JCLButton:self img:nil size:14 target:self action:@selector(minuteAction)];
    minute.title = @"分钟";  minute.backgroundColor = JCL_Cell_COL;
    minute.frame = CGRectMake(menu.maxX, 0, w, h);
    self.minute = minute;
    self.line = [JCLKitObj JCLView:self color:JCL_SelText_COL];
    CGFloat lineW = 0.68*w, lineX = 0.5*(w-lineW), lineH = 1;
    self.line.frame = CGRectMake(menu.maxX+lineX, h-lineH, lineW, lineH);
    if (idx.integerValue>=4) { [self minuteVal:idx.integerValue-4]; [self drawKLineChart]; }
    
    self.line1 = [JCLKitObj JCLView:self color:JCL_Bg_COL];
    self.line1.frame = CGRectMake(0, self.menu.maxY, self.width, 1);
}

-(void)minuteVal:(NSInteger)idx{
    self.menu.idxLine.hidden = YES; self.line.hidden = NO;
    self.menu.select.text.textColor = JCL_Text_COL; self.menu.hisIdx = 4444;
    self.minute.title = self.minuteArr[idx]; self.minute.color = JCL_SelText_COL;
    NSArray *arr = @[@"1min", @"5min", @"15min", @"30min", @"60min"];
    self.timeType = arr[idx];
}
-(void)minuteAction{
    self.type = 1;
    self.popArray = self.minuteArr;
    [self drawPopMenu];
    
}

-(void)loadTime{
    if (self.code.length) {
        NSLog(@"-=-=-=-= %@",self.code);
    }
 
    
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
            self.time.close = @"30";
            
            self.time.arr =array;
        }
        
    } failure:^(NSError *error) {
     
    }];
    
 
}

-(NSMutableArray *)arrM{
    if (_arrM)
        return _arrM;
    return _arrM = [[NSMutableArray alloc]init];
    
}
-(void)loadKlineStr{
    
//    / quoteapi / kline
//    获取ķ线数据
//     (day: 日K,week: 周K,month:月K ,year:年K,1min:1分钟,5min:5分钟,15min:15分钟,30min:30分钟,60min:60分钟)
    
    NSMutableArray *array = [NSMutableArray new];
    NSString *postUrlA = [NSString stringWithFormat:@"%@/%@",baseApiURlC,@"kline"];
    [JCLHttps httpPOSTRequest:postUrlA params:@{@"userId":userId(),@"limit":@"1000",@"period":self.timeType,@"symbols":self.code} success:^(id obj) {
        MMResultModel *model = obj;
         NSLog(@"-=--modelmodel-=-=-= %@",model.data);
        if (model.code.integerValue == 200) {
            for(id objc in model.data[0][@"items"]) {
                NSLog(@"objcobjc %@",objc);
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
 
            self.arrM = array;
              if (self.arrM.count) {
              [self klineData];
           }
        }
       
    } failure:^(NSError *error) {
        [JCLFramework showErrorHud:@"服务器异常"];
        
    }];
 
}

-(void)klineData{
    NSLog(@"arrMarrM  %@",self.arrM);
    self.kLine.MAArr = [JCLKlineIdxObj InitMAData:self.arrM idx:5];
    self.kLine.isMinute = self.timeType.integerValue <100 ? YES : NO;
    self.kLine.idxStyle = (JCLKLineIdxStyle)self.idxType;
    
    if (self.idxType>0) {
       
        NSLog(@"timeType%@  %@   %@",self.timeType,self.idxArr[self.idxType],self.arrM);
        self.kLine.idxArr =  [JCLKlineIdxObj InitIdxData:self.arrM kline:self.timeType idx:self.idxArr[self.idxType]];
    }else{
        
       self.kLine.idxArr =  [JCLKlineIdxObj InitMAData:self.arrM idx:6];
    }
    self.kLine.arr = self.arrM;
}

-(UIButton *)drawIndex:(CGFloat)idxY text:(NSString *)text action:(SEL)action{
    UIButton *button = [JCLKitObj JCLButton:self.kLine img:@"" size:11 target:self action:action];
    button.title = text; button.color = JCL_SelText_COL;
    CGFloat s = 4, w = 0.13*self.kLine.width, h = 0.66*(0.1*self.kLine.height), y = 0.5*(0.1*self.kLine.height - h);
    button.frame = CGRectMake(self.kLine.width - w - s, y + idxY, w, h);
    button.layer.cornerRadius = 4; button.layer.borderWidth = 1.2; button.layer.borderColor = JCL_SelText_COL.CGColor;
    return button;
}

-(void)drawTimeChart{
    [self.kLine removeFromSuperview]; self.kLine = nil;
    if (self.time == nil) {
        JCLTimeChart *time = [[JCLTimeChart alloc]init];
        time.decimal = self.decimal;
        time.times = self.times;
        CGFloat s = 4;
        time.frame = CGRectMake(s, self.menu.height + s, self.width - 2*s, self.height - self.menu.height - 2*s);
        [self addSubview:time];
        self.time = time;
    }
    [self loadTime];
}

-(void)drawKLineChart{
    [self.time removeFromSuperview]; self.time = nil;
    if (self.kLine == nil) {
        JCLKLineChart *kLine = [[JCLKLineChart alloc]init]; [self addSubview:kLine];
        CGFloat s = 4; kLine.isScroll = NO;
        kLine.frame = CGRectMake(s, self.menu.maxY + s, self.width - 2*s, self.height - self.menu.maxY - 2*s);
        kLine.decimal = self.decimal;
        kLine.longActionBlock = ^(BOOL isHave, NSArray *obj){ !self.longActionBlock ? : self.longActionBlock(isHave, obj); };
        self.kLine = kLine;
        
//        if (![JCLMarketObj JCLMarketIdx:self.code]) {
//            self.authBut = [self drawIndex:0 text:@"不复权" action:@selector(authorAction)];
//        }
//
        NSString *idx = PreRead(JCLKLineIdx), *text = @"";
        if (idx.length) {
            self.idxType = idx.integerValue; text = self.idxArr[idx.integerValue];
        } else {
            text = @"VOL";
        }
        self.idxBut = [self drawIndex:0.66*self.kLine.height text:text action:@selector(indexAction)];
    }
    [self loadKlineStr];
}

-(void)authorAction{
    self.type = 2; self.popArray = @[@"前复权", @"后复权", @"不复权"];
    [self drawPopMenu];
}

-(void)indexAction{
    self.type = 3; self.popArray = self.idxArr;
    
    self.popView = [JCLKitObj JCLView:[AppDelegate shareAppDelegate].window color:JCLRGBA(0, 0, 0, 0.1)];
    self.popView.frame = CGRectMake(0, 0, JCLWIDTH, JCLHEIGHT);
    [self.popView tapActionBlock:^{
        [self.popView removeFromSuperview];  [self.idxBox removeFromSuperview];
    }];
    
    YGCollectMenu *menu = [[YGCollectMenu alloc]init]; [[AppDelegate shareAppDelegate].window addSubview:menu];
    menu.arr = self.popArray;
    CGFloat h = 0.3*JCLHEIGHT;
    menu.frame = CGRectMake(0, 0.5*(JCLHEIGHT-h), self.width, h);
    menu.selectActionBlock = ^(NSDictionary *dic){
        NSInteger idx = [dic[@"id"] integerValue];
        NSString *idxStr = [NSString stringWithFormat:@"%ld", idx];
        PreWrite(idxStr, JCLKLineIdx);
        self.idxType = idx;
        self.idxBut.title = self.popArray[idx];
        [self drawKLineChart];
        [self.idxBox removeFromSuperview]; [self.popView removeFromSuperview];
    };
    self.idxBox = menu;
}

-(void)removeAction{
    [self.popView removeFromSuperview]; [self.idxBox removeFromSuperview];
}

-(void)drawPopMenu{
    self.popView = [JCLKitObj JCLView:self color:JCLRGBA(0, 0, 0, 0) target:self action:@selector(tapAction)];
    self.popView.frame = self.bounds;
    
    CGFloat s = 6, w = 0.15*self.width, x = self.width - w - s, h = 0.74*self.menu.height*self.popArray.count, y = self.kLine.y;
    if (self.type == 1) {
        w = 0.2*self.width - s, x = self.width - w - s, h = (self.menu.height-s)*self.popArray.count, y = self.menu.maxY;
    } else if (self.type == 2) { y = y + 0.1*self.kLine.height;
    } else { y = y + 0.66*self.kLine.height; }
    UITableView *table = [JCLKitObj JCLTable:self target:self frame:CGRectMake(x, y, w, 0) style:UITableViewStylePlain];
    table.backgroundColor = JCL_Cell_COL;
    table.layer.cornerRadius = 6;
    table.layer.borderWidth = 1; table.layer.borderColor = JCL_Line_COL.CGColor;
    self.table = table;
    
    [UIView animateWithDuration:0.4 delay:0.1 options:0 animations:^{
        if (self.type == 3) {
            self.table.frame = CGRectMake(x, self.kLine.y + 0.66*self.kLine.height - h, w, h);
        } else {
            self.table.frame = CGRectMake(x, y, w, h);
        }
    } completion:^(BOOL finished) { }];
}

-(void)tapAction{
    
    [self removeMenu];
    [self.idxMenu removeFromSuperview];
    
}
-(void)removeMenu{
    [UIView animateWithDuration:0.4 delay:0.1 options:0 animations:^{
        CGFloat y = 0.00;
        if (self.type == 1) {
            y = self.menu.maxY;
        } else if (self.type == 2) {
            y = self.kLine.y + 0.1*self.kLine.height;
        } else {
            y = self.kLine.y + 0.66*self.kLine.height;
        }
        self.table.frame = CGRectMake(self.table.x, y, self.table.width, 0);
    } completion:^(BOOL finished) {
        [self.popView removeFromSuperview]; [self.table removeFromSuperview]; self.table = nil;
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return self.popArray.count; }
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JCLTableCell *cell = [JCLTableCell cellWithTableView:tableView style:UITableViewCellStyleDefault];
    cell.title.text = self.popArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == 1) {
        return self.menu.height - 6;
    } else {
        return 0.74*self.menu.height;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == 1) {
        NSString *idxStr = [NSString stringWithFormat:@"%ld", indexPath.row+4];
        PreWrite(idxStr, JCLKLine);
        [self minuteVal:indexPath.row];
    } else if (self.type == 2) {
        switch (indexPath.row) {
            case 0: self.authType = 1; break;
            case 1: self.authType = 2; break;
            case 2: self.authType = 0; break;
            default: break;
        } self.authBut.title = self.popArray[indexPath.row];
    }
    [self drawKLineChart];
    [self.table removeFromSuperview]; [self.popView removeFromSuperview]; self.table = nil;
}

-(void)setNeedData{ self.time ? [self drawTimeChart] : [self drawKLineChart]; }
@end
