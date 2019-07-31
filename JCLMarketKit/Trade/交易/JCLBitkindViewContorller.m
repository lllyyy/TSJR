//
//  JCLBitkindViewContorller.m
//  JCLFutures
//
//  Created by apple on 2018/6/21.
//  Copyright © 2018年 邢昭俊. All rights reserved.
//

#import "JCLBitkindViewContorller.h"
#import "JCLSocketObj.h"
#import "AppDelegate.h"
#import "JCLTradeDefine.h"
@interface JCLBitkindViewContorller ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *textArray;
@property(nonatomic,strong)NSArray *detailArray;
@end

@implementation JCLBitkindViewContorller
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    NSDictionary *dic = @{ @"client_id" :[JCLUserData getUserInfo].username};
    [[JCLSocketObj share] JCLSocketRequst:dic idx:JCL_PROTOCOL_ZJCX];
     [JCLSocketObj share].socketActionBlock = ^(NSDictionary *dic, NSInteger idx) {
         
         if (idx==JCL_PROTOCOL_ZJCX) {
             
             NSLog(@"--%@",dic);
             
             if ([dic[@"status"]intValue]==0) {
                 
                 self.detailArray  =@[@"CNY",
                                      [NSString stringWithFormat:@"%.2f",[dic[@"data"][@"pre_fund_balance"]doubleValue]],
                                      [NSString stringWithFormat:@"%.2f",[dic[@"data"][@"total_closeprofit"]doubleValue]],
                                      [NSString stringWithFormat:@"%.2f",[dic[@"data"][@"total_floatprofit"]doubleValue]],
                                      [NSString stringWithFormat:@"%.2f",[dic[@"data"][@"margin_balance"]doubleValue]],
                                      [NSString stringWithFormat:@"%.2f",[dic[@"data"][@"freeze_balance"]doubleValue]]];
                 [self.table reloadData];
                 
             }
         }
     };
//     AppDelegate.shareAppDelegate.pollingAtionBlock = ^(){
//       
//         NSDictionary *dic = @{ @"client_id" : PreRead(JCLUserInfo)[@"username"] };
//         [[JCLSocketObj share] JCLSocketRequst:dic idx:JCL_PROTOCOL_ZJCX];
//         
//     };
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.textArray = @[@"币种:",@"静态权益:",@"平仓盈亏:",@"持仓盈亏:",@"占用保证金:",@"冻结保证金:"];
     self.detailArray = @[@"CNY",@"",@"",@"",@"",@""];
    self.navi.middle.title  =@"资金详情";
    self.table.y = JCLNAVI;
    self.table.height = JCLHEIGHT-JCLNAVI-JCLTABHEIGHT;
    self.table.separatorColor = JCL_Bg_COL;
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.detailTextLabel.text  = self.detailArray[indexPath.row];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = self.textArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = JCL_Cell_COL;
    cell.selectionStyle = 0;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55*JCLWIDTH/375;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
