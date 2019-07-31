//
//  JCLAccountOverviewVC.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/18.
//  Copyright © 2019 邢昭俊. All rights reserved.
//

#import "JCLAccountOverviewVC.h"
#import "JCLAccountHeaderView.h"
#import "JCLSimulationAccountVC.h"
#import "JCLAccountFootView.h"
#import "MMResultV2Model.h"
#import "JCLAccountModel.h"
#import "TSJRAccountOverHeaderView.h"
#import "TSJRQueryAssetCell.h"

@interface JCLAccountOverviewVC ()
@property (nonatomic,strong) JCLAccountModel *accountModelA;
@property (nonatomic,strong) JCLAccountModel *accountModel;
@end

@implementation JCLAccountOverviewVC


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [self loadData];
    self.navi.middle.title = @"账户总览";
    [self.table registerClass: [JCLAccountHeaderView class] forCellReuseIdentifier:@"JCLAccountHeaderView"];
    [self.table registerClass: [TSJRAccountOverHeaderView class] forCellReuseIdentifier:@"TSJRAccountOverHeaderView"];
    [self.table registerClass: [TSJRQueryAssetCell class] forCellReuseIdentifier:@"TSJRQueryAssetCell"];
}

-(void)loadData{
     [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
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
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
            [self.table reloadData];
        } failure:^(NSError *error) {
             [MBProgressHUD hideHUDForView:self.view  animated:YES];
            [JCLFramework showErrorHud:@"服务器异常"];
        }];
    }
    
//    NSString *postUrlA = [NSString stringWithFormat:@"%@/%@",baseApiURlB,@"queryAsset"];
//    [JCLHttps httpPOSTRequest:postUrlA params:@{@"userId":userId(),@"accountType":@"0"} success:^(id obj) {
//        NSLog(@"objobjaadffadsfdsfdsf %@",obj);
//        MMResultV2Model *model =(MMResultV2Model *)obj;
//        if (model.code.intValue == 200) {
//            self.accountModelA = [JCLAccountModel modelWithDictionary:model.data[0]];
//         }
//         [MBProgressHUD hideHUDForView:self.view  animated:YES];
//        [self.table reloadData];
//    } failure:^(NSError *error) {
//         [MBProgressHUD hideHUDForView:self.view  animated:YES];
//        [JCLFramework showErrorHud:@"服务器异常"];
//    }];
    
    
}
 -(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return 2;
 }
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            return  90;
        }
        
        if (indexPath.row == 1&&[[JCLUserSession getCurrentAccount] isEqualToString:@"0"]) {//模拟账户
            return  265;
        }
        return 185;
        
    }
    return 185;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, JCLWIDTH, 45)];
    UILabel *title  = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, (JCLWIDTH-30), 15)];
    title.text = @"—— 模拟账户 ——";
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont systemFontOfSize:15];
    title.textAlignment = NSTextAlignmentCenter;
    [bgview addSubview:title];
    if (section == 0) {
        title.text = @"—— 实盘账户 ——";
    }
    
    return bgview;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        JCLAccountFootView *foot = [[JCLAccountFootView alloc]init];
        foot.titleLabel.text = @"收益不错，实盘来一波";
        return foot;
    }
    return nil;
};
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
       return 30;
    }
    return 0.1;
 }

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   if (indexPath.section == 0) {
       if (indexPath.row == 0) {
           TSJRAccountOverHeaderView *cell =  [tableView dequeueReusableCellWithIdentifier:@"TSJRAccountOverHeaderView" forIndexPath:indexPath];
           if (self.accountModel !=nil) {
               [cell setDataModel:self.accountModel];
           }
           return cell;
       }else if (indexPath.row == 1 && [[JCLUserSession getCurrentAccount] isEqualToString:@"0"]){
            TSJRQueryAssetCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"TSJRQueryAssetCell" forIndexPath:indexPath];
           return cell;
       }else{
           JCLAccountHeaderView *cell =  [tableView dequeueReusableCellWithIdentifier:@"JCLAccountHeaderView" forIndexPath:indexPath];
           if (self.accountModel !=nil) {
               [cell setDataModel:self.accountModel account:indexPath.section];
           }
           return cell;
       }
    }
   JCLAccountHeaderView *cell =  [tableView dequeueReusableCellWithIdentifier:@"JCLAccountHeaderView" forIndexPath:indexPath];
    if (self.accountModelA !=nil) {
       [cell setDataModel:self.accountModelA account:indexPath.section];
   }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        JCLSimulationAccountVC *vc =[[JCLSimulationAccountVC alloc]init];
        vc.accountModel = self.accountModel;
        [self.navigationController pushViewController:vc animated:YES];
    }
 }

@end
