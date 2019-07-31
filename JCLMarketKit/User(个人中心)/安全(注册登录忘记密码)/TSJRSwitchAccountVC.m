//
//  TSJRSwitchAccountVC.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/4/10.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "TSJRSwitchAccountVC.h"
#import "TSJRSwitchAccountCell.h"
#import "JCLAccountModel.h"
@interface TSJRSwitchAccountVC ()
@property (nonatomic,strong) JCLAccountModel *accountModel;
@property (nonatomic,strong) NSString *str;
@end

@implementation TSJRSwitchAccountVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navi.middle.title = @"交易账户切换";
    [self.table registerClass:[TSJRSwitchAccountCell class] forCellReuseIdentifier:@"TSJRSwitchAccountCell"];
    
}
-(void)loadData{
    
    if ([[JCLUserSession getCurrentAccount] isEqualToString:@"1"]) {
        NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlB,@"queryAsset"];
        NSLog(@"url %@",postUrl);
        
        [JCLHttps httpPOSTRequest:postUrl params:@{@"userId":userId()} success:^(id obj) {
            NSLog(@"objobj %@",obj);
            MMResultV2Model *model =(MMResultV2Model *)obj;
            if (model.code.intValue == 200) {
                NSLog(@"---model %@",model.data);
                self.accountModel = [JCLAccountModel modelWithDictionary:model.data[0]];
            }
           
            [self.table reloadData];
        } failure:^(NSError *error) {
          
            [JCLFramework showErrorHud:@"服务器异常"];
        }];
    }
    
    NSString *postUrlA = [NSString stringWithFormat:@"%@/%@",baseApiURlB,@"queryAsset"];
    [JCLHttps httpPOSTRequest:postUrlA params:@{@"userId":userId(),@"accountType":@"0"} success:^(id obj) {
        NSLog(@"objobjaadffadsfdsfdsf %@",obj);
        MMResultV2Model *model =(MMResultV2Model *)obj;
        if (model.code.intValue == 200) {
            self.accountModel = [JCLAccountModel modelWithDictionary:model.data[0]];
        }
        [self.table reloadData];
      
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view  animated:YES];
        [JCLFramework showErrorHud:@"服务器异常"];
    }];
    
//    NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlB,@"queryAsset"];
//    NSLog(@"url %@",postUrl);
//
//    [JCLHttps httpPOSTRequest:postUrl params:@{@"userId":userId()} success:^(id obj) {
//        NSLog(@"objobj %@",obj);
//        MMResultV2Model *model =(MMResultV2Model *)obj;
//        if (model.code.intValue == 200) {
//            self.accountModel = [JCLAccountModel modelWithDictionary:model.data[0]];
//        }
//        [self.table reloadData];
//    } failure:^(NSError *error) {
//        [JCLFramework showErrorHud:@"服务器异常"];
//    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TSJRSwitchAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TSJRSwitchAccountCell" forIndexPath:indexPath];
    cell.tag = indexPath.section;
    if (indexPath.section == 0) {
        cell.titleLB.text = @"天使实盘账户";
        
        cell.titleLBB.text = @"开户快、支持融资、交易便捷";
        if ([[JCLUserSession getCurrentAccount] isEqualToString:@"1"]) {
            [cell.imagebtn setImage:[UIImage imageNamed:@"icon_checked"] forState:0];
            cell.titleLBA.text = @"账户已入金";
        }else{
           [cell.imagebtn setImage:[UIImage imageNamed:@"icon_unchecked"] forState:0];
            cell.titleLBA.text = @"立即开通";
        }
       
    }else{
        cell.titleLB.text = @"天使模拟账户(USD)";
        cell.titleLBA.text =  self.accountModel.equityWithLoan;
        cell.titleLBB.text = @"体验交易，盈利得大奖";
        if ([[JCLUserSession getCurrentAccount] isEqualToString:@"0"]) {
            [cell.imagebtn setImage:[UIImage imageNamed:@"icon_checked"] forState:0];
        }else{
            [cell.imagebtn setImage:[UIImage imageNamed:@"icon_unchecked"] forState:0];
        }
    }
    
  
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TSJRSwitchAccountCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //    /customerapi/switchAccountType
    //    切换帐户类型

    if (indexPath.section == 0) {//正式
        self.str=@"1";
    }else{
        self.str=@"0";
    }
   [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlA,@"switchAccountType"];
    [JCLHttps httpPOSTRequest:postUrl params:@{@"type":self.str,@"userId":userId()} success:^(id obj) {
        MMResultV2Model *model = obj;
        if (model.code.intValue == 200) {
            [JCLUserSession setCurrentAccount:self.str];
            [JCLKitObj showMsg:model.message];
            [self.table reloadData];
        }
      [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [JCLFramework showErrorHud:@"服务器异常"];
    }];
}

@end
