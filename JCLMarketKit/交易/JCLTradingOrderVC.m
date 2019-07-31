//
//  JCLTradingOrderVC.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/27.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "JCLTradingOrderVC.h"
#import "MMResultV2Model.h"
#import "JCLYearMonthSelectedView.h"
#import "JCLTableInfoCell.h"
#import "JCLTradingorderCell.h"
#import "JCLTradingOrderModel.h"
#import "JCLTradingHeaderView.h"
#import "JCLTradingTimeHeaderView.h"
#import "TSJRTradingOrderDetailVC.h"
#import "TSJRBuyingSellingVC.h"
#import "JCLStockMain.h"
#import "TSJRRealTimeMarket.h"
#import "JCLDateObj.h"

@interface JCLTradingOrderVC ()
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *codeName;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, copy) NSString *endDate;
@property (nonatomic, strong) NSIndexPath  *selectedIndexPath;
@property (nonatomic, assign) BOOL selectedIndexBool;
@end

@implementation JCLTradingOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
 
  
    self.navi.hidden = YES;
    self.navi.height = 0;
    self.startDate = [formatter stringFromDate:[JCLDateObj getTimeAfterNowWithDay:89]];

    
    self.endDate = @"";
  
    self.table = [JCLKitObj JCLTable:self.view target:self frame:CGRectMake(0, 0, JCLWIDTH, JCLSCROLL-44) style:UITableViewStylePlain];
    self.table.backgroundColor =JCL_Bg_COL;
//    self.table.backgroundView.backgroundColor = JCL_Bg_COL;
    self.table.separatorColor =JCL_Bg_COL;
    self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.dataArray = [NSMutableArray new];
    
    self.codeName = [NSMutableArray new];
    [self loadJson];
    
     self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         [self loadJson];
     }];
    
   [self.table registerClass:[JCLTradingorderCell class] forCellReuseIdentifier:@"JCLTradingorderCell"];
    
    if ([self.title isEqualToString:@"已成交"]) {
        JCLTradingTimeHeaderView *hv = [[JCLTradingTimeHeaderView alloc]initWithFrame:CGRectMake(0, 0, JCLWIDTH, 40)];
        UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapBackgroundView)];
        [hv addGestureRecognizer:myTap];
        self.table.tableHeaderView = hv;
    }
    
 
}

-(void)loadJson{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.page = 0;
    NSLog(@"title %@",self.title);
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
 
    NSString *postUrlA;
    if ([self.title isEqualToString:@"待成交"]) {
        postUrlA = [NSString stringWithFormat:@"%@/%@",baseApiURlB,@"getActiveOrders"];
        self.endDate = [NSString stringWithFormat:@"%@ 23:59:59",[formatter stringFromDate:date]];
    }else if ([self.title isEqualToString:@"已成交"]){
        postUrlA = [NSString stringWithFormat:@"%@/%@",baseApiURlB,@"getFilledOrders"];
        
        NSDate *nextDate = [NSDate dateWithTimeInterval:24*60*60 sinceDate:date];
        self.endDate =  [formatter stringFromDate:nextDate];
    }else{
        postUrlA = [NSString stringWithFormat:@"%@/%@",baseApiURlB,@"getInactiveOrders"];
    }

    
    
    
    [JCLHttps httpPOSTRequest:postUrlA params:@{@"userId":userId(),@"startDate":self.startDate,@"endDate":self.endDate} success:^(id obj) {
        NSLog(@"objobj %@",obj);
 
        [self.dataArray removeAllObjects];
        MMResultModel *model =(MMResultModel *)obj;
        if (model.code.intValue == 200 &&model.data.count>0) {
            for ( id object in model.data) {
                JCLTradingOrderModel *model = [JCLTradingOrderModel modelWithDictionary:object];
//                NSLog(@"ssssss  %@", model.symbol);
//               [self.codeName addObject:[[AppDelegate shareAppDelegate].messageNoticeStore fetchMessage:model.symbol]];
 
               [self.dataArray addObject:model];
               [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
   
        }
         [self.table reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
          [self.table.mj_header endRefreshing];
        } failure:^(NSError *error) {
            [self.table.mj_header endRefreshing];
            [JCLFramework showErrorHud:@"服务器异常"];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   if (self.selectedIndexPath && self.selectedIndexPath == indexPath) {
       if (self.selectedIndexBool) {
            return 65;
       }
       return 65+55;
   }
    return 65;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 30;
    }
    return 1;
}
 
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    JCLTradingHeaderView *header = [[JCLTradingHeaderView alloc]init];
    if ([self.title isEqualToString:@"已成交"]) {
        header.titleA.text = @"名称|代码";
        header.titleB.text = @"方向";
        header.titleC.text = @"数量|价格";
        header.titleD.text = @"成交时间";
    }else{
        [header.titleC mas_updateConstraints:^(MASConstraintMaker *make) {
             make.right.mas_equalTo(header.titleD.mas_left).offset(-15);
        }];
    }
    if (section == 0) {
        return header;
    }
    return nil;
};


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JCLTradingorderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JCLTradingorderCell" forIndexPath:indexPath];
    cell.footView.detailBtn.tag = indexPath.row;
 
   
    JCLTradingOrderModel *model =self.dataArray[indexPath.row];
    cell.titleA.text =  model.stock.cn_name;//[NSString stringWithFormat:@"%@",self.codeName[indexPath.row]];
    [cell setTradingOrderModel:model];
    if (![self.title isEqualToString:@"已成交"]) {
        cell.titleC.text = model.avgFillPrice.floatValue > 0 ?model.avgFillPrice:@"--";
        cell.titleH.text = [NSString stringWithFormat:@"%@%@",[JCLKitObj orderType:model.orderType],model.limitPrice.length>0?model.limitPrice:@" "];
        cell.titleF.text = [NSString stringWithFormat:@"%@",[JCLKitObj actionType:model.action]];
        if ([cell.titleF.text isEqualToString:@"买入"]) {
            cell.titleF.textColor = RoseColor;
        }else{
            cell.titleF.textColor = FallColor;
        }
        cell.titleD.text = [NSString stringWithFormat:@"%@",model.totalQuantity];
        cell.titleG.text = model.statusStr;
        cell.titleC.textAlignment = NSTextAlignmentRight;
        cell.titleH.textAlignment = NSTextAlignmentRight;
        
        [cell.titleC mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((JCLWIDTH-80)/2);
            make.width.mas_equalTo(50);
        }];
        [cell.titleH mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((JCLWIDTH-130)/2);
            make.width.mas_equalTo(80);
        }];
    }else{
        [cell.titleC mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(25);
        }];
    }
     
    if (self.selectedIndexPath && self.selectedIndexPath == indexPath) {
       if (self.selectedIndexBool) {
            cell.footView.hidden = YES;
         
        }else{
            cell.footView.hidden = NO;
        }
        cell.footView.stocksBtn.tag = indexPath.row;
        [cell.footView.stocksBtn addTarget:self action:@selector(stocksBtnVC:)];//个股详情
        [cell.footView.detailBtn addTarget:self action:@selector(detailVC:)];
        if ([self.title isEqualToString:@"待成交"]) {
            cell.footView.undolBtn.hidden = NO;
            cell.footView.updateBtn.hidden = NO;
            [cell.footView.updateBtn  addTarget:self action:@selector(updateBtn:)];
            [cell.footView.undolBtn  addTarget:self action:@selector(undolBtn:)];
            cell.footView.undolBtn.tag = indexPath.row;
            cell.footView.updateBtn.tag = indexPath.row;
        }
        
        
    }else{
        cell.footView.hidden = YES;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    JCLTradingorderCell *cell;
     
    if (self.selectedIndexPath==indexPath) {
        self.selectedIndexBool = !self.selectedIndexBool;
    }else{
         self.selectedIndexBool = NO;
    }
    
    self.selectedIndexPath = indexPath;
    [self.table reloadData];
}

