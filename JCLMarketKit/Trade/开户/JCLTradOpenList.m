//
//  JCLTradOpen.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/29.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradOpenList.h"
#import "JCLTradOpenHeader.h"
#import "JCLTradOpenCell.h"
#import "JCLUserSubmit.h"
#import "JCLWapList.h"
#import "JCLTradOpenPop.h"
#import "JCLTradSignList.h"
#import "NewsCell.h"
#import "JCLWapList.h"
@interface JCLTradOpenList ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) JCLTradOpenHeader *header;
@property (nonatomic, weak) JCLUserSubmit *footer;
@property (nonatomic, weak) UIView *popBg;
@property (nonatomic, weak) JCLTradOpenPop *pop;
@property (nonatomic, strong) NSArray *data;
@end

@implementation JCLTradOpenList

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navi.left.img = @"";
    NSString *trade = PreRead(isTrade);
    
//    if ([trade isEqualToString:@"44"]) {
        self.navi.middle.title = @"开户";
        [self.vals addObjectsFromArray:@[@[@"值得信赖", @"值得信赖", @"大品牌，安全稳定，值得信赖"],
                                         @[@"急速交易", @"极速交易", @"跨境专线直连交易所，毫秒级成交速度"],
                                         @[@"智能交易", @"智能交易", @"只能询价算法保证成交价格最优"]
                                         ]];
        JCLUserSubmit *footer = [[JCLUserSubmit alloc]init];
        footer.submit.title = @"立即开户";
        footer.isMore = NO;
        footer.more.title = @"继续开户";
        footer.height = 0.16*JCLHEIGHT;
        self.table.tableFooterView = footer;
        self.footer = footer;
        [self.footer.submit tapActionBlock:^{
            if (name().length == 0){ JCLLOGIN; return; };
            JCLWapList *list = [[JCLWapList alloc]init];
            list.name = @"立即开户";
 
//            list.url = [NSString stringWithFormat:@"https://www.silverwin.cn/h5/account/signup?channel=TSJR"];
            list.url = [NSString stringWithFormat:@"https://itiger.com/accounts?invite=ZHANGJIAN"];
            
            [self.navigationController pushViewController:list animated:YES];
        }];
//        [self.footer.more tapActionBlock:^{
//            JCLWapList *list = [[JCLWapList alloc]init];
//            list.name = @"继续开户";
//            list.url = [NSString stringWithFormat:@"https://www.ibkr.com.cn/sso/Login?c=t"];
//            [self.navigationController pushViewController:list animated:YES];
//        }];
//    } else {
//
//        self.navi.middle.title = @"资讯";
//        self.data = [NSMutableArray array];
//        [JCLHttps getJson:@"http://web.yuesheng.jclkj.cn:8188/yssys/servlet/PageInfoServlet?categoryId=5&pageNo=1&count=30" success:^(id obj) {
//
//            self.data = obj[@"list"];
//            NSLog(@"--%@",self.data);
//            [self.table reloadData];
//        }];
//
//    }
    
