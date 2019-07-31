//
//  TSJRTradingOrderDetailVC.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/14.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "TSJRTradingOrderDetailVC.h"
#import "TSJRTradingOrderDetailView.h"
#import "JCLBaseTableViewCell.h"
#import "TSJRTradingOrderDetailCell.h"
@interface TSJRTradingOrderDetailVC ()

@end

@implementation TSJRTradingOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navi.hidden = NO;
    self.navi.middle.title = @"订单详情";
    self.navi.bg.backgroundColor = RGB(55, 61, 93);
    self.table = [JCLKitObj JCLTable:self.view target:self frame:CGRectMake(0, JCLNAVI, JCLWIDTH, JCLSCROLL) style:UITableViewStylePlain];
    self.table.backgroundColor =JCL_Cell_COL;
    
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.table registerClass:[JCLBaseTableViewCell class] forCellReuseIdentifier:@"JCLBaseTableViewCell"];
    [self.table registerClass:[TSJRTradingOrderDetailCell class] forCellReuseIdentifier:@"TSJRTradingOrderDetailCell"];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 120;
    }
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TSJRTradingOrderDetailView *header = [[TSJRTradingOrderDetailView alloc]init];
    header.titleC.text = [JCLKitObj timeStampString:self.tradingmodel.openTime];
    header.titleE.text = [JCLKitObj timeStampString:self.tradingmodel.latestTime];
    if ([self.tradingmodel.status isEqualToString:@"Cancelled"]) {
        header.titleA.text = @"手动撤销";
        header.titleD.text = @"撤销时间";
    }else{
        header.titleA.text = @"已成交";
        header.titleE.text = [JCLKitObj timeStampString:self.tradingmodel.latestTime];
    }
    
    return header;
    
};


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        JCLBaseTableViewCell *cellB = [tableView dequeueReusableCellWithIdentifier:@"JCLBaseTableViewCell" forIndexPath:indexPath];
        cellB.textLabel.textColor = [UIColor whiteColor];
        //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cellB.textLabel.font=[UIFont fontWithName:@"PingFang-SC-Medium" size: 15];
        cellB.textLabel.text =[NSString stringWithFormat:@"%@(%@)",self.tradingmodel.stock.cn_name,self.tradingmodel.symbol] ;
        return cellB;
    }else{
        TSJRTradingOrderDetailCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"TSJRTradingOrderDetailCell" forIndexPath:indexPath];
        if (indexPath.row == 1) {
            cell.titleA.text = @"交易账户";
            cell.titleB.text = @"模拟账户";
            cell.titleC.text = @"交易方向";
            cell.titleD.text = [JCLKitObj actionType: self.tradingmodel.action];
            cell.titleD.textColor = [UIColor orangeColor];
            return cell;
        }else if (indexPath.row == 2){
            cell.titleA.text = @"订单类型";
            cell.titleB.text = [NSString stringWithFormat:@"%@单", [JCLKitObj orderType:self.tradingmodel.orderType]];
            cell.titleC.text = @"委托数量";
            cell.titleD.text = self.tradingmodel.totalQuantity;
            return cell;
        }else if (indexPath.row == 3){
            cell.titleA.text = @"成交数量";
            cell.titleB.text =  self.tradingmodel.filledQuantity;
            cell.titleC.text = @"限价";
            cell.titleD.text = [JCLKitObj moneyFormat:self.tradingmodel.limitPrice] ;
            cell.titleD.textColor = [UIColor yellowColor];
            return cell;
        }else if (indexPath.row == 4){
            cell.titleA.text = @"成交均价";
            cell.titleB.text = self.tradingmodel.avgFillPrice.floatValue>0 ?[JCLKitObj countNumAndChangeformat:self.tradingmodel.avgFillPrice]:@"--" ;
            cell.titleB.textColor = [UIColor yellowColor];
            cell.titleC.text = @"期限";
            cell.titleD.text = @"当日有效";
            return cell;
        }else if (indexPath.row == 5){
            cell.titleA.text = @"盘前盘后";
            cell.titleB.text = self.tradingmodel.outsideRth.intValue == 0?@"不允许":@"允许"; // @"允许";
           
            cell.titleC.text = @"佣金和平台使用费";
            cell.titleC.font = [UIFont systemFontOfSize:10];;
 
            [cell.titleC mas_updateConstraints:^(MASConstraintMaker *make) {
              make.width.mas_equalTo(100);
            }];
            cell.titleD.text = self.tradingmodel.commission.floatValue>0?self.tradingmodel.commission:@"--";
            return cell;
        }else if (indexPath.row == 6){
            cell.titleA.text = @"币种";
            cell.titleB.text = self.tradingmodel.currency;
            return cell;
        }
    }
    return nil;
}
 
@end
