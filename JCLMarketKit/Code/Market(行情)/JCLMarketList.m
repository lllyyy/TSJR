//
//  QuotationController.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/9/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "JCLMarketList.h"
#import "JCLMarketHeader.h"
#import "JCLMarketHead.h"
#import "JCLMarketPlateCell.h"
#import "JCLMarketRankCell.h"
#import "JCLMarketMore.h"
#import "TSJRMarketHeaderModel.h"
#import "TSJRStokeCoderModel.h"
#import "TSJRRealTimeMarket.h"
#import "TSJRMarketOptionListModel.h"
//行情列表页面
@interface JCLMarketList ()
@property (nonatomic, strong) JCLMarketHeader *header;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSString *mainField;
@property (nonatomic, strong) NSString *sortField;
@property (nonatomic, strong) NSString *sortState;

@property (nonatomic, strong) NSArray *idxArr; // 指数
@property (nonatomic, strong) NSMutableArray *hotArr; // 热门
@property (nonatomic, strong) NSMutableArray *roseArr; // 涨幅
@property (nonatomic, strong) NSMutableArray *fallArr; // 跌幅
@property (nonatomic, strong) NSMutableArray *codeArray; //所以股票代码

//@property (nonatomic, strong) NSArray *concepts; // 概念
//@property (nonatomic, strong) NSArray *regionArr; // 地域
//
//@property (nonatomic, strong) NSArray *turnoverArr; // 换手率
//@property (nonatomic, strong) NSArray *dealArr; // 成交额

@property (nonatomic, strong) NSMutableArray *idxArrM;
@end

@implementation JCLMarketList
-(void)viewDidLoad {
    [super viewDidLoad];
    self.navi.hidden = YES;
    [self InitTable];
    
}

-(void)InitTable{
  //  iPhone6 ? 0.25*JCLHEIGHT : 0.15*JCLHEIGHT
    self.table.y = 0, self.table.height = self.listH;
    //行情头部
    JCLMarketHeader *header = [[JCLMarketHeader alloc] init];
    header.height = 100*JCLWIDTH/375;
    self.table.tableHeaderView = header;
    self.header = header;
    header.tapActionBlock = ^(NSInteger idx){
        
        !self.idxActionBlock ? : self.idxActionBlock(self.header.arr[idx]);
     };
    
    self.sortField = @"14";
    self.codeArray = @[].mutableCopy;
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{ [self loadJson]; }];
    [self loadJson];
}

-(void)viewWillAppear:(BOOL)animated{ [super viewWillAppear:animated];
    AppDelegate.shareAppDelegate.timerAtionBlock = ^(){
        [self loadJson];
        
    };
}

-(void)loadJson{
    self.page = 0;
    self.sortState = @"1";
    [self loadIdxInfo];
  
}



-(void)queryContract:(NSString *)sttr{
    NSMutableArray *hArra = [NSMutableArray new];
   
    NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlC,@"quoteRealTime"];
