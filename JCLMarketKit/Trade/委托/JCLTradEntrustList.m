//
//  JCLTradEntrust.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/10.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradEntrustList.h"
#import "JCLTradPositCell.h"
#import "JCLSocketObj.h"
#import "JCLTradDateHeader.h"
#import "JCLMarketOptionHeader.h"
#import "JCLTablePop.h"

@interface JCLTradEntrustList ()
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, weak) JCLTablePop *pop;

@property (nonatomic, weak) UIView *popBg;
@property (nonatomic, weak) JCLMarketOptionHeader *header;
@end

@implementation JCLTradEntrustList

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navi.middle.title = self.isHis ? @"历史委托" : @"当日委托";
    
    if (self.isHis) {
        JCLTradDateHeader *header = [[JCLTradDateHeader alloc]init]; [self.view addSubview:header];
        header.frame = CGRectMake(0, JCLNAVI, JCLWIDTH, 0.08*JCLHEIGHT);
        self.table.y = header.maxY , self.table.height = JCLHEIGHT-header.maxY;
    }
    
    JCLMarketOptionHeader *header = [[JCLMarketOptionHeader alloc]init]; [self.view addSubview:header];
    header.frame = CGRectMake(0, 0, JCLWIDTH, [JCLKitObj JCLHeight:44]);
    header.isAction = YES; header.arr = @[@"全部", @"名称代码", @"订单价/现价", @"数量/已成"];
//    header.menuActionBlock = ^(NSInteger idx, NSInteger sortIdx){
//        switch (idx) {
//            case 0: {
//                [self orderAction];
//            }
//            case 1:  break;
//            case 2:  break;
//            default: break;
//        }
//        switch (sortIdx) {
//            case 1:  break;
//            case 2:  break;
//            default: break;
//        }
//        [self setNeedData];
//    };
    self.header = header;
    self.table.y = header.maxY, self.table.height = self.listH-header.maxY;
    
    [JCLSocketObj share].socketActionBlock = ^(NSDictionary *dic, NSInteger idx) {
        if ([dic[@"status"] isEqualToNumber:@(0)]) {
            
        } else {
            [JCLFramework JCLProgressHUD:dic[@"describe"]];
        }
    };
    
    self.page = 30;
}

-(void)orderAction{
    self.popBg = [JCLKitObj JCLView:[AppDelegate shareAppDelegate].window color:JCLRGBA(0, 0, 0, 0.4)];
    self.popBg.frame = CGRectMake(0, 0, JCLWIDTH, JCLHEIGHT);
    [JCLKitObj RXTap:self.popBg target:self action:@selector(dissAction) number:1];
    
    JCLTablePop *pop = [[JCLTablePop alloc]init]; [[AppDelegate shareAppDelegate].window addSubview:pop];
    NSArray *val = @[@"全部", @"待成交", @"已成交", @"已撤单"];
    CGFloat h = val.count*[JCLKitObj JCLHeight:44];
    pop.frame = CGRectMake(0, 0.5*(JCLHEIGHT-h), JCLWIDTH, h);
    pop.date = self.header.obj.text; pop.arr = val;
    pop.actionBlock = ^(NSInteger idx){
        [self dissAction]; self.header.obj.text = val[idx];
    };
    self.pop = pop;
}
-(void)dissAction{ [self.popBg removeFromSuperview]; [self.pop removeFromSuperview]; }

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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (NSArray*)tableView:(UITableView*)tableView editActionsForRowAtIndexPath:(NSIndexPath*)indexPath{
    NSArray *rows = nil;
    UITableViewRowAction *row = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"撤单" handler:^(UITableViewRowAction*_Nonnullaction,NSIndexPath*_NonnullindexPath) {
        //        NSDictionary *dic = @{
        //                              @"client_id" : self.users[@"username"], // 用户代码
        //                              @"entrust_no" : @([obj[@"position_id"] integerValue]), // 委托序号
        //                              @"stock_code" : @([obj[@"stock_code"] integerValue]), // 代码
        //                              @"exchange_type" : @([obj[@"exchange_type"] integerValue]), // 市场
        //                              };
        //        [[JCLSocketObj share] JCLSocketRequst:dic idx:JCL_PROTOCOL_WTCD];
    }];
    row.backgroundColor = [UIColor clearColor];
    rows = @[row];
    return rows;
}
@end
