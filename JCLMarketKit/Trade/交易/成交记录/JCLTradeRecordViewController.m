//
//  JCLTradeRecordViewController.m
//  JCLFutures
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018年 邢昭俊. All rights reserved.
//

#import "JCLTradeRecordViewController.h"
#import "JCLTradeRecordCell.h"
#import "JCLTradeRecordHeader.h"
#import "JCLSocketObj.h"
#import "JCLTradDateHeader.h"
#import "JCLTradeDefine.h"
@interface JCLTradeRecordViewController ()
@property (nonatomic, strong) JCLTradDateHeader *header;
@end

@implementation JCLTradeRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navi.middle.title =self.kind==TradeToday?@"当日成交":@"历史成交";
    self.table.tableHeaderView = [self header];
    if (self.kind==TradeToday) {
        
        NSDictionary *dic = @{
                              @"client_id" :  [JCLUserData getUserInfo].username, // 用户代码
                              @"start" : @(0), // 起始序号
                              @"limit" : @(500), // 请求行数
                              @"entrust_type" : @(0), // 交易类型 0.所有 1.股票 2.组合 3.比赛
                              @"entrust_typeid" : @(0), // 交易类型编号 当类型为2 时为组合编号，为3 时比赛ID
                              };
         [[JCLSocketObj share] JCLSocketRequst:dic idx:JCL_PROTOCOL_CJCX];
    } else{
        
        JCLTradDateHeader *header = [[JCLTradDateHeader alloc]init];
        [self.view addSubview:header];
        header.frame = CGRectMake(0, JCLNAVI, JCLWIDTH, 50*JCLWIDTH/375);
        [header.submit tapActionBlock:^{
            self.vals = [NSMutableArray array];
            [JCLFramework JCLProgressHUD:@"加载中..."];
            NSDictionary *dic = @{
                                  @"client_id" :   [JCLUserData getUserInfo].username,
                                  @"start" : @(0),
                                  @"limit" : @(444),
                                  @"start_date" : @(header.beginVal.integerValue),
                                  @"end_date" : @(header.endVal.integerValue),
                                  };
            
            [[JCLSocketObj share] JCLSocketRequst:dic idx:JCL_PROTOCOL_LSCJ];
            
        }];
        NSDictionary *dic = @{
                              @"client_id" :   [JCLUserData getUserInfo].username,
                              @"start" : @(0),
                              @"limit" : @(444),
                              @"start_date" : @(header.beginVal.integerValue),
                              @"end_date" : @(header.endVal.integerValue),
                              };
        
        [[JCLSocketObj share] JCLSocketRequst:dic idx:JCL_PROTOCOL_LSCJ];
        self.table.y = JCLNAVI + 50*JCLWIDTH/375;;
        self.table.height = JCLHEIGHT - JCLNAVI - 50*JCLWIDTH/375;
       
    }
    [JCLSocketObj share].socketActionBlock = ^(NSDictionary *dic, NSInteger idx) {
        
        if (idx==JCL_PROTOCOL_CJCX||idx==JCL_PROTOCOL_LSCJ) {
            [JCLFramework Dismiss];
            NSLog(@"---%@",dic);
            if ([dic[@"status"] isEqualToNumber:@(0)]) {
                NSArray *data = dic[@"records"];
                NSMutableArray *array = data.mutableCopy;
                if (self.kind==TradeToday) {
                    
                    for (int i=0; i<array.count; i++) {
                        
                        NSInteger time = [array[i][@"business_time"] integerValue];
                        
                        for (int j=i+1; j<array.count; j++) {
                            
                            NSInteger next_time = [array[j][@"business_time"] integerValue];
                            
                            if (time<next_time) {
                                
                                [array exchangeObjectAtIndex:i withObjectAtIndex:j];
                            }
                        }
                    }
                }
                [self.vals addObjectsFromArray:array];
                [self.table reloadData];
                [JCLFramework Dismiss];
            }else{
                
                [JCLFramework showErrorHud:dic[@"describe"]];
            }
        }
    };
    // Do any additional setup after loading the view.
}
-(JCLTradeRecordHeader *)header{
    JCLTradeRecordHeader *header = [[JCLTradeRecordHeader alloc]initWithFrame:CGRectMake(0, 0, JCLWIDTH, 30*JCLWIDTH/375)];
    header.backgroundColor = JCL_Cell_COL;
    return header;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.vals.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JCLTradeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[JCLTradeRecordCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
     NSDictionary *obj = self.vals[indexPath.row];
    NSString *market = obj[@"exchange_type"];
    NSString *code;
    switch (market.intValue) {
        case 21:
        {
            
            code = [NSString stringWithFormat:@"NYSE%@", obj[@"stock_code"]];
            
        }
            break;
        case 22:
        {
            code = [NSString stringWithFormat:@"NASDAQ%@", obj[@"stock_code"]];
            
        }
            break;
        case 23:
        {
            
            code = [NSString stringWithFormat:@"  AMERICAN%@", obj[@"stock_code"]];
            
        }
            break;
            
        default:
            break;
    }
    NSArray *code_obj =  [JCLMarketObj JCLSearchCode:code];
    cell.name.text = obj[@"stock_name"];
//    if ([obj[@"direction_type"] integerValue] == 0) { //开仓
//
//        if ([obj[@"entrust_bs"] integerValue] == 0) {
//
//            cell.trade_direction.text = @"买开"; cell.trade_direction.textColor = JCLRISERGB;
//
//        } else {
//            cell.trade_direction.text = @"卖开"; cell.trade_direction.textColor = JCLFALLRGB;
//        }
//    } else if ([obj[@"direction_type"] integerValue] == 2){
//
//        if ([obj[@"entrust_bs"] integerValue] == 0) {
//            cell.trade_direction.text = @"买平今"; cell.trade_direction.textColor = JCLRISERGB;
//        } else {
//            cell.trade_direction.text = @"卖平今"; cell.trade_direction.textColor = JCLFALLRGB;
//        }
//    }else if ([obj[@"direction_type"] integerValue] ==3){
//
//        if ([obj[@"entrust_bs"] integerValue] == 0) {
//            cell.trade_direction.text = @"买平昨";
//            cell.trade_direction.textColor = JCLRISERGB;
//        } else {
//            cell.trade_direction.text = @"卖平昨";
//            cell.trade_direction.textColor = JCLFALLRGB;
//        }
//    }
    if ([obj[@"entrust_bs"] integerValue] == 0) {
        cell.trade_direction.text = @"买"; cell.trade_direction.textColor = JCLRISERGB;
    } else {
        cell.trade_direction.text = @"卖"; cell.trade_direction.textColor = JCLFALLRGB;
    }
    if ([obj[@"direction_type"] integerValue] == 1) {
        cell.trade_direction.text = @"平"; cell.trade_direction.textColor = JCLFALLRGB;
    }
    cell.trade_price.text = [JCLMarketObj JCLMarketPrice:[obj[@"business_price"] floatValue] decimal:[NSString stringWithFormat:@"%@",code_obj[4]]];
    cell.trade_number.text = [NSString stringWithFormat:@"%@", obj[@"business_vol"]];
   
    cell.trade_fee.text = [NSString stringWithFormat:@"%.5f",  [obj[@"fee"] doubleValue]];
    if ([obj[@"hedge_type"]intValue]==4) {
        
        cell.trade_kind.text = @"(风控强平)";
        
    }else if ([obj[@"hedge_type"]intValue]==5){
        
        cell.trade_kind.text = @"(止盈止损)";
        
    }else if ([obj[@"hedge_type"]intValue]==0){
        
        cell.trade_kind.text = @"(普通成交)";
    }
    NSString *time = [NSString stringWithFormat:@"%@",obj[@"business_date"]];
    NSString *front = [NSString stringWithFormat:@"%@-%@-%@", [time substringWithRange:NSMakeRange(0, 4)], [time substringWithRange:NSMakeRange(4, 2)], [time substringWithRange:NSMakeRange(6, 2)]];
    cell.trade_time.text = [NSString stringWithFormat:@"%@\n%@",front,[self JCLTime:obj[@"business_time"]]];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = JCL_Cell_COL;
    cell.selectionStyle = 0;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60*JCLWIDTH/375;
}
-(NSString *)JCLTime:(NSString *)val{
    
    NSString *time_val = [NSString stringWithFormat:@"%@",val];
    
    NSString *time = [NSString stringWithFormat:@"%02d:%02d:%02d",time_val.intValue/10000,time_val.intValue/100%100,time_val.intValue%100];
    
    return time;
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
