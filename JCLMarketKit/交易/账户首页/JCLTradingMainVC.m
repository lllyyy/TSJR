//
//  JCLTradingMainVC.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/27.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "JCLTradingMainVC.h"
#import "JCLInstrionsHeaderView.h"
#import "JCLTadingMoneCell.h"
#import "JCLTradingFootView.h"
#import "JCLSimulationAccountVC.h"
#import "JCLOrderMainVC.h"
#import "MMResultV2Model.h"
#import "MMResultModel.h"
#import "JCLAccountModel.h"
#import "TSJRQueryPositionModel.h"
#import "TSJRTradingMainCell.h"
#import "TSJRTradingMainHeaderView.h"
#import "TSJRBuyingSellingVC.h"
#import "TSJRRealTimeMarket.h"
#import "JCLStockMain.h"



@interface JCLTradingMainVC ()
@property (nonatomic,strong) JCLAccountModel *accountModel;
@property (nonatomic, strong) NSMutableArray *idxArrM;
@property (nonatomic, strong) NSMutableArray *queryData;//持仓数据
@property (nonatomic, strong) NSMutableArray *queryDataA;//
@property (nonatomic, strong) NSString  *sorting;
@end

@implementation JCLTradingMainVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
    
    if ([[JCLUserSession getCurrentAccount] isEqualToString:@"1"]) {
        self.navi.middle.title = @"正式账户";
    }else{
        self.navi.middle.title = @"模拟账户";
     }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navi.bg.backgroundColor = RGB(55, 61, 93);
    
    self.sorting = @"0";
    
    [self.navi.left setImg:@""];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadData];
    _idxArrM = @[@"0",@"1"].mutableCopy;
    
    self.queryData = [[NSMutableArray alloc]init];
    self.queryDataA = [[NSMutableArray alloc]init];
    [self.table registerClass:[TSJRTradingMainCell class] forCellReuseIdentifier:@"TSJRTradingMainCell"];
    [self.table registerClass:[JCLTadingMoneCell class] forCellReuseIdentifier:@"JCLTadingMoneCell"];
    
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         [self loadData];
    }];
}

-(void)loadData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //获取持仓的数据
    //获取账户
    NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlB,@"queryAsset"];
    
    [JCLHttps httpPOSTRequest:postUrl params:@{@"userId":userId()} success:^(id obj) {
        
        MMResultV2Model *model =(MMResultV2Model *)obj;
        if (model.code.intValue == 200) {
            NSLog(@"---model %@",model.data);
            self.accountModel = [JCLAccountModel modelWithDictionary:model.data[0]];
            [self.table reloadData];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    
    NSString *queryurl = [NSString stringWithFormat:@"%@/%@",baseApiURlB,@"queryPosition"];
    [JCLHttps httpPOSTRequest:queryurl params:@{@"userId":userId()} success:^(id obj) {
        MMResultModel *model =(MMResultModel *)obj;
         NSLog(@"--AAAAA-model %@",model.data);
        if (model.code.intValue == 200 &&model.data.count>0) {
             [self.queryData removeAllObjects];
             [self.queryDataA removeAllObjects];
            for ( id object in model.data) {
                TSJRQueryPositionModel *model = [TSJRQueryPositionModel modelWithDictionary:object];
                [self.queryData addObject:model];
                [self.queryDataA addObject:model];
             }
            [self.table reloadData];
        }
         [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.table.mj_header endRefreshing];
        [self.table.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.table.mj_header endRefreshing];
        [self.table.mj_footer endRefreshing];
         [MBProgressHUD hideHUDForView:self.view animated:YES];
        [JCLFramework showErrorHud:@"服务器异常"];
       
    }];
   
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    if (section == 0) {
        return 1;
    }
    
    if ([self.idxArrM[section] isEqualToString:@"1"]){
        //如果是展开状态
        return self.queryData.count;
    }else{
        //如果是闭合，返回0
        return 0;
    }
     
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
         return 100;
    }
    return  65;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
         return 60;
    }
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        JCLTradingFootView *footView = [[JCLTradingFootView alloc]initWithFrame:CGRectMake(0, 0, JCLWIDTH, 50)];
        [footView.accountbtn addTarget:self action:@selector(accounAction) forControlEvents:UIControlEventTouchUpInside];
        [footView.orderbtn addTarget:self action:@selector(orderbtnAction) forControlEvents:UIControlEventTouchUpInside];
        [footView.tradingBtn addTarget:self action:@selector(tradingAction) forControlEvents:UIControlEventTouchUpInside];
        return footView;
    }
    return nil;
};

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
       return  45;
    }
    
    if ([self.idxArrM[section] isEqualToString:@"0"]) {
        return 35;
    }else if ([self.idxArrM[section] isEqualToString:@"1"]) {
        return 35+25;
    }
    return 0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        JCLInstrionsHeaderView *header = [[JCLInstrionsHeaderView alloc]init];
        header.backgroundColor =RGB(55, 61, 93);
        [header.title setTitle:@"总资产(USD)" forState:0];
        header.title.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        return header;
    }else  {
        TSJRTradingMainHeaderView *headView = [[TSJRTradingMainHeaderView alloc]init];
        headView.bgBtn.tag = section+1;
        headView.titleC.tag = 1001;
        headView.titleE.tag = 1002;
        [headView.titleC addTarget:self action:@selector(descbtn:)];
        [headView.titleE addTarget:self action:@selector(descbtn:)];
        
        [headView.bgBtn addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
       
        if ([self.idxArrM[section] isEqualToString:@"0"]) {
            headView.bgView.hidden = YES;
            headView.rightMore.image = [UIImage imageNamed:@"ic_drop_down"];
        }else if ([self.idxArrM[section] isEqualToString:@"1"]) {
            headView.bgView.hidden = NO;
            headView.rightMore.image = [UIImage imageNamed:@"ic_up"];
        }
        
        if (self.queryData.count>0 ) {
             [headView setData:self.queryData];
        }
        return headView;
    }
 }
