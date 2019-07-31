//
//  JCLMarketSelfEdit.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/22.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLMarketSelfEdit.h"
#import "JCLMarketOptionHeader.h"
#import "JCLMarketEditOptionCell.h"
#import "JCLMarketOption.h"
#import "JCLStockMain.h"

@interface JCLMarketSelfEdit ()
@property (nonatomic, strong) NSMutableArray *editArrM;
@property (nonatomic, strong) JCLMarketOption *option;
@end

@implementation JCLMarketSelfEdit
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navi.middle.title = @"自选股"; self.navi.right.img = @"刷新";
    
    JCLMarketOptionHeader *header = [[JCLMarketOptionHeader alloc]init];
    header.frame = CGRectMake(0, 64, JCLWIDTH, [JCLKitObj JCLHeight:40]); [self.view addSubview:header];
    header.arr = @[@"名称代码", @""];
    [self InitOption];
    [self loadData];
    self.table.y = header.maxY; self.table.height = self.option.y-header.maxY;
}

-(void)loadData{
        NSString *url = [NSString stringWithFormat:@"%@getOptionalStock.do?userid=%@", JCLSelfURL, [JCLUserData getUserInfo].username];
        [JCLHttpsObj JCLGetJson:url success:^(id obj) {
            NSArray *arr = obj[@"list"];
            
            __block NSString *merge;
            [arr enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL * _Nonnull stop) {
                if(object){
                    if ([object[@"zdycode"] isEqualToString:@"AAѡAA"] && [object[@"zdyname"] isEqualToString:@"AAѡAA"]) {
                        NSString *code = [NSString stringWithFormat:@"%@", object[@"stockcode"]];
                        merge = merge.length ? [NSString stringWithFormat:@"%@*%@", merge, code] : code;
                    }
                }
            }];
            
            NSString *url1 = [NSString stringWithFormat:@"%@/FreeSortWebServer/selfsorthq?coltype=%ld&sortid=%@&sorttype=%ld&symbol=%@&synid=10012",
                              JCLMarketURL,
                              (long)0,
                              @"1*0*6*3*2*4*5*9*10*36*146*145*205",
                              (long)1,
                              merge];
            [JCLHttpsObj JCLGetStr:url1 success:^(NSArray *obj) {
                [self.arrM removeAllObjects];
                [self.arrM addObjectsFromArray:[JCLHttpsObj JCLHandleStr:obj begin:1 end:obj.count - 2]];
                [self.table reloadData]; [self.table.mj_header endRefreshing];
            } failure:^(NSError *error) {
                [self.table.mj_header endRefreshing];
            }];
        } failure:^(NSError *error) { }];
}

-(NSMutableArray *)editArrM{ if (_editArrM) return _editArrM; return _editArrM = [[NSMutableArray alloc]init]; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return self.arrM.count; }
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ return [JCLKitObj JCLHeight:60]; }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = self.arrM[indexPath.row];
    JCLMarketEditOptionCell *cell = [JCLMarketEditOptionCell cellWithTable:tableView style:UITableViewCellStyleDefault];
    if(arr.count){
        cell.name.text = [NSString stringWithFormat:@"%@", arr[0]];
        cell.code.text = [NSString stringWithFormat:@"%@", arr[1]];
    }
    cell.selectActionBlock = ^(UIButton *sender){
        __block BOOL isInsert = YES;
        [self.editArrM enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(obj.count && arr.count){
                if ([obj[0] isEqualToString:arr[0]]) {
                    [self.editArrM removeObject:arr]; isInsert = NO;
                }
            }
        }];
        if (isInsert) {
            [self.editArrM addObject:arr];
        }
        
        if (self.editArrM.count == self.arrM.count) {
            self.option.select.selected = NO;
            self.option.select.img = @"xuan";
        } else {
            self.option.select.selected = YES;
            self.option.select.img = @"buxuan";
        }
        
        [self.table reloadData];
    };
    
    cell.stickActionBlock = ^(){
        [self.arrM enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(obj.count &&  arr.count){
                if ([obj[0] isEqualToString:arr[0]]) {
                    [self.arrM removeObject:arr];
                }}
        }];
        if(arr){
            [self.arrM insertObject:arr atIndex:0];
        }
        
        [self.table reloadData];
    };
    
    cell.select.img = @"buxuan";
    [self.editArrM enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj.count &&  arr.count){
            if ([obj[0] isEqualToString:arr[0]]) {
                cell.select.img = @"xuan";
            }}
    }];
    return cell;
    
}

