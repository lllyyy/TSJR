//
//  QuotationRangeMore.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/11/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "JCLMarketInfoList.h"
#import "JCLMarketPlateHeader.h"
#import "JCLMarketInfoHeader.h"
#import "JCLMarketInfoCell.h"
#import "JCLStockMain.h"

@interface JCLMarketInfoList ()<UIScrollViewDelegate>
@property(nonatomic,strong)NSString *code;
@property(nonatomic, weak) JCLMarketInfoHeader *header;
@property (nonatomic, strong) NSMutableArray *cellArrM;
@property(nonatomic, assign) BOOL isScroll;

@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)NSInteger number;
@property(nonatomic,assign)BOOL isCount;
@property(nonatomic, assign) NSInteger sort;
@property(nonatomic, strong)JCLMarketPlateHeader *infoPlate;
@end

@implementation JCLMarketInfoList
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navi.middle.title = self.textNav; self.page = 0; self.number = 20; self.sort = 1; CGFloat y = 0.00;
    if (self.isPlate) {
        self.code = self.array[1]; self.navi.middle.title = self.array[0]; self.navi.subMiddle.title = self.code;
        JCLMarketPlateHeader *infoHeader = [[JCLMarketPlateHeader alloc]init]; [self.view addSubview:infoHeader];
        infoHeader.frame = CGRectMake(0, 64, JCLWIDTH, 66);
        self.infoPlate = infoHeader;
        switch (self.plateType) {
            case PlateOfIndustry: self.mainType = @"200"; self.plateType = 0;  break;
            case PlateOfConcept:  self.mainType = @"300"; self.plateType = 1;  break;
            case PlateOfRegion:   self.mainType = @"100"; self.plateType = 2;  break;
            default: break;
        } y = infoHeader.maxY;
        
        infoHeader.pushActionBlock = ^(){ [self pushStock:@[[JCLMarketObj JCLStockInfo:self.code][3], self.code]]; };
    } else{ y = 64; if(self.QuotatType == QuotatOfFall){ self.sort = 2; } }
    
    JCLMarketInfoHeader *header = [[JCLMarketInfoHeader alloc]init]; [self.view addSubview:header];
    header.frame = CGRectMake(0, y, JCLWIDTH, 40);
    header.idx = 2;
    if (self.isPlate) {
        header.idx = 1;
    }
    if (self.QuotatType == QuotatOfFall) {
        header.count = 1;
    }
    if (self.isCapital) { header.textArr = @[@"现价", @"涨跌幅", @"资金", @"涨跌", @"昨收", @"开盘", @"最高", @"最低", @"总手", @"总额"];
    } else if (self.QuotatType == QuotatOfTurnover) {
        header.textArr = @[@"现价", @"涨跌幅", @"换手", @"涨跌", @"昨收", @"开盘", @"最高", @"最低", @"总手", @"总额"];
    } else if (self.QuotatType == QuotatOfDeal) {
        header.textArr = @[@"现价", @"涨跌幅", @"总额", @"涨跌", @"昨收", @"开盘", @"最高", @"最低", @"总手", @"换手"];
    } else if (self.QuotatType == QuotatOfIndustry || self.QuotatType == QuotatOfConcept || self.QuotatType == QuotatOfRegion){
        header.idx = 1;
        header.textArr = @[@"现价", @"涨跌幅", @"涨跌", @"昨收", @"开盘", @"最高", @"最低", @"总手", @"总额"];
    } else{
        header.idx = 1;
        header.textArr = @[@"现价", @"涨跌幅", @"涨跌", @"昨收", @"开盘", @"最高", @"最低", @"总手", @"总额", @"换手"];
    }
    
    header.slideActionBlock =^(UIScrollView *scroll){ [self scrollViewDidScroll:scroll]; };
    header.codeActionBlock = ^(NSInteger idx){ [self codeSort:idx]; };
    header.riseActionBlock =^(NSInteger idx){
        self.sort = 1; [self sortType:idx]; };
    header.dropActionBlock =^(NSInteger idx){
        
        self.sort = 2; [self sortType:idx];
    
    }; self.header = header;
    
    self.table.y = self.header.maxY, self.table.height = JCLHEIGHT - self.header.maxY;

    [self loadData];
    [self realTimeRefresh];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate.shareAppDelegate.timerAtionBlock = ^() {
        [self realTimeRefresh];
    };
}

-(void)codeSort:(NSInteger)idx{
    switch (idx) {
        case 1: self.sort = 1; self.sortType = @"0"; break;
        case 2: self.sort = 2; self.sortType = @"0"; break;
        default: break; }
    [self loadData];
}

