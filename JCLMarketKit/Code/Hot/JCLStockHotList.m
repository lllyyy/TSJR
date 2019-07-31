//
//  JCLStockHotList.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/12.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockHotList.h"
#import "JCLStockHotHead.h"
#import "JCLAStockRangeCell.h"
#import "JCLTodayRangeCell.h"
#import "JCLFirmRangeCell.h"

#import "JCLStockRankNotionCell.h"
#import "JCLStockRankMarketCell.h"
#import "JCLStockRankModel.h"
#import "JCLStockRankHistoryCell.h"

#import "JCLStockMain.h"

@interface JCLStockHotList ()
@property(nonatomic, strong) NSArray *headArr;
@property(nonatomic, strong) id AStockObj;
@property(nonatomic, strong) id TodayObj;
@property(nonatomic, strong) id FirmObj;

@property(nonatomic, strong) NSArray *notionArr;
@property(nonatomic, strong) NSArray *marketArr;

@property(nonatomic, strong) id historyObj;
@end

@implementation JCLStockHotList
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headArr = @[@"沪深A股涨跌分布", @"非一字板涨停今日平均涨跌幅", @"涨跌停家数", @" ", @"  ", @"  "];
//    view *v = [[view alloc]init];
//    v.imgArr = @[@"http://mpic.tiankong.com/377/e7b/377e7bdf4a40f8d65a657741cdf2260d/640.jpg?x-oss-process=image/resize,m_lfit,h_600,w_600/watermark,image_cXVhbmppbmcucG5n,t_90,g_ne,x_5,y_5"];
//    self.table.tableHeaderView = v;
    
    //self.timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timeAction) userInfo:nil repeats:YES]; [self.timer fire];
    [self timeAction];
}

-(void)timeAction{
    [self loadAStockRange];
    [self loadMarketData];
    [self loadHistoryData];
}

-(void)loadAStockRange{
    NSString *url = [NSString stringWithFormat:@"%@/freehqwebserver/zdfdata?start=0&num=30&type=0&sorttype=1&coltype=1", bc1Url];
    [JCLHttpsObj JCLGetJson:url success:^(id obj) {
        self.AStockObj = obj; self.TodayObj = obj; self.FirmObj = obj;
    } failure:^(NSError *error) { }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{ return self.headArr.count; }
-(nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    JCLStockHotHead *head = [[JCLStockHotHead alloc]init]; head.text.text = self.headArr[section];
    return head;
};

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{ return 38; }

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return 1; }
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    switch (indexPath.section) {
        case 0: cell = [self AStockRange:tableView]; break;
        case 1: cell = [self TodayRange:tableView]; break;
        case 2: cell = [self FirmRange:tableView]; break;
        case 3: cell = [self NotionCell:tableView]; break;
        case 4: cell = [self HistoryCell:tableView]; break;
        case 5: cell = [self MarketCell:tableView]; break;
        default: break;
    }
    return cell;
}

-(UITableViewCell *)AStockRange:(UITableView *)table{
    JCLAStockRangeCell *cell = [JCLAStockRangeCell cellWithTable:table style:UITableViewCellStyleDefault];
    id obj = self.AStockObj;
    if (obj) {
        NSMutableArray *arrM = [[NSMutableArray alloc]init];
        NSArray *riseArr = obj[@"znums"], *fallArr = obj[@"dnums"];
        [[[riseArr reverseObjectEnumerator] allObjects] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx<riseArr.count-1) { [arrM addObject:[NSString stringWithFormat:@"%@", obj]]; }
        }];
        [fallArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx>0) { [arrM addObject:[NSString stringWithFormat:@"%@", obj]]; }
        }];
        [arrM insertObject:[NSString stringWithFormat:@"%@", riseArr[0]] atIndex:riseArr.count-1];
        cell.keyArr = @[[NSString stringWithFormat:@"上涨(%@)", [riseArr valueForKeyPath:@"@sum.floatValue"]],
                        [NSString stringWithFormat:@"平盘(%@)", riseArr[0]],
                        [NSString stringWithFormat:@"下跌(%@)", [fallArr valueForKeyPath:@"@sum.floatValue"]]];
        cell.arr = arrM;
        self.AStockObj = nil;
    }
    return cell;
}

