//
//  TSJRNewVC.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/20.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "TSJRNewVC.h"
#import "NewsCell.h"
#import "JCLWapList.h"
#import "TSJRNewModel.h"
#import "TSJRNewDetailVC.h"
#import "BAWebpController.h"

@interface TSJRNewVC ()
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger num;
@end

@implementation TSJRNewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navi.left.img = @"";
    self.navi.middle.title = @"资讯";
 
    [self loadData];
    
    self.page = 0;
    self.num = 10;
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 0;
        [self loadData];
     }];
  
    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (self.arrM.count >=self.num*self.page) {
            self.page++;
            [self loadData];
        }else{
            [self.table.mj_footer endRefreshingWithNoMoreData];
        }
    }];
    [self.table registerClass:[NewsCell class] forCellReuseIdentifier:@"NewsCell"];
}




-(void)loadData{
    //    新闻列表
    NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlE,@"newsList"];
    [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    [JCLHttps httpPOSTRequest:postUrl params:@{@"page":@(self.page)} success:^(id obj) {
        NSLog(@"objobj %@",obj);
        MMResultModel *model =(MMResultModel *)obj;
        
        if (model.code.intValue == 200&&model.data.count > 0) {
            if (self.page == 0) {
                [self.arrM removeAllObjects];
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            for (id object in model.data) {
                TSJRNewModel *newM = [TSJRNewModel modelWithDictionary:object];
//                if (![newM.type isEqualToString:@"14"]) {
                    [self.arrM addObject:newM];
                    [self.table reloadData];
//                }
             }
         }
        [self.table.mj_header endRefreshing];
        [self.table.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [JCLFramework showErrorHud:@"服务器异常"];
        [self.table.mj_header endRefreshing];
        [self.table.mj_footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return self.arrM.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
    [cell setData:self.arrM[indexPath.row]];
 
   return cell;
 }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
       TSJRNewModel *m = self.arrM[indexPath.row];
 
    BAWebpController *vc = [[BAWebpController alloc]init];
    vc.did = m.docid;
    [self.navigationController pushViewController:vc animated:YES];
 
 
    
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
