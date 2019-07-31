//
//  JCLTradDealList.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/10.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradDealList.h"
#import "JCLTradDateHeader.h"
#import "JCLTradDealCell.h"
#import "JCLSocketObj.h"
#import "JCLMarketOptionHeader.h"

@interface JCLTradDealList ()
@property (nonatomic, assign) NSInteger page;
@end

@implementation JCLTradDealList
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navi.middle.title = @"交易历史";
        JCLTradDateHeader *header = [[JCLTradDateHeader alloc]init]; [self.view addSubview:header];
        header.frame = CGRectMake(0, JCLNAVI, JCLWIDTH, 0.1*JCLHEIGHT);
        self.table.y = header.maxY , self.table.height = JCLHEIGHT-header.maxY;
    
   
    
    [JCLSocketObj share].socketActionBlock = ^(NSDictionary *dic, NSInteger idx) {
        if ([dic[@"status"] isEqualToNumber:@(0)]) {
 
        } else {
            [JCLFramework JCLProgressHUD:dic[@"describe"]];
        }
    };
    
    self.page = 30;
}

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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return 4;//self.arrM.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ return 0.23*JCLHEIGHT; }
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    JCLTradDealCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLTradDealCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.code.text = [NSString stringWithFormat:@"%@", @"--"];
    cell.bs.text = @"买入";
    cell.bs.backgroundColor = JCL_Rise_COL;
    cell.bs.text = @"卖出";
    cell.bs.backgroundColor = JCL_Fall_COL;
    
    cell.price.text = [NSString stringWithFormat:@"成交价格\n %@", @"--"];
    cell.num.text = [NSString stringWithFormat:@"成交数量\n %@", @"--"];
    cell.money.text = [NSString stringWithFormat:@"成交总额\n %@", @"--"];
    cell.time.text = [NSString stringWithFormat:@"%@", @"--"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
