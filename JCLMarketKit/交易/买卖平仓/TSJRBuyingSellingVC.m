//
//  TSJRBuyingSellingVC.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/15.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "TSJRBuyingSellingVC.h"
#import "TSJRBuyingSellingHeaderView.h"
#import "TSJRBuyingSellIngCellB.h"
#import "TSJRBuyingSellingFootView.h"
#import "JCLUserSubmit.h"
#import "JCLBaseTableViewCell.h"
#import "MMainButton.h"
#import "TSJRYSelectivityAlertView.h"
#import "TSJRBuyingSellingFootViewB.h"
#import "JCLMarketSearchList.h"
#import "TSJRRealTimeMarket.h"
#import "TSJRStokeCoderModel.h"

@interface TSJRBuyingSellingVC ()<TSJRSelectivityAlertViewDelegate,MMChangeQuantityViewDelegate>
@property (nonatomic,strong) NSMutableArray *idxArrM;
@property (nonatomic,strong) MMainButton *mainBtn;
@property (nonatomic,strong) TSJRBuyingSellingHeaderView *header;
@property (nonatomic,strong) TSJRRealTimeMarket *timeModel;
@property (nonatomic,strong) TSJRBuyingSellingFootView *buyingSellingFootView;
@property (nonatomic,strong) NSString *preMarket;//盘前盘后
@property (nonatomic,strong) NSString *marketStatus;//交易状态
@end

@implementation TSJRBuyingSellingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navi.middle.title = @"买卖";
    
    self.orderType = @"LMT";
    self.secType = @"STK";
    if (self.action.length ==0 &&self.str.intValue != 1) {
        self.action = @"BUY";
    }
    self.preMarket = @"1";//x允许
    [self.view addSubview:self.mainBtn];
    [self.mainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-SafeAreaBottomHeight);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];

    [self loadData];
    
    self.idxArrM = @[@"0",@"0",@"0"].mutableCopy;
    [self.table registerClass:[TSJRBuyingSellIngCellB class] forCellReuseIdentifier:@"TSJRBuyingSellIngCellB"];
    
    //从详情进入
    if (self.str.intValue == 1) {
        self.header = [[TSJRBuyingSellingHeaderView alloc]initWithFrame:CGRectMake(0, 0, JCLWIDTH, 90)];
        self.header.searchStockView.hidden = YES;
        [self.header.buyingA mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
        }];
        if ( [self.action  isEqualToString: @"BUY"]) {
            [self.header.buyingB setTitle:@"买入" forState:UIControlStateNormal];
        }else{
            [self.header.buyingB setTitle:@"卖出" forState:UIControlStateNormal];
        }
        [self.header.buyingB addTarget:self action:@selector(buyingB:)];
        [self.header.buyingC addTarget:self action:@selector(buyingB:)];
        self.table.tableHeaderView = self.header;
       
    }else{
        self.header = [[TSJRBuyingSellingHeaderView alloc]initWithFrame:CGRectMake(0, 0, JCLWIDTH, 90+85)];
        [self.header.searchStockView.findCodeBtn addTarget:self action:@selector(searchStock)];
        [self.header.buyingB addTarget:self action:@selector(buyingB:)];
        [self.header.buyingC addTarget:self action:@selector(buyingB:)];
        self.table.tableHeaderView = self.header;
         self.table.height = JCLSCROLL - 45;
    }
   
}

