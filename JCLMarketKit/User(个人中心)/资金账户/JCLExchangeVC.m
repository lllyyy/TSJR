//
//  JCLExchangeVC.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/26.
//  Copyright © 2019 邢昭俊. All rights reserved.
//

#import "JCLExchangeVC.h"
#import "JCLExchangeView.h"
#import "JCLEXcahngeCell.h"
@interface JCLExchangeVC ()

@end

@implementation JCLExchangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navi.middle.title = @"兑换";
    self.table.separatorColor = JCL_Bg_COL;
    self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    
    [self.table registerClass:[JCLEXcahngeCell class] forCellReuseIdentifier:@"JCLEXcahngeCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    
    if (section == 2 || section == 3) {
        return 2;
    }
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return 200;
    }
    return 10;;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 3) {
        UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(15, 15, JCLWIDTH - 30,150)];
        bgview.backgroundColor = JCL_Bg_COL;
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 15)];
        title.text = @"提示";
        title.font = [UIFont systemFontOfSize:14];
        title.textColor = JCLAccountRGB;
        [bgview addSubview:title];
        
        UILabel *titleA = [[UILabel alloc]initWithFrame:CGRectMake(15, title.bottom + 10, kScreenWidth-30, 150-30)];
        titleA.text = @"1.目前支持现金兑换工能，不提供融资的货币兑换。\n2.目前支持现金兑换工能，不提供融资的货币兑换。\n3.目前支持现金兑换工能，不提供融资的货币兑换。\n4.目前支持现金兑换工能，不提供融资的货币兑换。\n5.目前支持现金兑换工能，不提供融资的货币兑换。";
        titleA.numberOfLines = 0;
        titleA.font = [UIFont systemFontOfSize:14];
        titleA.textColor = JCLAccountRGB;
        [bgview addSubview:titleA];
        
        
        return bgview;
    }
    return nil;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    JCLExchangeView *header = [[JCLExchangeView alloc]init];
    if (section == 0) {
        header.titleLabel.text = @"当前汇率";
        header.descLabel.text = @"1美元 = 7.8473港币";
        header.descLabel.textColor = [UIColor whiteColor];
    }else if (section == 1){
        header.titleLabel.text = @"兑换";
    }else if (section == 2){
        header.titleLabel.text = @"兑换前资金";
    }else if (section == 3){
        header.titleLabel.text = @"兑换后资金";
    }
    return header;
};


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 0;
    }else if (indexPath.section == 1){
        return 200;
    }else if (indexPath.section == 2){
        return 45;
    }else{
        return 45;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil ;
    
    NSString *cellIdentifier = @"SettingViewCell";
    cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = JCL_Cell_COL;
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    cell.detailTextLabel.textColor=[UIColor whiteColor];
    cell.detailTextLabel.font=[UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 1) {
        JCLEXcahngeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JCLEXcahngeCell" forIndexPath:indexPath];
        return cell;
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"美元 (主币种)";
            cell.detailTextLabel.text = @"24898.20";
        }else{
            cell.textLabel.text = @"港币";
            cell.detailTextLabel.text = @"784.20";
        }
        
    }else{
        if (indexPath.row == 0) {
            cell.textLabel.text = @"美元 (主币种)";
            cell.detailTextLabel.text = @"--";
        }else{
            cell.textLabel.text = @"港币";
            cell.detailTextLabel.text = @"--";
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
}



@end
