//
//  JCLCarryViewController.m
//  JCLFutures
//
//  Created by apple on 2018/12/5.
//  Copyright © 2018年 邢昭俊. All rights reserved.
//

#import "JCLCarryViewController.h"
#import "JCLTradeCell.h"
#import "JCLBarList.h"
@interface JCLCarryViewController ()
@property(nonatomic,strong)NSArray *keys;
@property(nonatomic,strong)NSString *selectRow;
@end

@implementation JCLCarryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navi.hidden = YES;
    self.keys = @[@"合约名称", @"多空", @"手数/可用", @"当日盈亏", @"持仓均价"];
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
    cell.orderIndex = 0;
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
        if (self.selectRow!=nil) {
            
            if (self.selectRow.integerValue ==indexPath.row ) {
                
                cell.bg.backgroundColor = JCLRGB(27, 28, 36);
                
            }else{
                
                cell.bg.backgroundColor = JCL_Bg_COL;
            }
        } else {
            
            cell.bg.backgroundColor = JCL_Bg_COL;
        }
        NSArray *code_obj =  [JCLMarketObj JCLSearchCode:code];
        cell.lab1.text = [NSString stringWithFormat:@"%@", obj[@"stock_name"]];
        if ([obj[@"entrust_bs"] integerValue] != 1) {
            
            cell.lab2.text = @"多"; cell.lab2.textColor = JCLRISERGB;
            
        } else {
            
            cell.lab2.text = @"空"; cell.lab2.textColor = JCLFALLRGB;
        }
        cell.lab3.text = [NSString stringWithFormat:@"%@/%@", obj[@"current_vol"],obj[@"enable_vol"]];
        cell.lab4.text = [NSString stringWithFormat:@"%.1f",  [obj[@"profit"] floatValue]];
        cell.lab4.textColor = [JCLColorObj Newprice:cell.lab4.text Price:@"0.00"];
        cell.lab5.text =  [JCLMarketObj JCLMarketPrice:(([obj[@"current_vol"] intValue]-[obj[@"today_vol"] intValue])*[obj[@"settle_price"] floatValue] + [obj[@"today_price"] floatValue]*[obj[@"today_vol"] intValue])/[obj[@"current_vol"] intValue] decimal:[NSString stringWithFormat:@"%d", [code_obj[4] intValue] + 1]];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    if (self.vals.count==0) {
        
        return;
    }
    self.selectRow = [NSString stringWithFormat:@"%ld",indexPath.row];
    for (JCLTradeCell *cell in tableView.visibleCells) {
        
        cell.bg.backgroundColor = JCL_Bg_COL;
    }
    JCLTradeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.bg.backgroundColor = JCLRGB(27, 28, 36);
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
            
            code = [NSString stringWithFormat:@"AMERICAN%@", obj[@"stock_code"]];
            
        }
            break;
            
        default:
            break;
    }
    self.block(code,obj);
    
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