-(void)detailVC:(UIButton *)sender{
    NSInteger index = sender.tag;
    NSLog(@"index %ld",(long)index);
    JCLTradingOrderModel *model = self.dataArray[index];
     NSLog(@"index %@",model.latestTime);
    TSJRTradingOrderDetailVC *vc = [[TSJRTradingOrderDetailVC alloc]init];
    vc.tradingmodel = model;
    [[JCLKitObj rootVC].navigationController pushViewController:vc animated:YES];
}

//修改订单
-(void)updateBtn:(UIButton *)btn{
    JCLTradingOrderModel *model =self.dataArray[btn.tag];
    NSLog(@"modelmodel %@",model);
    TSJRBuyingSellingVC *vc = [[TSJRBuyingSellingVC alloc]init];
    vc.symbol = model.symbol;
    vc.action = model.action;
    vc.orderType = model.orderType;
    vc.limitPrice= model.avgFillPrice;
    vc.countCode = model.totalQuantity;
    vc.orderID = model.orderId;
    vc.str = @"1";
    [[JCLKitObj rootVC].navigationController pushViewController:vc animated:YES];
 }


-(void)stocksBtnVC:(UIButton *)btn{
    JCLTradingOrderModel *model =self.dataArray[btn.tag];
    NSLog(@"modelmodel %@",model);
    TSJRRealTimeMarket *mArray = [[TSJRRealTimeMarket alloc]init];
    mArray.symbol = model.symbol;
    mArray.cn_name =  model.stock.cn_name;
    JCLStockMain *vc = [[JCLStockMain alloc]init];
    vc.arr =  mArray;
    NSLog(@"arrarrarr  %@",mArray);
    [[JCLKitObj rootVC].navigationController pushViewController:vc animated:YES];
}



-(void)undolBtn:(UIButton *)btn{
//    /tradeapi/cancelOrder
//    取消订单
    JCLTradingOrderModel *model =self.dataArray[btn.tag];
    NSString *postUrlA = [NSString stringWithFormat:@"%@/%@",baseApiURlD,@"cancelOrder"];
    [JCLHttps httpPOSTRequest:postUrlA params:@{@"userId":userId(),@"orderId":model.orderId} success:^(id obj) {
        NSLog(@"objobj %@",obj);
        MMResultModel *model =(MMResultModel *)obj;
        [JCLKitObj showMsg:model.message];
        if (model.code.intValue == 200) {
            [self loadJson];
        }
   } failure:^(NSError *error) {
       [JCLFramework showErrorHud:@"服务器异常"];
       [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}


-(void)didTapBackgroundView{
    [JCLYearMonthSelectedView showDatePickerWithTitle:@"选择年月" minDateStr:@"2018-01" resultBlock:^(NSString *selectValue) {
        //选择完成后的操作
        if ([selectValue isEqualToString:@"全部"]) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"YYYY-MM-dd"];
            self.startDate = [formatter stringFromDate:[JCLDateObj getTimeAfterNowWithDay:89]];
        }else{
             self.startDate = [NSString stringWithFormat:@"%@-01",selectValue];
        }
       
        [self loadJson];
        NSLog(@"selected month is %@", selectValue);
      
    }];
}
 
@end
