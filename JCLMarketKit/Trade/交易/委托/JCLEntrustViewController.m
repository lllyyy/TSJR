//
//  JCLEntrustViewController.m
//  JCLFutures
//
//  Created by apple on 2018/12/5.
//  Copyright © 2018年 邢昭俊. All rights reserved.
//

#import "JCLEntrustViewController.h"
#import "JCLTradeCell.h"
#import "JCLBarList.h"
@interface JCLEntrustViewController ()
@property(nonatomic,strong)NSArray *keys;
@end

@implementation JCLEntrustViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navi.hidden = YES;
    self.keys =  @[@"合约名称", @"状态", @"买卖", @"委托价", @"委托量"];
    self.table.y = 0;
    self.table.height = self.listH;
    // Do any additional setup after loading the view.
}
-(void)reloadData:(NSMutableArray *)array{
    self.vals=array;
    [self.table reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{ return 1; }
-(nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    JCLBarList *bar = [[JCLBarList alloc]init];
    bar.isAction = YES;
    bar.vals = self.keys;
    return bar;
};
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{ return [JCLKitObj JCLHeight:44]; }

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.vals.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ return [JCLKitObj JCLHeight:44]; }
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    JCLTradeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell = [[JCLTradeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.orderIndex = 2;
    if (self.vals) {
        NSDictionary *obj = self.vals[indexPath.row];
        NSString *market = obj[@"exchange_type"];
        NSString *code;
        switch (market.intValue) {
            case 3:
            {
                code = [NSString stringWithFormat:@"SF%@", obj[@"stock_code"]];
                
            }
                break;
            case 4:
            {
                code = [NSString stringWithFormat:@"SC%@", obj[@"stock_code"]];
                
            }
                break;
            case 5:
            {
                
                code = [NSString stringWithFormat:@"DC%@", obj[@"stock_code"]];
                
            }
                break;
            case 6:
            {
                
                code = [NSString stringWithFormat:@"ZC%@", obj[@"stock_code"]];
            }
                break;
            case 24:
            {
                
                code = [NSString stringWithFormat:@"OIL%@", obj[@"stock_code"]];
            }
                break;
                
            default:
                break;
        }
        NSArray *code_obj =  [JCLMarketObj JCLSearchCode:code];
         [self EntrustCell:cell obj:obj with:code_obj];
    }
    return cell;
}
-(void)EntrustCell:(JCLTradeCell *)cell obj:(NSDictionary *)obj with:(NSArray *)array{
    cell.lab1.text = [NSString stringWithFormat:@"%@", obj[@"stock_name"]];
    if ([obj[@"entrust_status"] integerValue] == 0) { cell.lab2.text = @"已报"; }
    if ([obj[@"entrust_status"] integerValue] == 1) { cell.lab2.text = @"已撤"; }
    if ([obj[@"entrust_status"] integerValue] == 2) { cell.lab2.text = @"全成"; }
    if ([obj[@"entrust_status"] integerValue] == 3) { cell.lab2.text = @"部成"; }
    if ([obj[@"entrust_status"] integerValue] == 4) { cell.lab2.text = @"部撤"; }
    if ([obj[@"entrust_status"] integerValue] == 5) { cell.lab2.text = @"废单"; }
    if ([obj[@"entrust_status"] integerValue] == 6) { cell.lab2.text = @"报单中"; }
    if ([obj[@"entrust_status"] integerValue] == 7) { cell.lab2.text = @"撤单中"; }
    
    if ([obj[@"entrust_bs"] integerValue] == 0) {
        cell.lab3.text = @"买"; cell.lab3.textColor = JCLRISERGB;
    } else {
        cell.lab3.text = @"卖"; cell.lab3.textColor = JCLFALLRGB;
    }
    if ([obj[@"direction_type"] integerValue] == 1) {
        cell.lab3.text = @"平"; cell.lab3.textColor = JCLFALLRGB;
    }
//    if ([obj[@"direction_type"] integerValue] == 0) {
//
//    } else if([obj[@"direction_type"] integerValue] == 2) {
//
//        if ([obj[@"entrust_bs"] integerValue] == 0) {
//            cell.lab3.text = @"买平今"; cell.lab3.textColor = JCLRISERGB;
//        } else {
//            cell.lab3.text = @"卖平今"; cell.lab3.textColor = JCLFALLRGB;
//        }
//    }else if([obj[@"direction_type"] integerValue] == 3) {
//
//        if ([obj[@"entrust_bs"] integerValue] == 0) {
//            cell.lab3.text = @"买平昨"; cell.lab3.textColor = JCLRISERGB;
//        } else {
//            cell.lab3.text = @"卖平昨"; cell.lab3.textColor = JCLFALLRGB;
//        }
//    }
    cell.lab4.text = [JCLMarketObj JCLMarketPrice:[obj[@"entrust_price"] floatValue] decimal:[NSString stringWithFormat:@"%@",array[4]]];
    cell.lab5.text = [NSString stringWithFormat:@"%@", obj[@"entrust_vol"]];
    
    
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
