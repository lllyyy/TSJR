//
//  JCLTradCancelList.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/10.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradCancelList.h"
#import "JCLTradCancelCell.h"
#import "JCLTradMenu.h"
#import "JCLSocketObj.h"

@interface JCLTradCancelList ()<UIAlertViewDelegate>
@end

@implementation JCLTradCancelList
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navi.hidden = YES;
    JCLTradMenu *header = [[JCLTradMenu alloc]init]; [self.view addSubview:header];
    header.frame = CGRectMake(0, 0, JCLWIDTH, 0.07*JCLHEIGHT);
    header.texts = @[@"日期/时间", @"简称/代码", @"价格", @"委托量", @"操作"];
    
    self.table.y = header.maxY, self.table.height = self.listH;
    [JCLSocketObj share].socketActionBlock = ^(NSDictionary *dic, NSInteger idx) {
        if ([dic[@"status"] isEqualToNumber:@(0)]) {
            switch (idx) {
                case 0:
                    // 撤单查询
                    break;
                case 1:
                    // 撤单
                    break;
                default:
                    break;
            }
        } else {
            [JCLFramework JCLProgressHUD:dic[@"describe"]];
        }
    };
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:2];
}
-(void)timerAction{ [self.table reloadData]; }

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
    JCLTradCancelCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLTradCancelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.time.text = [NSString stringWithFormat:@"%@\n%@", @"--", @"--"];
    cell.code.text = [NSString stringWithFormat:@"%@", @"--"];
    cell.price.text = [NSString stringWithFormat:@"%@", @"--"];
    cell.vol.text = [NSString stringWithFormat:@"%@", @"--"];
    cell.tag = indexPath.row;
    [cell.option addTarget:self action:@selector(cancelAction:)];
    return cell;
}
-(void)cancelAction:(UIButton *)sender{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"撤单委托" message:@"是否撤销该订单?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSDictionary *dic = @{
                          @"client_id" : @"ZxmnX997137",
                          };
    [[JCLSocketObj share] JCLSocketRequst:dic idx:11103];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