//    JCLTradOpenHeader *header = [[JCLTradOpenHeader alloc]init];
//    header.height = 0.15*JCLHEIGHT;
//    self.table.tableHeaderView = header; self.header = header;
  
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
     NSString *trade = PreRead(isTrade);
    
    if ([trade isEqualToString:@"44"]) {
        
        return self.vals.count;
        
    } else {
        
        return self.data.count;
    }
    
    
    return 0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *trade = PreRead(isTrade);
    
    if ([trade isEqualToString:@"44"]) {
        
        return 0.14*JCLHEIGHT;
        
    } else {
        
        return 120*JCLWIDTH/375;
    }
    
    
    
    return 0;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     NSString *trade = PreRead(isTrade);
    
    if ([trade isEqualToString:@"44"]) {
        
        static NSString *ID = @"cell";
        JCLTradOpenCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[JCLTradOpenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.icon.img = self.vals[indexPath.row][0];
        cell.text.text = self.vals[indexPath.row][1];
        cell.subText.text = self.vals[indexPath.row][2];
        return cell;
        
        
    } else {
        
        
        NewsCell *cell = [NewsCell CellWithTableView:tableView];
        
        NSDictionary *dic = self.data[indexPath.row];
        
        cell.titleLab.attributedText = [JCLBaseManage  RXAttStr:dic[@"title"] spac:5];
        cell.timeLab.text = dic[@"createTime"];
        [cell.pic sd_setImageWithURL:[NSURL URLWithString:dic[@"imageAddress"]]];
        cell.backgroundColor = JCL_Bg_COL;
        return cell;
        
    }
    
    return nil;
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *trade = PreRead(isTrade);
    
    if (![trade isEqualToString:@"44"]) {
        
        NSDictionary *dic = self.data[indexPath.row];
        
        JCLWapList *webVC=[[JCLWapList alloc]init];
        webVC.name=@"详情";
        webVC.url=[NSString stringWithFormat:@"%@",dic[@"htmlAddress"]];
        [self.navigationController pushViewController:webVC animated:YES];
        
    }
    
    
}
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:YES];
//    NSString *url = [NSString stringWithFormat:@"%@getSchedule?phone=%@", JCLOpenURL, [JCLUserData getUserInfo].username];
//    [JCLHttpsObj JCLGetJson:url success:^(id obj) {
//        if ([obj[@"code"] isEqualToString:@"0"]) {
//            self.header.type = [NSString stringWithFormat:@"%@", obj[@"stauts"]];
//            if ([obj[@"stauts"] isEqualToString:@"0"]) {
//                self.footer.submit.title = @"立即开户";
//                [self.footer.submit tapActionBlock:^{
//                    if (![JCLUserData getUserInfo].username){ JCLLOGIN; return; };
//                    JCLWapList *list = [[JCLWapList alloc]init];
//                    list.name = @"立即开户";
//                    list.url = [NSString stringWithFormat:@"https://www.ibkr.com.cn/Universal/servlet/Application.ApplicationSelector?locale=zh_CN"];
//
////                    list.url = [NSString stringWithFormat:@"%@?phone=%@",JCLOpen1URL, [JCLUserData getUserInfo].username];
//                    [self.navigationController pushViewController:list animated:YES];
//                }];
//            }
//
//            if ([obj[@"stauts"] isEqualToString:@"1"]) {
//                self.footer.submit.title = @"签署文件";
//                [self.footer.submit tapActionBlock:^{
//                    JCLTradSignList *list = [[JCLTradSignList alloc]init];
//                    [self.navigationController pushViewController:list animated:YES];
//                }];
//            }
//
//            if ([obj[@"stauts"] isEqualToString:@"2"]) {
//                self.footer.submit.backgroundColor = JCLHexCol(@"#69696C");
//                self.footer.submit.title = @"审核中";
//            } else {
//                self.footer.submit.backgroundColor = JCLHexCol(@"#BE9E62");
//            }
//
//            if ([obj[@"stauts"] isEqualToString:@"3"]) {
//                self.footer.submit.title = @"登录交易";
//                [self.footer.submit tapActionBlock:^{
//                    self.popBg = [JCLKitObj JCLView:[AppDelegate shareAppDelegate].window color:JCLRGBA(0, 0, 0, 0.4)];
//                    self.popBg.frame = self.view.bounds;
//                    [self.popBg tapActionBlock:^{
//                        [self.popBg removeFromSuperview]; [self.pop removeFromSuperview];
//                    }];
//                    JCLTradOpenPop *pop = [[JCLTradOpenPop alloc]init]; [[AppDelegate shareAppDelegate].window addSubview:pop];
//                    CGFloat x = 0.14*JCLWIDTH, h = 0.32*JCLHEIGHT;
//                    pop.frame = CGRectMake(x, 0.5*(JCLHEIGHT-h), JCLWIDTH-2*x, h);
//                    [pop.diss tapActionBlock:^{
//                        [self.popBg removeFromSuperview]; [self.pop removeFromSuperview];
//                    }];
//                    self.pop = pop;
//                }];
//            }
//        } else {
//            self.header.type = [NSString stringWithFormat:@"0"];
//            self.footer.submit.title = @"立即开户";
//            [self.footer.submit tapActionBlock:^{
//                if (![JCLUserData getUserInfo].username){ JCLLOGIN; return; };
//            }];
//        }
//    } failure:^(NSError *error) { }];
//}
@end