-(void)loadData{
//    /quoteapi/marketState
//    获取市场状态
    
    NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlC,@"marketState"];
    [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    [JCLHttps httpPOSTRequest:postUrl params: @{@"userId":userId()}  success:^(id obj) {
        MMResultModel *model =(MMResultModel *)obj;
        NSLog(@"objobjobjobj %@", model.data[0][@"openTime"]);
        if (model.code.intValue == 200) {
           self.marketStatus = model.data[0][@"marketStatus"];
           [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    } failure:^(NSError *error) {
        [JCLFramework showErrorHud:@"服务器异常"];
       [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        if ([self.header.buyingC.titleLabel.text isEqualToString:@"市价单"]) {
             return 1;
        }
        return 2;
    }
    
    if ([self.idxArrM[section] isEqualToString:@"1"]){
        //如果是展开状态
        if (section == 1) {
           return 4;
        }
        return 1;
    }else{
         //如果是闭合，返回0
        return 0;
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 45;
    }
    return  30;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        if ([self.header.buyingC.titleLabel.text isEqualToString:@"市价单"]) {
            return  85;
        }
        return 190;
    }
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        
        if ([self.header.buyingC.titleLabel.text isEqualToString:@"市价单"]) {
            TSJRBuyingSellingFootViewB *footV = [[TSJRBuyingSellingFootViewB alloc]init];
            return footV;
        }else{
            self.buyingSellingFootView = [[TSJRBuyingSellingFootView alloc]init];
      
            [self.buyingSellingFootView.noAllowbtn addTarget:self action:@selector(openClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.buyingSellingFootView.allowbtn addTarget:self action:@selector(openClick:) forControlEvents:UIControlEventTouchUpInside];
            return self.buyingSellingFootView;
        }
        
    }
    return nil;
};

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
         return  0.1;
     }
    return 45;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
 
        return nil;
    }else  {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, self.view.frame.size.width, 45)];
        [button setTag:section+1];
        button.backgroundColor = JCL_Cell_COL;
 
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 60)];
        [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
         UIImageView *_imgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-30, (45-10)/2, 15, 10)];
         if ([self.idxArrM[section] isEqualToString:@"0"]) {
                _imgView.image = [UIImage imageNamed:@"ic_drop_down"];
            }else if ([self.idxArrM[section] isEqualToString:@"1"]) {
                _imgView.image = [UIImage imageNamed:@"ic_up"];
          }
         [button addSubview:_imgView];
       
        UILabel *tlabel = [[UILabel alloc]initWithFrame:CGRectMake(15, (45-20)/2, 200, 20)];
        //    [tlabel setBackgroundColor:[UIColor clearColor]];
        [tlabel setFont:[UIFont systemFontOfSize:16]];
        tlabel.textColor =  JCLAccountRGB ;
        if (section == 1) {
             [tlabel setText:@"其他信息"];
        }else{
            [tlabel setText:@"订单明细预览"];
        }
       
        [button addSubview:tlabel];
        return button;
 
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
         TSJRBuyingSellIngCellB *cellA = [tableView dequeueReusableCellWithIdentifier:@"TSJRBuyingSellIngCellB" forIndexPath:indexPath];
         cellA.changeQuantityView.delegate = self;
         if (indexPath.row==0 &&[self.header.buyingC.titleLabel.text isEqualToString:@"市价单"]) {
             cellA.titleA.text = @"数量";
             cellA.changeQuantityView.whichCell = @"countB";
             cellA.changeQuantityView.textField.text = @"0";
             cellA.changeQuantityView.countB =YES;
         }else{
             if (indexPath.row == 0) {
                cellA.titleA.text = @"限价";
                cellA.changeQuantityView.textField.text = self.limitPrice;
                cellA.changeQuantityView.countB =NO;
                cellA.changeQuantityView.whichCell = @"latestPrice";
               [cellA.changeQuantityView.textField.rac_textSignal subscribeNext:^(NSString *x) {
                   NSLog(@"------- %@",x);
                   
//                     if (x.length > 0) {
//                         self.buyingSellingFootView.priceLB.text = [NSString stringWithFormat:@"%.2f",self.limitPrice.floatValue * x.floatValue];
//                     }else{
//                         self.buyingSellingFootView.priceLB.text = @"0";
//                     }
                 }];
             }else{
               cellA.titleA.text = @"数量";
              cellA.changeQuantityView.textField.text = @"0";
               cellA.changeQuantityView.countB =YES;
               cellA.changeQuantityView.whichCell = @"countB";
               [cellA.changeQuantityView.textField.rac_textSignal subscribeNext:^(NSString *x) {
                   NSLog(@"------ %@",x);
                     if (x.intValue > 0) {
                         cellA.changeQuantityView.textField.text = [NSString stringWithFormat:@"%d",x.intValue];
                         self.countCode = [NSString stringWithFormat:@"%d",x.intValue];
                         self.buyingSellingFootView.priceLB.text = [NSString stringWithFormat:@"%.2f",self.limitPrice.floatValue * x.floatValue];
                     }else{
                         self.buyingSellingFootView.priceLB.text = @"0";
                     }
                 }];
             }
         }
        return  cellA;
    }else{
        static NSString *CellIdentifier = @"cell";
        JCLBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[JCLBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.textColor = JCLAccountRGB;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"保证金";
                cell.detailTextLabel.text = @"+50.00%(做多)/+50.00%(做空)";
            }else if (indexPath.row == 1){
                cell.textLabel.text = @"卖空参考利率";
                cell.detailTextLabel.text = @"1.25%";
            }else if (indexPath.row == 2){
                cell.textLabel.text = @"可用购买力";
                cell.detailTextLabel.text = @"22，619.836";
            }else if (indexPath.row == 3){
                cell.textLabel.text = @"卖空池剩余";
                cell.detailTextLabel.text = @"10，000.000";
            }
        }else{
            cell.textLabel.text = @"佣金（估算）";
            cell.detailTextLabel.text = @"2.99";
        }
        return cell;
    }
 }