-(UITableViewCell *)TodayRange:(UITableView *)table{
    JCLTodayRangeCell *cell = [JCLTodayRangeCell cellWithTable:table style:UITableViewCellStyleDefault];
    id obj = self.TodayObj;
    if (obj) {
        cell.idx = [obj[@"subindex"] integerValue];
        cell.arr = obj[@"azd"];
        self.TodayObj = nil;
    }
    return cell;
}
-(UITableViewCell *)FirmRange:(UITableView *)table{
    JCLFirmRangeCell *cell = [JCLFirmRangeCell cellWithTable:table style:UITableViewCellStyleDefault];
    id obj = self.FirmObj;
    if (obj) {
        cell.idx = [obj[@"subindex"] integerValue];
        cell.riseArr = obj[@"ztjs"];
        cell.fallArr = obj[@"dtjs"];
        self.FirmObj = nil;
    }
    return cell;
}

-(void)loadMarketData{
    NSString *url = [NSString stringWithFormat:@"%@/data_lhb/servlet/PageDeptCompanyThemesServlet?companyid=%@&type=1", lhurl, @"80033681"];
    [JCLHttpsObj JCLGetJson:url success:^(id obj) {
        if (obj) {
            self.notionArr = [JCLStockRankModel mj_objectArrayWithKeyValuesArray:obj[@"themes"]];
            self.marketArr = [JCLStockRankModel mj_objectArrayWithKeyValuesArray:obj[@"industries"]];
            [self.table reloadData];
        }
    } failure:^(NSError *error) { }];
}
-(UITableViewCell *)NotionCell:(UITableView *)table{
    JCLStockRankNotionCell *cell = [JCLStockRankNotionCell cellWithTable:table style:UITableViewCellStyleDefault];
    if (self.notionArr.count) { cell.arr = self.notionArr; self.notionArr = nil; }
    cell.tapAction = ^(NSArray *arr){
        JCLStockMain *list = [[JCLStockMain alloc]init]; list.arr = arr;
        [self.navigationController pushViewController:list animated:YES];
    };
    return cell;
}
-(UITableViewCell *)MarketCell:(UITableView *)table{
    JCLStockRankMarketCell *cell = [JCLStockRankMarketCell cellWithTable:table style:UITableViewCellStyleDefault];
    if (self.marketArr.count) { cell.arr = self.marketArr; self.marketArr = nil; }

    return cell;
}

-(void)loadHistoryData{
    NSString *url = [NSString stringWithFormat:@"%@/data_lhb/servlet/PageDeptCompanyDataServlet?companyid=%@&type=1", lhurl, @"80033681"];
    [JCLHttpsObj JCLGetJson:url success:^(id obj) { self.historyObj = obj;
    } failure:^(NSError *error) {  }];
}
-(UITableViewCell *)HistoryCell:(UITableView *)table{
    JCLStockRankHistoryCell *cell = [JCLStockRankHistoryCell cellWithTable:table style:UITableViewCellStyleDefault];
    id obj = self.historyObj;
    if (obj) {
        NSString *val = obj[@"times_buy"];
        NSString *info = [NSString stringWithFormat:@"上榜次数: %@次", val];
        cell.info.attributedText = [JCLKitObj RXAttStr:info color:JCLRGBA(253, 205, 42, 47) endIdx:val.length+1];
        cell.rangeArr = @[obj[@"changepercent_1day_avg"], obj[@"changepercent_3day_avg"], obj[@"changepercent_5day_avg"],
                          obj[@"changepercent_10day_avg"]];
        
        cell.scaleArr = @[obj[@"probability_rise_1day"], obj[@"probability_rise_3day"], obj[@"probability_rise_5day"],
                          obj[@"probability_rise_10day"]];
        self.historyObj = nil;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ return 244; }
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{ return 10; }
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
@end