//    [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
 
    [JCLHttps httpPOSTRequest:postUrl params:@{@"userId":userId(),@"symbols":sttr} success:^(id obj) {
 
        NSLog(@"--objobjobj1-- %@",obj);
        MMResultModel *model =(MMResultModel *)obj;
        if (model.code.intValue == 200 &&model.data.count>0) {
            for (int i = 0; i<model.data.count; i++) {
                 NSLog(@"--model.datamodel.data-- %@",model.data);
//                TSJRMarketOptionListModel *realTimeMarketModel = [TSJRMarketOptionListModel modelWithDictionary:model.data[i]];
             TSJRRealTimeMarket *realTimeMarketModel  = [TSJRRealTimeMarket modelWithDictionary:model.data[i]];
                if (i<3) {
                   [hArra addObject: realTimeMarketModel];
                }else if (i>=3&&i<8){
                   [self.hotArr addObject: realTimeMarketModel];
                }else if (i>=8&&i<13){
                    [self.roseArr addObject: realTimeMarketModel];
                }else if (i>=13&&i<18){
                    [self.fallArr addObject: realTimeMarketModel];
                }
             }
            self.header.arr = hArra;
            
          [self.table reloadData];
        }
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
//        [JCLFramework showErrorHud:@"服务器异常"];
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
// 获取行情指数头部数据
-(void)loadIdxInfo{
//    /dataapi/quoteIndexCategory
//    行情首页分类
   
    [self.codeArray removeAllObjects];
    self.codeArray = @[@".DJI",@".IXIC",@".INX"].mutableCopy;
    self.hotArr = [NSMutableArray new];
    self.roseArr = [NSMutableArray new];
    self.fallArr = [NSMutableArray new];
    NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlE,@"quoteIndexCategory"];
 
    [JCLHttps httpPOSTRequest:postUrl params:nil success:^(id obj) {
     MMResultV2Model *model =(MMResultV2Model *)obj;
        if (model.code.intValue == 200) {
           NSLog(@"objobj %@",model.data);
            
            NSMutableArray *hotArr = model.data[@"chinaHot"];
            NSMutableArray *riseArr = model.data[@"chinaRise"];
            NSMutableArray *chinaFalArray = model.data[@"chinaFall"];
            
            for (id object in hotArr) {
                 TSJRRealTimeMarket *realTimeMarketModel  = [TSJRRealTimeMarket modelWithDictionary:object];
//                TSJRStokeCoderModel *makeModel = [TSJRStokeCoderModel modelWithDictionary:object];
//                [self.codeArray addObject:[makeModel.symbol uppercaseString]];
                [self.hotArr addObject: realTimeMarketModel];
            }
            for (id object in riseArr) {
                TSJRRealTimeMarket *realTimeMarketModel  = [TSJRRealTimeMarket modelWithDictionary:object];
                 [self.roseArr addObject: realTimeMarketModel];
//                TSJRStokeCoderModel *makeModel = [TSJRStokeCoderModel modelWithDictionary:object];
//                [self.codeArray addObject:[makeModel.symbol uppercaseString]];
            }
            
            for (id object in chinaFalArray) {
//                TSJRStokeCoderModel *makeModel = [TSJRStokeCoderModel modelWithDictionary:object];
//                [self.codeArray addObject:[makeModel.symbol uppercaseString]];
                 TSJRRealTimeMarket *realTimeMarketModel  = [TSJRRealTimeMarket modelWithDictionary:object];
                 [self.fallArr addObject: realTimeMarketModel];
 
            }
 
            [self queryContract:[NSString stringWithFormat:@"%@",[self.codeArray componentsJoinedByString:@","]]];
         }
        [self.table.mj_header endRefreshing];
       
    } failure:^(NSError *error) {
//        [JCLFramework showErrorHud:@"服务器异常"];
        [self.table.mj_header endRefreshing];
        
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

-(NSMutableArray *)idxArrM{
    if (_idxArrM)
       return _idxArrM;
    return _idxArrM = [[NSMutableArray alloc]init];
 }

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
 }


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    JCLMarketHead *header = [[JCLMarketHead alloc]init];
    header.infoActionBlock = ^(UIButton *sender){
        [self.idxArrM enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger index, BOOL * _Nonnull stop) {
            if ([obj integerValue] == section) {
                sender.selected = NO;
            }
        }];
        
        NSString *idx = [NSString stringWithFormat:@"%ld", (long)section];
        if (sender.isSelected) {
            [self.idxArrM addObject:idx];
        } else {
            [self.idxArrM removeObject:idx]; 
        }
        
        [self.table reloadData];
    };
    
    NSArray *texts = @[@"中概股热门", @"中概股领涨", @"中概股领跌"];
    header.title.title = texts[section];
    [header.more tapActionBlock:^{
        NSArray *mains = @[@"0", @"0", @"1"];
        [self pushMoreList:header.title.title main:mains[section]];
    }];
    
    return header;
}
//@[@"纽交所", @"美交所", @"纳斯达克", @"中国概念股"]; 每个行情列表
-(void)pushMoreList:(NSString *)name main:(NSString *)mian{
    JCLMarketMore *more = [[JCLMarketMore alloc]init];
    more.name = name;
    more.asc = mian;
    UITabBarController *tabBar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *navi = (UINavigationController *)tabBar.selectedViewController;
    [navi pushViewController:more animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [JCLKitObj JCLHeight:36];
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [JCLKitObj JCLView:self.view color:JCL_Bg_COL];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section == 6 ? 0 : 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    __block NSInteger idx = 44;
    NSLog(@"idxArrMidxArrM  %@",self.idxArrM);
    [self.idxArrM enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger index, BOOL * _Nonnull stop) {
      if ([obj integerValue] == section) {
            idx = section;
        }
    }];
    NSLog(@"idx  %ld",(long)idx);
    NSInteger count = 0;
    if (section != idx) {
        switch (section) {
            case 0: count = self.hotArr.count; break;
            case 1: count = self.roseArr.count; break;
            case 2: count = self.fallArr.count; break;
          
            default: break;
        }
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JCLMarketRankCell *cell = [JCLMarketRankCell cellWithTable:tableView style:UITableViewCellStyleDefault];
    
    NSArray *obj;
    if (indexPath.section == 0) {
        obj = self.hotArr;
    } else if (indexPath.section == 1) {
        obj = self.roseArr;
    } else if (indexPath.section == 2) {
        obj = self.fallArr;
    }
     if (obj.count > 0) {
     TSJRRealTimeMarket *cmode =obj[indexPath.row];
//         TSJRMarketOptionListModel *cmode =obj[indexPath.row];
         cell.title.text = cmode.cn_name; //[NSString stringWithFormat:@"%@",[[AppDelegate shareAppDelegate].messageNoticeStore fetchMessage:[cmode.symbol uppercaseString]]];
         
         cell.code.text = cmode.symbol;
         cell.price.text = [NSString stringWithFormat:@"%.2f",cmode.price.floatValue];
           
         cell.range.text =  [JCLMarketObj JCLMarketPercent:cmode.percent];
         if ([cell.range.text containsString:@"+"]) {
             cell.range.textColor =RoseColor;
         }else if([cell.range.text containsString:@"-"]){
             cell.range.textColor  = FallColor;
         }else{
             cell.range.textColor  =GreyColor;
         }
         
         
         
//         cell.code.text  = [NSString stringWithFormat:@"%@",[cmode.symbol uppercaseString]];
//
//         NSString *range = [JCLMarketObj JCLMarketRange:cmode.close close:cmode.preClose];
//         cell.range.text = [JCLMarketObj JCLMarketScale:range  close:cmode.preClose];
//
//         UIColor *color =  [JCLMarketObj TSJRMarketColorA:range];
//         cell.price.textColor = color;
//         cell.range.textColor = color;
//         cell.price.text = [JCLKitObj countNumAndChangeformat:cmode.latestPrice];
     }
   
      
 
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ return [JCLKitObj JCLHeight:54]; }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        !self.cellActionBlock ? : self.cellActionBlock(self.hotArr[indexPath.row]);
    } else if (indexPath.section == 1) {
        !self.cellActionBlock ? : self.cellActionBlock(self.roseArr[indexPath.row]);
    }  else {
        !self.cellActionBlock ? : self.cellActionBlock(self.fallArr[indexPath.row]);
    }
}
@end