-(void)sortType:(NSInteger)idx{
    if (self.isCapital) {
        if (self.QuotatType == QuotatOfInflow) {
            switch (idx) {
                case 0: self.sortType = @"6";  break; case 1: self.sortType = @"14"; break; case 2: self.sortType = @"146"; break;
                case 3: self.sortType = @"12"; break; case 4: self.sortType = @"2";  break; case 5: self.sortType = @"6"; break;
                case 6: self.sortType = @"4";  break; case 7: self.sortType = @"5";  break; case 8: self.sortType = @"9"; break;
                case 9: self.sortType = @"10"; break; default: break; }
        } else if (self.QuotatType == QuotatOfFlowOu) {
            switch (idx) {
                case 0: self.sortType = @"6";  break; case 1: self.sortType = @"14"; break; case 2: self.sortType = @"145"; break;
                case 3: self.sortType = @"12"; break; case 4: self.sortType = @"2";  break; case 5: self.sortType = @"6"; break;
                case 6: self.sortType = @"4";  break; case 7: self.sortType = @"5";  break; case 8: self.sortType = @"9"; break;
                case 9: self.sortType = @"10"; break; default: break; }
        } else {
            switch (idx) {
                case 0: self.sortType = @"6";  break; case 1: self.sortType = @"14"; break; case 2: self.sortType = @"205"; break;
                case 3: self.sortType = @"12"; break; case 4: self.sortType = @"2";  break; case 5: self.sortType = @"6"; break;
                case 6: self.sortType = @"4";  break; case 7: self.sortType = @"5";  break; case 8: self.sortType = @"9"; break;
                case 9: self.sortType = @"10"; break; default: break; }
        }
    } else if (self.QuotatType == QuotatOfTurnover) {
        switch (idx) {
            case 0: self.sortType = @"6";  break; case 1: self.sortType = @"14"; break; case 2: self.sortType = @"36"; break;
            case 3: self.sortType = @"12"; break; case 4: self.sortType = @"2";  break; case 5: self.sortType = @"6"; break;
            case 6: self.sortType = @"4";  break; case 7: self.sortType = @"5";  break; case 8: self.sortType = @"9"; break;
            case 9: self.sortType = @"10"; break; default: break; }
    } else if (self.QuotatType == QuotatOfDeal) {
        switch (idx) {
            case 0: self.sortType = @"6";  break; case 1: self.sortType = @"14"; break; case 2: self.sortType = @"10"; break;
            case 3: self.sortType = @"12"; break; case 4: self.sortType = @"2";  break; case 5: self.sortType = @"6"; break;
            case 6: self.sortType = @"4";  break; case 7: self.sortType = @"5";  break; case 8: self.sortType = @"9"; break;
            case 9: self.sortType = @"36"; break; default: break; }
    } else {
        switch (idx) {
            case 0: self.sortType = @"6"; break;  case 1: self.sortType = @"14"; break; case 2: self.sortType = @"12"; break;
            case 3: self.sortType = @"2"; break;  case 4: self.sortType = @"6"; break;  case 5: self.sortType = @"4"; break;
            case 6: self.sortType = @"5"; break;  case 7: self.sortType = @"9"; break;  case 8: self.sortType = @"10"; break;
            case 9: self.sortType = @"36"; break; default: break; }
    } [self loadData];
}

- (void)realTimeRefresh{
    if (self.isPlate) {
        NSString *code = self.array[1];
        [JCLStockDataObj JCLGetStockInfo:JCLMarketURL code:code
                                 success:^(NSArray *obj) {
                                     self.infoPlate.arr = [JCLHttpsObj JCLHandleStr:obj begin:3 end:obj.count - 4][0]; [self.infoPlate setNeedsDisplay];
                                 } failure:^(NSError *error) { }];
    }
    [self loadData];
}

-(void)loadData{
    if (self.isPlate){
        // 获取市场排序后的信息
        [JCLMarketDataObj JCLGetMarketSortInfo:JCLMarketURL page:(long)self.page
                                        number:(long)self.number
                                      mainType:self.mainType
                                      sortType:self.sortType
                                          info:@"1*0*6*3*2*4*5*9*10*36*146*145*205"
                                          sort:[NSString stringWithFormat:@"%ld", (long)self.sort]
                                          code:self.code
                                       success:^(NSArray *obj) {
                                           NSArray *arr = [JCLHttpsObj JCLHandleStr:obj begin:1 end:obj.count - 2];
                                           if (arr.count) {
                                               [self.arrM removeAllObjects]; [self.arrM addObjectsFromArray:arr]; self.isCount = YES;
                                               [self.table reloadData];
                                           } else {
                                            self.isCount = NO; self.page -= 20;
                                           }
                                           [self.table.mj_header endRefreshing];
                                          if( self.arrM.count<self.number)
                                          {
                                              [self.table.mj_footer endRefreshingWithNoMoreData];
                                          }else{
                                              [self.table.mj_footer endRefreshing];
                                          }
                                       } failure:^(NSError *error) {
                                           [self.table.mj_header endRefreshing]; [self.table.mj_footer endRefreshing];
                                       }];
    } else {
        // 获取市场排序后的信息
        [JCLMarketDataObj JCLGetMarketSortInfo:JCLMarketURL page:(long)self.page
                                        number:(long)self.number
                                      mainType:self.mainType
                                      sortType:self.sortType
                                          info:@"1*0*6*3*2*4*5*9*10*36*146*145*205"
                                          sort:[NSString stringWithFormat:@"%ld", (long)self.sort]
                                       success:^(NSArray *obj) {
                                           NSArray *arr = [JCLHttpsObj JCLHandleStr:obj begin:1 end:obj.count - 2];
                                           if (arr.count) {
                                               [self.arrM removeAllObjects]; [self.arrM addObjectsFromArray:arr]; self.isCount = YES;
                                               [self.table reloadData];
                                           } else {
                                               self.isCount = NO; self.page -= 20;
                                           }
                                           [self.table.mj_header endRefreshing];
                                           if( self.arrM.count<self.number)
                                           {
                                               [self.table.mj_footer endRefreshingWithNoMoreData];
                                           }else{
                                               [self.table.mj_footer endRefreshing];
                                           }
                                       } failure:^(NSError *error) {
                                           [self.table.mj_header endRefreshing]; [self.table.mj_footer endRefreshing]; }];
        
    }
}