-(void)buttonDidClick:(NSArray *)value{
    NSLog(@"valuevalue  %@",value);
    
    if ([value[1] isEqualToString:@"latestPrice"]) {
        self.limitPrice =value[0];
        if (self.countCode.length > 0) {
             self.buyingSellingFootView.priceLB.text = [NSString stringWithFormat:@"%.2f",self.limitPrice.floatValue * self.countCode.intValue];
        }
        
    }else{
        int index = [value[0] intValue];
        self.countCode = value[0];
        self.buyingSellingFootView.priceLB.text = [NSString stringWithFormat:@"%.2f",self.limitPrice.floatValue * index];
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//盘前盘后
- (void)openClick:(UIButton * ) btn {
//    btn.selected = !btn.selected;
    //盘前盘后点击允许可以提交  不允许不能提交
    if (btn.tag == 10001) {//允许
        [btn setImage: [UIImage imageNamed:@"已添加"] forState:UIControlStateNormal];
        UIButton *btnMale = (UIButton *)  [self.view viewWithTag:10002 ];
           NSLog(@"btnFemalebtnFemale  %@",[self.view viewWithTag:10002 ]);
        [btnMale setImage: [UIImage imageNamed:@"buxuan"] forState:UIControlStateNormal];
        self.preMarket=@"1";
    } else if (btn.tag == 10002) {//不允许
        
        [btn setImage: [UIImage imageNamed:@"已添加"] forState:UIControlStateNormal];
        UIButton *btnFemale = (UIButton *)  [self.view viewWithTag:10001];
        [btnFemale setImage: [UIImage imageNamed:@"buxuan"] forState:UIControlStateNormal];
         self.preMarket=@"0";
    }

 }

//买入卖出限价单
-(void)buyingB:(UIButton *)buy{
   
    if (buy.tag == 1001) {
         UIAlertController* alert = [[UIAlertController alloc]init];
        
                UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                                     handler:^(UIAlertAction * action) {
                                                                         //响应事件
                                                                         NSLog(@"action = %@", action);
                                                                     }];
        
                UIAlertAction* saveAction = [UIAlertAction actionWithTitle:@"买入" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {
                                                                       self.action = @"BUY";
                                                                       [self.header.buyingB setTitle:@"买入"];
                                                                       [self.header.buyingB setTitleColor:JCLRGB(197, 171, 112) forState:0];
                                                                         [self.mainBtn setTitle:@"买入下单" forState:UIControlStateNormal];
                                                                 
                                                                   }];
                UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"卖出" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {
                                                                       //响应事件
                                                                       self.action = @"SELL";
                                                                        [self.header.buyingB setTitle:@"卖出"];
                                                                        [self.header.buyingB setTitleColor:[UIColor redColor] forState:0];
//                                                                        [self.table reloadData];
                                                                        [self.mainBtn setTitle:@"卖出下单" forState:UIControlStateNormal];
                                                                       NSLog(@"action = %@", action);
                                                                   }];
        
        
                [alert addAction:saveAction];
                [alert addAction:deleteAction];
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
    }else{
        UIAlertController* alert = [[UIAlertController alloc]init];
        
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * action) {
                                                                 //响应事件
                                                                 NSLog(@"action = %@", action);
                                                             }];
        
        UIAlertAction* saveAction = [UIAlertAction actionWithTitle:@"限价单" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action) {
                                                               //响应事件
                                                               [self.header.buyingC setTitle:@"限价单"];
                                                               NSLog(@"action = %@", action);
                                                               self.orderType = @"LMT";
                                                               [self.table reloadSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
                                                           }];
        UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"市价单" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 //响应事件
                                                                  self.orderType = @"MKT";
                                                                  [self.header.buyingC setTitle:@"市价单"];
                                                                 [self.table reloadSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
                                                                 NSLog(@"action = %@", action);
                                                             }];
        
        
        [alert addAction:saveAction];
        [alert addAction:deleteAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(MMainButton *)mainBtn{
    if (!_mainBtn) {
        _mainBtn = [[MMainButton alloc]init];
        _mainBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
        if ( [self.action  isEqualToString: @"BUY"]) {
             [_mainBtn setTitle:@"买入下单" forState:UIControlStateNormal];
        }else{
             [_mainBtn setTitle:@"卖出下单" forState:UIControlStateNormal];
        }
       
       [_mainBtn addTarget:self action:@selector(subBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mainBtn;
}

-(void)subBtn{
    
    //数据的验证
    if (![self isEndBtn]) {
        return ;
    }
    NSArray *datas;
    NSArray *detailArray;
    if ([self.header.buyingC.titleLabel.text isEqualToString:@"市价单"]) {
        datas = [NSArray arrayWithObjects:@"交易账户",@"名称",@"代码",@"方向",@"订单类型",@"期限",@"数量",@"总价(估算)", nil];
       detailArray = @[@"模拟账户",self.symbol,[NSString stringWithFormat:@"%@",[[AppDelegate shareAppDelegate].messageNoticeStore fetchMessage:self.symbol]],[JCLKitObj actionType:self.action],[JCLKitObj orderType:self.orderType],@"当日有效",[NSString stringWithFormat:@"%@股",self.countCode], [NSString stringWithFormat:@"%@USD",self.buyingSellingFootView.priceLB.text]].mutableCopy;
    }else{
        datas = [NSArray arrayWithObjects:@"交易账户",@"名称",@"代码",@"方向",@"订单类型",@"期限",@"盘前盘后",@" 限价",@"数量",@"总价(估算)", nil];
        detailArray= @[@"模拟账户",self.symbol,[NSString stringWithFormat:@"%@",[[AppDelegate shareAppDelegate].messageNoticeStore fetchMessage:self.symbol]],[JCLKitObj actionType:self.action],[JCLKitObj orderType:self.orderType],@"当日有效",@"不允许成交",[NSString stringWithFormat:@"%@USD",self.limitPrice],[NSString stringWithFormat:@"%@股",self.countCode], [NSString stringWithFormat:@"%@USD",self.buyingSellingFootView.priceLB.text]].mutableCopy;
    }
    
    TSJRYSelectivityAlertView *ldySAV = [[TSJRYSelectivityAlertView alloc]initWithTitle:@"订单明细" datas:datas ifSupportMultiple:YES];
    ldySAV.detailArray = detailArray.mutableCopy;
    ldySAV.delegate = self;
    [ldySAV show];
}
//确定
-(void)singleChoiceBlockData:(NSString *)data{
    
}

//判断是否能购买
-(BOOL)isEndBtn{
    if (self.symbol.length == 0) {
       [JCLKitObj showMsg:@"请选择要买的股票"];
        return NO;
    }else if (self.action.length == 0){
        [JCLKitObj showMsg:@"请选择买卖"];
        return NO;
    }else if (self.limitPrice.length == 0){
        [JCLKitObj showMsg:@"限价为空"];
        return NO;
    }else if (self.countCode.intValue <= 0){
        [JCLKitObj showMsg:@"数量必须大于0"];
        return NO;
    }
    return YES;
}

//下单
-(void)multipleChoiceBlockDatas:(NSArray *)datas{
    
    NSLog(@"-=---------- %d",self.preMarket.intValue);
    
    
    //下单状态的判断
    if ([self.marketStatus isEqualToString:@"已收盘"]||[self.marketStatus isEqualToString:@"休市中"]||[self.marketStatus isEqualToString:@"未开盘"]) {
        [JCLKitObj showMsg:@"非交易时间不能下单"];
        return  ;
    }
    if (([self.marketStatus isEqualToString:@"盘前交易"]||[self.marketStatus isEqualToString:@"盘后交易"])&&self.preMarket.intValue == 0) {
        [JCLKitObj showMsg:@"尚未开盘，下单是请勾选允许盘前盘后"];
        return  ;
    }
    [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    if ([self.orderType isEqualToString:@"MKt"]) {
        self.limitPrice= @"0";
    }else{
         self.limitPrice= self.limitPrice;
    }
    
    //修改订单
    if (self.orderID.length > 0) {
//        /tradeapi/modifyOrder 修改订单
        NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlD,@"modifyOrder"];
        [JCLHttps httpPOSTRequest:postUrl params:@{@"userId":userId(),@"orderId":self.orderID} success:^(id obj) {
            
            MMResultModel *model =(MMResultModel *)obj;
            if (model.code.intValue == 200) {
                [JCLKitObj showMsg:model.message];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [[JCLKitObj rootVC].navigationController popViewControllerAnimated:YES];
            }
              [MBProgressHUD hideHUDForView:self.view animated:YES];
        } failure:^(NSError *error) {
            [JCLFramework showErrorHud:@"服务器异常"];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }
    
    NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlD,@"placeOrder"];
   
    
    //下单
    [JCLHttps httpPOSTRequest:postUrl params:@{@"userId":userId(),
                                               @"action":self.action,
                                               @"limitPrice":self.limitPrice,
                                               @"orderType":self.orderType,
                                               @"secType":self.secType,
                                               @"symbol":self.symbol,
                                               @"totalQuantity":self.countCode
                                               } success:^(id obj) {
        
        MMResultModel *model =(MMResultModel *)obj;
        [JCLKitObj showMsg:model.message];
        if (model.code.intValue == 200) {
          
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [[JCLKitObj rootVC].navigationController dismissViewControllerAnimated:YES completion:nil];
//            [[JCLKitObj rootVC].navigationController popViewControllerAnimated:YES];
        }
            
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
     } failure:^(NSError *error) {
        [JCLFramework showErrorHud:@"服务器异常"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
 }

//搜索股票
-(void)searchStock{
    JCLMarketSearchList *vc = [[JCLMarketSearchList alloc]init];
    vc.isPop = YES;
    vc.popActionBlock = ^(NSArray *infos) {
       TSJRStokeCoderModel *m = (TSJRStokeCoderModel *)infos;
   
        self.symbol = m.stock.symbol;
        [self queryContract:m.stock.symbol];
         self.header.searchStockView.codeFiled.text =m.stock.symbol;
        self.header.searchStockView.stockName.text = m.stock.cn_name;//[NSString stringWithFormat:@"%@",[[AppDelegate shareAppDelegate].messageNoticeStore fetchMessage:m.stock.cn_name]];
    };
    [self.navigationController pushViewController:vc animated:YES];
} 
///accountapi/queryContract
//   获取实时行情
-(void)queryContract:(NSString *)sttr{
  
    NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlC,@"quoteRealTime"];
    [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    [JCLHttps httpPOSTRequest:postUrl params:@{@"userId":userId(),@"symbols":sttr} success:^(id obj) {
        
        MMResultModel *model =(MMResultModel *)obj;
        if (model.code.intValue == 200) {
             NSLog(@"--objobjobj1-- %@",model.data);
            self.timeModel  = [TSJRRealTimeMarket modelWithDictionary:model.data[0]];
            self.limitPrice =  self.timeModel.latestPrice;
            self.header.searchStockView.stockindex.text = [NSString stringWithFormat:@"现价：%@",self.limitPrice];//头部赋值
            NSString *range = [JCLMarketObj JCLMarketRange:self.timeModel.close close:self.timeModel.preClose];
            self.header.searchStockView.profitLB.text = [JCLMarketObj JCLMarketScale:range  close:self.timeModel.preClose];
            self.header.searchStockView.stockindex.textColor =  [JCLMarketObj TSJRMarketColorA:[NSString stringWithFormat:@"%.2f",self.timeModel.latestPrice.floatValue-self.timeModel.preClose.floatValue]];
            ;
        }
          [self.table reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        [JCLFramework showErrorHud:@"服务器异常"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

@end
