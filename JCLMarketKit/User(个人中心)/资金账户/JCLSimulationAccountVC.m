//
//  JCLAccountOverviewVC.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/18.
//  Copyright © 2019 邢昭俊. All rights reserved.
//

#import "JCLSimulationAccountVC.h"
#import "JCLAccountHeaderView.h"
#import "JCLAccountInstructionsVC.h"
#import "JCLAccountFootView.h"
#import "JCLExchangeVC.h"

@interface JCLSimulationAccountVC ()

@end

@implementation JCLSimulationAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navi.middle.title = @"模拟总览";
//    self.table = [JCLKitObj JCLTable:self.view target:self frame:CGRectMake(0, JCLNAVI, JCLWIDTH, JCLSCROLL) style:UITableViewStyleGrouped];
  
    [self.table registerClass: [JCLAccountHeaderView class] forCellReuseIdentifier:@"JCLAccountHeaderView"];
    [self.table registerClass: [JCLAccountFootView class] forCellReuseIdentifier:@"JCLAccountFootView"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
 }

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 185+140;
    }else if (indexPath.section == 1){
        return 185-70;
    }else if (indexPath.section == 2){
        return 185-70;
    }else{
        return 45;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if (indexPath.section == 0) {
        JCLAccountHeaderView *cell =  [tableView dequeueReusableCellWithIdentifier:@"JCLAccountHeaderView" forIndexPath:indexPath];
        cell.blogo.hidden = YES;
        
        cell.title.text = [NSString stringWithFormat:@"保证金账户  %@",self.accountModel.currency];
        cell.titleB.text = @"持仓盈亏";
        cell.digitalB.textColor =  JCLRGB(75, 240, 178);
        cell.titleC.text = @"现金额";
        cell.titleD.text = @"剩余T+0次数";
        cell.digitalD.textColor = [UIColor yellowColor];
        
        cell.digitalA.text = [JCLKitObj countNumAndChangeformat:self.accountModel.equityWithLoan];
        cell.digitalB.text = self.accountModel.unrealizedPnL;
        cell.digitalC.text = [JCLKitObj moneyFormat:self.accountModel.cashBalance];
        cell.digitalD.text = [JCLKitObj countNumAndChangeformat:self.accountModel.unrealizedPnL];
        cell.digitalD.text = [JCLKitObj countNumAndChangeformat:self.accountModel.buyingPower];
        return cell;
     }else if (indexPath.section == 1){
         JCLAccountHeaderView *cell =  [tableView dequeueReusableCellWithIdentifier:@"JCLAccountHeaderView" forIndexPath:indexPath];
         cell.blogo.hidden = YES;
         cell.baseLB.hidden = NO;
         cell.baseLB.text = [NSString stringWithFormat:@"%@",[JCLKitObj moneyFormat:self.accountModel.excessLiquidity]];
         cell.title.text = @"风控值";
         cell.titleA.text = @"日内风控值";
         cell.digitalA.text = [NSString stringWithFormat:@"%@",[JCLKitObj moneyFormat:self.accountModel.excessLiquidity]];
         cell.titleB.text = @"隔夜风控值";
         cell.digitalB.text = [NSString stringWithFormat:@"%@",[JCLKitObj moneyFormat:self.accountModel.SMA]];
         cell.digitalA.textColor =  [UIColor whiteColor];;
         cell.digitalB.textColor =  [UIColor whiteColor];;
         return cell;
     }else if (indexPath.section == 2){
         JCLAccountHeaderView *cell =  [tableView dequeueReusableCellWithIdentifier:@"JCLAccountHeaderView" forIndexPath:indexPath];
         cell.blogo.hidden = YES;
         cell.baseLB.hidden = NO;
         cell.baseLB.text = @"兑换";
         cell.title.text = @"现金";
         
         cell.titleA.text = @"美元现金(USD)";
         cell.digitalA.text = [NSString stringWithFormat:@"%@",[JCLKitObj moneyFormat:self.accountModel.cashBalance]];
         cell.titleB.text = @"港币现金(HKD)";
         cell.digitalB.text = [NSString stringWithFormat:@"%@",[JCLKitObj moneyFormat:self.accountModel.cashBalance]];
         [cell.baseLB mas_updateConstraints:^(MASConstraintMaker *make) {
             make.right.mas_equalTo(-35);
         }];
         return cell;
     }else if (indexPath.section == 3){
        JCLAccountFootView *cell =  [tableView dequeueReusableCellWithIdentifier:@"JCLAccountFootView" forIndexPath:indexPath];
         cell.titleLabel.text = @"收益不错，实盘来一波";
         [cell.iconIV mas_updateConstraints:^(MASConstraintMaker *make) {
             make.top.mas_equalTo(15);
         }];
         [cell.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
             make.top.mas_equalTo(15);
         }];
         [cell.moreImg mas_updateConstraints:^(MASConstraintMaker *make) {
             make.top.mas_equalTo(15);
         }];
         
         cell.titleLabel.textColor = [UIColor whiteColor];
         return cell;
     }
    return nil;
 }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    JCLAccountInstructionsVC *vc = [[JCLAccountInstructionsVC alloc]init];
    
    if (indexPath.section == 0) {
        vc.dataArray = @[@"保证金账户",@"指标说明",@"总资产",@"持仓盈亏",@"现金额",@"剩余T+0次数",@"可用购买力",@"证券总价值",@"杠杆",@"账户保证金要求"].mutableCopy;
         [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 1){
        vc.dataArray = @[@"风控值",@"指标说明",@"日内风控值",@"隔夜分控制",@"强制平仓" ].mutableCopy;
         [self.navigationController pushViewController:vc animated:YES];
    } else{
        JCLExchangeVC *vca = [[JCLExchangeVC alloc]init];
        [self.navigationController pushViewController:vca animated:YES];
    }
    
    
   
}

@end
