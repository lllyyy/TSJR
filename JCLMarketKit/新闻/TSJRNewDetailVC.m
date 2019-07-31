//
//  TSJRNewDetailVC.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/21.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "TSJRNewDetailVC.h"
#import "TSJRNewDetailCell.h"
NSString * const AttributedTextCellReuseIdentifier = @"AttributedTextCellReuseIdentifier";
@interface TSJRNewDetailVC ()

@end

@implementation TSJRNewDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navi.middle.title = @"详情";
    [self.table registerClass:[TSJRNewDetailCell class] forCellReuseIdentifier:AttributedTextCellReuseIdentifier];
    [self loadData];
}

-(void)loadData{
    //    新闻列表
    
    NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlE,@"newsDetail"];
    [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    [JCLHttps httpPOSTRequest:postUrl params:@{@"newsid":self.did} success:^(id obj) {
        NSLog(@"objobj %@",obj);
        MMResultModel *model =(MMResultModel *)obj;
        if (model.code.intValue == 200&&model.data.count > 0) {
           [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.conten = model.data[0][@"content"];
            self.navi.middle.title =  model.data[0][@"title"];
           [self.table reloadData];
            
        }
        [self.table.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [JCLFramework showErrorHud:@"服务器异常"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.conten.length ==0) {
        return 0;
    }
    return 1;
}

- (void)configureCell:(DTAttributedTextCell *)cell forIndexPath:(NSIndexPath *)indexPath{
    if (self.conten.length >0) {
        
        
        NSAttributedString *toHTMLString = [JCLKitObj attributedStringWithHTMLString: self.conten];
       NSLog(@"--toHTMLStringtoHTMLString---- %@",toHTMLString);
        NSString *str2 =  [JCLKitObj createHTMLFile2:self.conten];
           NSLog(@"--str2str2---- %@",str2);
        str2 = [str2 stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
        [cell setHTMLString:str2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.attributedTextContextView.shouldDrawImages = YES;
        cell.attributedTextContextView.backgroundColor = JCL_Cell_COL;
 
    }
   
}


- (DTAttributedTextCell *)tableView:(UITableView *)tableView preparedCellForIndexPath:(NSIndexPath *)indexPath
{
    
    TSJRNewDetailCell *cell = [[TSJRNewDetailCell alloc] initWithReuseIdentifier:AttributedTextCellReuseIdentifier];
    
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}

// disable this method to get static height = better performance
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TSJRNewDetailCell *cell = (TSJRNewDetailCell *)[self tableView:tableView preparedCellForIndexPath:indexPath];
    return [cell requiredRowHeightInTableView:tableView];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        TSJRNewDetailCell *cell = (TSJRNewDetailCell *)[self tableView:tableView preparedCellForIndexPath:indexPath];
 
        return cell;
  
}



@end