-(NSMutableArray *)cellArrM{ if (_cellArrM) return _cellArrM; return _cellArrM = [[NSMutableArray alloc]init]; }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return self.arrM.count;}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JCLMarketInfoCell *cell = [JCLMarketInfoCell cellWithTableView:tableView style:UITableViewCellStyleDefault];
    id obj = self.arrM[indexPath.row];
    cell.title.text = obj[0]; cell.code.text = obj[1];
    cell.scroll.delegate = self;
    NSString *decimal = @"2";
    NSString *price = [JCLMarketObj JCLMarketPrice:[obj[2] floatValue] decimal:decimal] ;
    
    NSString *close = obj[4];
    NSString *range = [JCLMarketObj JCLMarketRange:price close:close is:decimal];
    NSString *scale = [JCLMarketObj JCLMarketScale:range close:close];
    NSString *turno = [NSString stringWithFormat:@"%@%%", obj[9]];
    
    close = [JCLMarketObj JCLMarketPrice:[obj[4] floatValue] decimal:decimal];
    NSString *open = [JCLMarketObj JCLMarketPrice:[obj[3] floatValue] decimal:decimal];
    NSString *height = [JCLMarketObj JCLMarketPrice:[obj[5] floatValue] decimal:decimal];
    NSString *low = [JCLMarketObj JCLMarketPrice:[obj[6] floatValue] decimal:decimal];
    NSString *number = [JCLMarketObj JCLMarketUnit:obj[7] decimal:decimal style:2];
    NSString *money = [obj[8] floatValue] == 0 ? @"0.00" : [JCLMarketObj JCLMarketUnit:obj[8] decimal:decimal style:2];
    if (self.isCapital) {
        if (self.QuotatType == QuotatOfInflow) {
            cell.arr = @[price, scale, [JCLMarketObj JCLMarketUnit:obj[10] decimal:decimal style:2], range, close, open, height, low, number, money];
        } else if (self.QuotatType == QuotatOfFlowOu) {
            cell.arr = @[price, scale, [JCLMarketObj JCLMarketUnit:obj[11] decimal:decimal style:2], range, close, open, height, low, number, money];
        } else { cell.arr = @[price, scale, [JCLMarketObj JCLMarketUnit:obj[12] decimal:decimal style:2], range, close, open, height, low, number, money]; }
    } else if (self.QuotatType == QuotatOfTurnover) { cell.arr = @[price, scale, turno, range, close, open, height, low, number, money];
    } else if (self.QuotatType == QuotatOfDeal) { cell.arr = @[price, scale, money, range, close, open, height, low, number, turno];
    } else if (self.QuotatType == QuotatOfIndustry || self.QuotatType == QuotatOfConcept || self.QuotatType == QuotatOfRegion){
        cell.arr = @[price, scale, range, close, open, height, low, number, money];
    } else {
        cell.arr = @[price, scale, range, close, open, height, low, number, money, turno];
    }
    
    cell.actionBlock = ^(){ [self pushPlate:self.arrM[indexPath.row]]; };
    [self.cellArrM addObject:cell.scroll];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.table) {
    } else {
        [self.header.scroll setContentOffset:scrollView.contentOffset];
        for (UIScrollView *scroll in self.cellArrM){ [scroll setContentOffset:scrollView.contentOffset];}
    }
}

-(void)pushPlate:(NSArray *)arr{
    if (self.QuotatType == QuotatOfIndustry) { [self pushPlate:arr type:PlateOfIndustry];
    } else if (self.QuotatType == QuotatOfConcept) { [self pushPlate:arr type:PlateOfConcept];
    } else if (self.QuotatType == QuotatOfRegion) { [self pushPlate:arr type:PlateOfRegion];
    } else { [self pushStock:arr]; }
}
-(void)pushPlate:(NSArray *)arr type:(QuotatPlateType)type{
    JCLMarketInfoList *vc = [[JCLMarketInfoList alloc]init]; vc.isPlate = YES; vc.plateType = type; vc.array = arr;
    vc.isCapital = self.isCapital;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ return [JCLKitObj JCLHeight:54]; }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{ [self pushPlate:self.arrM[indexPath.row]]; }

-(void)pushStock:(NSArray *)arr{
    JCLStockMain *vc = [[JCLStockMain alloc]init]; vc.arr = arr; [self.navigationController pushViewController:vc animated:YES];
}
@end
