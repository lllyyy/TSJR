//
//  JCLStockMsgDetail.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/5/11.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockMsgDetail.h"
#import "JCLStockMsgModel.h"
#import "JCLStockNoticeCell.h"
#import "JCLStockReportCell.h"
#import "JCLDateObj.h"
#import "JCLStockAboutDetailsList.h"

@interface JCLStockMsgDetail()
@property (nonatomic,strong) NSMutableArray *msgArr;
@end

@implementation JCLStockMsgDetail

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navi.middle.title=self.navigationItem.title;
 
    self.table.showsVerticalScrollIndicator=YES;
    
    if(self.type==0){
        [self loadMsgData:@"singleGonggao.jsp"];
    }else{
        [self loadMsgData:@"singleResearch.jsp"];
    }
}

#pragma mark代理和数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _msgArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.type==0){
          return [JCLKitObj JCLHeight:70];
    }
    return [JCLKitObj JCLHeight:50];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.type==0){
    JCLStockNoticeCell *cell = [JCLStockNoticeCell cellWithTable:tableView style:UITableViewCellStyleDefault];
    JCLStockMsgModel *model = self.msgArr[indexPath.row];
    if (indexPath.row == 0) {
        cell.isHave = YES;
    } else {
        cell.isHave = NO;
    }
    NSString *timeStr=[self getDate:model.ggtime];
    cell.time.text = timeStr;
    cell.text.text = model.title;
    return cell;
    }else{
    JCLStockReportCell *cell = [JCLStockReportCell cellWithTable:tableView style:UITableViewCellStyleDefault];
    JCLStockMsgModel *model = self.msgArr[indexPath.row];
    cell.title.text = model.jgjc;
    cell.time.text = [JCLDateObj JCLDate:model.reporttime];
    return cell;
    }
}

-(NSString *)getDate:(NSString *)date{
    NSString *val = [[date substringToIndex:6] substringFromIndex:4];
    return [NSString stringWithFormat:@"%@-%@-%@", [date substringToIndex:4], val, [date substringFromIndex:6]];
}

-(void)loadMsgData:(NSString *)type{
        NSString *url = [NSString stringWithFormat:@"%@/announcement/%@?stockcode=%@", yburl, type, self.code];
        [JCLHttpsObj JCLGetJson:url success:^(id obj) {
            NSArray *arr = obj;
            if (arr.count) {
                self.msgArr = [JCLStockMsgModel mj_objectArrayWithKeyValuesArray:obj];
                [self.table reloadData];
            } else {
            }
        } failure:^(NSError *error) { }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JCLStockMsgModel *model = self.msgArr[indexPath.row];
    if(self.type==0){
    JCLStockAboutDetailsList *list = [[JCLStockAboutDetailsList alloc]init];
    list.name = @"详情";
    list.url = [NSString stringWithFormat:@"%@/wwwapp/%@/%@.html", yb1url, [model.ggtime substringToIndex:8], model.noticeId];
    [self.navigationController pushViewController:list animated:YES];
    }else{
    JCLStockAboutDetailsList *list = [[JCLStockAboutDetailsList alloc]init];
    list.name = model.jgjc;
    list.url = [NSString stringWithFormat:@"%@/wwwapp/yanbao/%@/%@.html", yb1url, [model.reporttime substringToIndex:8], model.noticeId];
    [self.navigationController pushViewController:list animated:YES];
    }
}

@end
