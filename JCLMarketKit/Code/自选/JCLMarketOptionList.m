//
//  JCLOptionalList.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/24.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLMarketOptionList.h"
#import "JCLMarketOptionHeader.h"
#import "JCLMarketOptionCell.h"
#import "JCLMarketSearchList.h"
#import "JCLMarketOptionMsg.h"
#import "JCLStockMain.h"
#import "TSJRMarkOptionHeaderView.h"
#import "TSJRMarketOptionListModel.h"
#import "TSJRMarketOptionListCell.h"
@interface JCLMarketOptionList ()
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger sortId;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, assign) BOOL       sortBool;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) JCLMarketOptionHeader *header;
@property (nonatomic, weak)   JCLMarketOptionMsg *msg;
@end

@implementation JCLMarketOptionList
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navi.left.img = @"";
    self.navi.middle.title = @"自选";
    self.navi.right.img = @"搜索";
    [self.navi.right tapActionBlock:^{
       [self.navigationController pushViewController:[[JCLMarketSearchList alloc]init] animated:YES];
    }];

    self.table = [JCLKitObj JCLTable:self.view target:self frame:CGRectMake(0, JCLNAVI, JCLWIDTH, JCLSCROLL-44) style:UITableViewStylePlain];
    self.table.backgroundColor =JCL_Bg_COL;
    self.dataArray = [NSMutableArray new];
//    [self drawTableHeader];
//    self.table.y = self.header.maxY,
//    self.table.height = JCLHEIGHT - self.header.maxY - 49;
//    self.sortId = 14;
//    self.sort = 1;
    [self.table registerClass:[TSJRMarketOptionListCell class] forCellReuseIdentifier:@"TSJRMarketOptionListCell"];
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{ [self loadData]; }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
    AppDelegate.shareAppDelegate.timerAtionBlock = ^() { [self loadData]; };
}

//-(void)drawTableHeader{
//    JCLMarketOptionHeader *header = [[JCLMarketOptionHeader alloc]init];
//    header.frame = CGRectMake(0, JCLNAVI, JCLWIDTH, [JCLKitObj JCLHeight:44]);
//    [self.view addSubview:header];
//    //header.isAction = YES;
//    header.arr = @[@"名称", @"现价", @"涨跌幅"];
//    self.header = header;
//    header.menuActionBlock = ^(NSInteger idx, NSInteger sortIdx){
//        switch (idx){
//            case 0: self.sortId = 0; break;
//            case 1: self.sortId = 6; break;
//            case 2: self.sortId = 14; break;
//            default: break;
//        }
//        switch (sortIdx) {
//            case 0: self.sort = -2; break;
//            case 1: self.sort = 1; break;
//            case 2: self.sort = 2; break;
//            default: break;
//        }
//        [self loadData];
//    };
//}

-(void)loadData{
 
    NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlA,@"listOptionalStock"];
    
    [JCLHttps httpPOSTRequest:postUrl params:@{@"userId":userId()} success:^(id obj) {
       
       MMResultV2Model *model =(MMResultV2Model *)obj;
       if (model.code.intValue == 200) {
            [self.dataArray removeAllObjects];
           for (id objc in model.data) {
               TSJRMarketOptionListModel *marketModel = [TSJRMarketOptionListModel modelWithDictionary:objc];
               [self.dataArray  addObject:marketModel];
              
           }
            [self.table reloadData];
        }
        [self.table.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.table.mj_header endRefreshing];
//        [JCLFramework showErrorHud:@"服务器异常"];
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
   
 
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
    
}
 
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TSJRMarkOptionHeaderView *header = [[TSJRMarkOptionHeaderView alloc]init];
//    [header.titleC addTarget:self action:@selector(storPrice:)];
//    [header.titleE addTarget:self action:@selector(storPrice:)];
    return header;
    
};

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    TSJRMarketOptionListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TSJRMarketOptionListCell" forIndexPath:indexPath];
    [cell setDataModel:self.dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id obj = self.dataArray[indexPath.row];
    UITabBarController *tabBar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *navi = (UINavigationController *)tabBar.selectedViewController;
    JCLStockMain *list = [[JCLStockMain alloc]init];
    list.arr = obj;
    [navi pushViewController:list animated:YES];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) { //删除事件
//        NSArray *arr = self.vals[indexPath.row];
//        NSArray *codes = [JCLMarketObj JCLStockInfo:arr[1]];
//        NSString *url = [NSString stringWithFormat:@"%@/%@userid=%@&stockcode=%@&setcode=%@&zdycode=%@&zdyname=%@",
//                         JCLSelfURL, @"delOptionalStock.do?", [JCLUserData getUserInfo].username, codes[6], codes[0],
//                         @"zxg", @"zxg"];
//        [JCLHttpsObj JCLGetJson:url success:^(id obj) {
//            [JCLFramework showSuccess:@"取消自选成功"];
//            [self loadData];
//        } failure:^(NSError *error) {
//            [JCLFramework showErrorHud:@"网络延迟"];
//        }];
//    }
}
-(NSArray<UITableViewRowAction*>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
          TSJRMarketOptionListModel *model  =  self.dataArray[indexPath.row];
        [self deleteOption:model.symbol];
    }];

    rowAction.backgroundColor = [UIColor redColor];
    return @[rowAction];
}


-(void)deleteOption:(NSString *)symbol{
 
   [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlA,@"addOrDelOptionalStock"];
    
    [JCLHttps httpPOSTRequest:postUrl params:@{@"userId":userId(),@"symbol":symbol} success:^(id obj) {
        NSLog(@"objobj %@",obj);
        
        MMResultV2Model *model =(MMResultV2Model *)obj;
        if (model.code.intValue == 200) {
             [JCLKitObj showMsg:model.message];
             [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self loadData];
        }
       
    } failure:^(NSError *error) {
 
        [JCLFramework showErrorHud:@"服务器异常"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"default_search"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"暂无相关结果";
    UIColor *color = TitleCColor;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                 NSForegroundColorAttributeName:color};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}


#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return self.dataArray == nil;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView {
    return CGPointMake(0, -(self.table.contentInset.top - self.table.contentInset.bottom) / 2);
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -100;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 20;
}


-(void)storPrice:(UIButton *)sender{
 
    NSArray *sortedArray;
    if (self.sortBool) {
       sortedArray = [self.dataArray sortedArrayUsingComparator:^(TSJRMarketOptionListModel *number1, TSJRMarketOptionListModel *number2) {
           NSLog(@"降序降序降序降序");
            self.sortBool=NO;
            return NSOrderedDescending;//降序
           
        }];
    }else{
      sortedArray = [self.dataArray sortedArrayUsingComparator:^(TSJRMarketOptionListModel *number1, TSJRMarketOptionListModel *number2) {
            self.sortBool=YES;
            return NSOrderedAscending;//升序
        }];
    }
   self.dataArray = sortedArray.mutableCopy;
   [self.table reloadData];
 
//    if ([model1.UnitRegCount floatValue]/[model1.UnitAllocate floatValue] > [model2.UnitRegCount floatValue]/[model2.UnitAllocate floatValue]) {
//        return NSOrderedDescending;//降序
//    }else if ([model1.UnitRegCount floatValue]/[model1.UnitAllocate floatValue] > [model2.UnitRegCount floatValue]/[model2.UnitAllocate floatValue]){
//        return NSOrderedAscending;//升序
//    }else {
//        return NSOrderedSame;//相等
//    }
 
}

@end
