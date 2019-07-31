//
//  JCLUserListVC.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/21.
//  Copyright © 2019 邢昭俊. All rights reserved.
//

#import "JCLUserListVC.h"
#import "JCLUserListVM.h"
#import "JCLUserHeader.h"
#import "JCLBaseTableViewCell.h"

@interface JCLUserListVC ()
@property (nonatomic, weak) JCLUserHeader *header;
@property (nonatomic, strong) JCLUserListVM *viewModel;
@end

@implementation JCLUserListVC
@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JCLUserHeader *header = [[JCLUserHeader alloc]init];
    header.height = 100;
    self.header = header;
    [header tapActionBlock:^{
        if (name().length == 0){
            JCLLOGIN;
            return;
            
        };
//        [self.navigationController pushViewController:[[JCLUserInfoList alloc]init] animated:YES];
    }];
    self.tableView.tableHeaderView = header;
    self.tableView.separatorColor = JCL_Bg_COL;
    [self.tableView registerClass:[JCLBaseTableViewCell class] forCellReuseIdentifier:@"JCLBaseTableViewCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JCLBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JCLBaseTableViewCell" forIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor whiteColor];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.textLabel.text = @"账号管理";
    return cell;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
