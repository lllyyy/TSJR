//
//  JCLTradPositList.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/10.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradPositList.h"
#import "JCLTradBuySell.h"
#import "JCLMarketOptionHeader.h"
#import "JCLTradPositCell.h"
#import "JCLSocketObj.h"

@interface JCLTradPositList ()
@property (nonatomic, weak) JCLTradBuySell *buySell;
@end

@implementation JCLTradPositList

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navi.hidden = YES;
    
    JCLMarketOptionHeader *header = [[JCLMarketOptionHeader alloc]init]; [self.view addSubview:header];
    header.frame = CGRectMake(0, 0, JCLWIDTH, [JCLKitObj JCLHeight:44]);
    header.isAction = YES; header.arr = @[@"持仓股票", @"市值/数量", @"现价/成本", @"持仓盈亏"];
//    header.menuActionBlock = ^(NSInteger idx, NSInteger sortIdx){
//        switch (idx) {
//            case 0:  break;
//            case 1:  break;
//            case 2:  break;
//            default: break;
//        }
//        switch (sortIdx) {
//            case 0:  break;
//            case 1:  break;
//            case 2:  break;
//            default: break;
//        }
//        [self setNeedData];
//    };
    self.table.y = header.maxY, self.table.height = self.listH-header.maxY;

    [JCLSocketObj share].socketActionBlock = ^(NSDictionary *dic, NSInteger idx) {
        if ([dic[@"status"] isEqualToNumber:@(0)]) {
            [self.arrM addObjectsFromArray:dic[@"holders"]];
            [self.table reloadData];
        } else {
            [JCLFramework JCLProgressHUD:dic[@"describe"]];
        }
    };
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:2];
}
-(void)timerAction{ [self.table reloadData];  }

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setNeedData];
}

- (void)setNeedData{
    NSDictionary *dic = @{
                          @"client_id" : @"ZxmnX997137",
                          };
    [[JCLSocketObj share] JCLSocketRequst:dic idx:11103];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return 4; }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ return [JCLKitObj JCLHeight:66]; }
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    JCLTradPositCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLTradPositCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.code.text = [NSString stringWithFormat:@"%@\n%@", @"--", @"--"];
    cell.range.text = [NSString stringWithFormat:@"%@\n%@", @"--", @"--"];
    cell.vol.text = [NSString stringWithFormat:@"%@\n%@", @"--", @"--"];
    cell.price.text = [NSString stringWithFormat:@"%@\n%@", @"--", @"--"];
    return cell;
}
                           //    cell.label1.text=model.stock_name;
                           //    cell.label2.text=[NSString stringWithFormat:@"%.2f",model.income_balance];
                           //    cell.label2.textColor=[LHCObject Newprice:cell.label2.text Price:@"0.00"];
                           //    cell.label4.text=[NSString stringWithFormat:@"%.2f",model.keep_cost_price];
                           //    cell.label3.text=[NSString stringWithFormat:@"%d",model.current_vol];
                           //    cell.label5.text=model.stock_code;
                           //    cell.label6.text=[NSString stringWithFormat:@"%.2f%%",model.income_balance/([cell.label3.text floatValue]*[cell.label4.text floatValue])*100];//
                           //    cell.label7.text=[NSString stringWithFormat:@"%.0f",model.enable_vol];
                           //    cell.label8.text=[NSString stringWithFormat:@"%.2f",model.last_price];
                           
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //self.buySell.codeField.text = cell.label5.text;
   // [self.buySell codeAction:self.buySell.codeField];
}

- (void)buyAndSellAction{
    
}
@end