-(void)InitOption{
    JCLMarketOption *option = [[JCLMarketOption alloc]init]; [self.view addSubview:option];
    CGFloat h = [JCLKitObj JCLHeight:50];
    option.frame = CGRectMake(0, JCLHEIGHT-h, JCLWIDTH, h);
    option.selectActionBlock = ^(UIButton *sender){
        if (sender.isSelected) {
            sender.img = @"buxuan";
            [self.editArrM removeAllObjects];
        } else {
            sender.img = @"xuan";
            [self.editArrM removeAllObjects];
            [self.editArrM addObjectsFromArray:self.arrM];
        }
        [self.table reloadData];
    };
    option.deleteActionBlock = ^(){ [self delete]; };
    self.option = option;
}

-(void)delete{
    if (self.editArrM.count) {
        NSMutableArray *listArr=[NSMutableArray arrayWithCapacity:0];
        [self.editArrM enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL *stop) {
            if(obj.count){
                NSMutableDictionary *dict=[NSMutableDictionary dictionary];
                dict[@"setcode"]=[JCLMarketObj JCLMarketStyle:[obj[1] substringToIndex:2]],
                dict[@"stockcode"]=[obj[1] substringFromIndex:2],
                dict[@"type"]=@"1";
                dict[@"zdycode"]= @"zxg";
                dict[@"zdyname"]= @"zxg";
                [listArr addObject:dict];
            }}];
        
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        dict[@"userid"]=[JCLUserData getUserInfo].username;
        dict[@"list"]=listArr;
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        NSDictionary *params=@{@"manystocks":[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
        [JCLHttps postJson:[NSString stringWithFormat:@"%@statistic/delManyStock.do?",JCLSelfURL] parame:params success:^(id obj) {
            if([obj[@"code"] isEqualToString:@"1"]){
                [self.editArrM removeAllObjects];
                [self loadData];
            }else{
                [JCLSVProgressHUD showErrorHud:@"删除失败!"];
            }
        }];
    } else {
        [JCLFramework JCLProgressHUD:@"请您选择删除项"];
    }
}
-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath { return @"删除"; }
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [JCLFramework JCLProgressHUD:@"删除中.."];
    if (editingStyle == UITableViewCellEditingStyleDelete) { //删除事件
        id obj = self.arrM[indexPath.row];
        if(obj){
            NSString *url = [NSString stringWithFormat:@"%@delOptionalStock.do?userid=%@&stockcode=%@&setcode=%@&zdycode=%@&zdyname=%@",
                             JCLSelfURL,
                             [JCLUserData getUserInfo].username,
                             [obj[1] substringFromIndex:2],
                             [JCLMarketObj JCLMarketStyle:[obj[1] substringToIndex:2]],
                             @"zxg", @"zxg"];
            [JCLHttpsObj JCLGetJson:url success:^(id obj) {
                if([obj[@"code"] isEqualToString:@"1"]){
                     [JCLSVProgressHUD showSuccessHUD:@"删除成功!"];
                    [self.arrM removeObjectAtIndex:indexPath.row];
                    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                }else{
                    [JCLSVProgressHUD showErrorHud:@"删除失败!"];
                }
            } failure:^(NSError *error) {
                [JCLSVProgressHUD showErrorHud:@"网络超时!"];
            }];
        }
    }
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    id obj = self.arrM[indexPath.row];
//    JCLStockMain *list = [[JCLStockMain alloc]init];
//    list.arr = obj;
//    [self.navigationController pushViewController:list animated:YES];
//}
@end
