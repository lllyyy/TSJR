//
//  JCLMarketMore.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/12/7.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLMarketMore.h"
#import "JCLMarketOptionHeader.h"
#import "JCLMarketOptionCell.h"
#import "JCLStockMain.h"
#import "TSJRMarketOptionListModel.h"


@interface JCLMarketMore ()
@property (nonatomic, strong) NSString *sortId;
@property (nonatomic, strong) NSString *sort;
@property (nonatomic, assign) JCLMarketOptionHeader *header;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger num;


@end

@implementation JCLMarketMore
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navi.middle.title = @"中概股";
    [self.navi.right tapActionBlock:^{ [self loadData]; }];
    
    self.table = [JCLKitObj JCLTable:self.view target:self frame:CGRectMake(0, JCLNAVI, JCLWIDTH, JCLSCROLL) style:UITableViewStylePlain];
    self.table.backgroundColor =JCL_Bg_COL;
//    self.table.y = self.header.maxY, self.table.height = JCLHEIGHT - self.header.maxY;
//
    
    self.page = 1;
    self.num = 20;
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self loadData];
    }];
    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (self.vals.count >=self.num*self.page) {
            self.page++;
            [self loadData];
        }else{
            [self.table.mj_footer endRefreshingWithNoMoreData];
        }
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
     self.sortId = @"";
//    self.sort = @"1";
    
    [self loadData];
    AppDelegate.shareAppDelegate.timerAtionBlock = ^(NSTimer *timer) { [self loadData]; };
}

 

-(void)loadData{
    
//    /dataapi/categorySymbolNames?type=china&market=china&asc=0&sort=percent&page=0&num=20
    
    NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlE,@"categorySymbolNames"];
 
    [JCLHttps httpPOSTRequest:postUrl params:@{@"userId":userId(),@"type":@"china",@"market":@"china",@"asc":self.asc,@"sort":@"percent",@"page":@(self.page),@"num":@(self.num)} success:^(id obj) {
 
        MMResultV2Model *model =(MMResultV2Model *)obj;

        
        if (self.page == 1||(self.sortId.length>0)) {
            [self.vals removeAllObjects];
        }
        if (model.code.intValue == 200) {
            for (id objc in model.data) {
                TSJRMarketOptionListModel *m = [TSJRMarketOptionListModel modelWithDictionary:objc];
                [self.vals addObject:m];
                 self.sortId = @"";
            }
             [self.table reloadData];
       }
       
        [self.table.mj_header endRefreshing];
        [self.table.mj_footer endRefreshing];
     
    } failure:^(NSError *error) {
        [JCLFramework showErrorHud:@"服务器异常"];
        [self.table.mj_header endRefreshing];
        [self.table.mj_footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    
    
//    [JCLMarketDataObj JCLGetMarketSortInfo:JCLMarketURL page:self.page
//                                    number:self.num
//                                  mainType:self.main
//                                  sortType:self.sortId
//                                      info:@"1*0*6*3*2*4*5*36*10*146*145"
//                                      sort:self.sort
//                                   success:^(NSArray *obj) {
//                                       if (obj.count>0) {
//
//
//                                           if (obj.count > 3) {
//                                                [self.vals removeAllObjects];
//                                               [self.vals addObjectsFromArray:[JCLHttpsObj JCLHandleStr:obj begin:1 end:obj.count - 2]];
//                                           }
//                                           [self.table reloadData];
//                                           [self.table.mj_header endRefreshing]; [self.table.mj_footer endRefreshing];
//                                       }
//
//                                   } failure:^(NSError *error) {
//                                       [self.table.mj_header endRefreshing];
//                                       [self.table.mj_footer endRefreshing];
//
//                                   }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return self.vals.count; }
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ return 60; }

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    JCLMarketOptionHeader *header = [[JCLMarketOptionHeader alloc]init];
    header.frame = CGRectMake(0, JCLNAVI, JCLWIDTH, [JCLKitObj JCLHeight:44]); [self.view addSubview:header];
    header.isAction = YES;
    header.arr = @[@"名称", @"现价", @"涨跌幅"];
    self.header = header;
    header.menuActionBlock = ^(UILabel *idx, NSInteger sortIdx){
        
        if (sortIdx == 1) {
            self.asc = @"1";
             idx.attributedText = [self.header getAttStr:idx img:@"升序"];
        }else{
            self.asc = @"0";
             idx.attributedText = [self.header getAttStr:idx img:@"降序"];
        }
        self.page = 1;
        self.sortId = @"1";
        [self loadData];
    };
    return header;
};

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    JCLMarketOptionCell *cell = [JCLMarketOptionCell cellWithTable:tableView style:UITableViewCellStyleDefault];
 
        TSJRMarketOptionListModel *marr = self.vals[indexPath.row];
       cell.name.text =   marr.cn_name; //[NSString stringWithFormat:@"%@",[[AppDelegate shareAppDelegate].messageNoticeStore fetchMessage:marr.symbol]];;
 
        cell.code.text = marr.symbol;
        cell.price.text = [NSString stringWithFormat:@"%.2f",marr.price.floatValue];
    
   
    
    
//        NSString *range = [JCLMarketObj JCLMarketRange:marr.open close:marr.prevclose];
//    cell.riseFall.text =  [JCLMarketObj JCLMarketScale:range  close:marr.prevclose];//涨跌幅
//         cell.riseFall.textColor =[JCLMarketObj TSJRMarketColorA:marr.percent];
    
    cell.riseFall.text =  [JCLMarketObj JCLMarketPercent:marr.percent];
    if ([cell.riseFall.text containsString:@"+"]) {
        cell.riseFall.textColor =RoseColor;
    }else if([cell.riseFall.text containsString:@"-"]){
        cell.riseFall.textColor  = FallColor;
    }else{
        cell.riseFall.textColor  =GreyColor;
    }
     
//    cell.riseFall.textColor =[JCLMarketObj TSJRMarketColorA:marr.percent];
//        NSString *decimal = [JCLMarketObj JCLStockDecimal:arr[1]];
    
//        NSString *range = [JCLMarketObj JCLMarketRange:arr[2] close:arr[4] is:decimal];
//         NSString *scale = [JCLMarketObj JCLMarketScale:range close:arr[4]];
//        cell.riseFall.text = scale;
//        UIColor *color = [JCLMarketObj JCLMarketColor:range];
//        cell.price.textColor = color;
//        cell.riseFall.backgroundColor = color;
//    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JCLStockMain *vc = [[JCLStockMain alloc]init]; vc.arr = self.vals[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