- (void)buttonPress:(UIButton *)sender//headButton点击
{
    //判断状态值
    if ([self.idxArrM[sender.tag - 1] isEqualToString:@"1"]){
        //修改
        [self.idxArrM replaceObjectAtIndex:sender.tag - 1 withObject:@"0"];
    }else{
        [self.idxArrM replaceObjectAtIndex:sender.tag - 1 withObject:@"1"];
    }
    [self.table reloadSections:[NSIndexSet indexSetWithIndex:sender.tag-1] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        JCLTadingMoneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JCLTadingMoneCell" forIndexPath:indexPath];
        if (self.accountModel.account.length > 0) {
             [cell setDate:self.accountModel];
        }
        return cell;
    }else{
        TSJRTradingMainCell *cellA = [tableView dequeueReusableCellWithIdentifier:@"TSJRTradingMainCell" forIndexPath:indexPath];
        [cellA setTradingOrderModel:self.queryData[indexPath.row]];
 
        return  cellA;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        TSJRQueryPositionModel *model = self.queryData[indexPath.row];
        TSJRRealTimeMarket *mArray = [[TSJRRealTimeMarket alloc]init];
        mArray.symbol = model.symbol;
        mArray.cn_name = model.stock.cn_name;
        JCLStockMain *vc = [[JCLStockMain alloc]init];
        vc.arr = mArray;
        NSLog(@"arrarrarr  %@",mArray);
        [self.navigationController pushViewController:vc animated:YES];
    }
    
 }

-(void)accounAction{
    JCLSimulationAccountVC *vc =[[JCLSimulationAccountVC alloc]init];
    vc.accountModel = self.accountModel;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)orderbtnAction{
    JCLOrderMainVC *vc = [[JCLOrderMainVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//下单
-(void)tradingAction{
    TSJRBuyingSellingVC *vc = [[TSJRBuyingSellingVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}



//排序
-(void)descbtn:(UIButton *)sneder{
    NSLog(@"----- %ld",(long)sneder.tag);
    NSArray *sortArray;
    if (self.sorting.intValue == 0) {
        self.sorting = @"1";
    }else if (self.sorting.intValue == 1)  {
          self.sorting = @"2";
    }else if (self.sorting.intValue == 2)  {
        self.sorting = @"0";
    }
    
    
    if (sneder.tag == 1002) {
 
        if (self.sorting.intValue == 1) {
            sortArray = [self.queryData sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                
                TSJRQueryPositionModel *model1 = obj1;
                TSJRQueryPositionModel *model2 = obj2;
                if ([model1.unrealizedPnl floatValue] < [model2.unrealizedPnl floatValue]) {
                    return NSOrderedDescending;//降序
                } else {
                    return NSOrderedSame;//相等
                }
            }];
            
        }else if (self.sorting.intValue == 0){
            
            sortArray = self.queryDataA;
            
        }else if (self.sorting.intValue == 2){
 
            sortArray = [self.queryDataA sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                TSJRQueryPositionModel *model1 = obj1;
                TSJRQueryPositionModel *model2 = obj2;
                
                if ([model1.unrealizedPnl floatValue] < [model2.unrealizedPnl floatValue]){
                    return NSOrderedAscending;//升序
                }
                return NSOrderedDescending;//升序
            }];
           
        }
    }else{
 
        if (self.sorting.intValue == 1) {
            sortArray = [self.queryData sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                TSJRQueryPositionModel *model1 = obj1;
                TSJRQueryPositionModel *model2 = obj2;
                if ([model1.position floatValue] < [model2.position floatValue]) {
                    return NSOrderedDescending;//降序
                } else {
                    return NSOrderedSame;//相等
                }
            }];
 
        }else if (self.sorting.intValue == 0){
            
            sortArray = self.queryDataA;
            
        }else if (self.sorting.intValue == 2){
 
            sortArray = [self.queryDataA sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                TSJRQueryPositionModel *model1 = obj1;
                TSJRQueryPositionModel *model2 = obj2;
                
                if ([model1.position floatValue] < [model2.position floatValue]){
                    return NSOrderedAscending;//升序
                }
                return NSOrderedDescending;//升序
            }];
     
        }
    }
 
    [self.queryData removeAllObjects];
    self.queryData = sortArray.mutableCopy;
    
    [self.table reloadData];
 
 }

@end
