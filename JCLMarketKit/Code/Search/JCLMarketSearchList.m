//
//  QuotationSearch.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2016/11/20.
//  Copyright © 2016年 ruixue. All rights reserved.
//

#import "JCLMarketSearchList.h"
#import "JCLMarketSearchCell.h"
#import "JCLSearchBar.h"

#import "JCLMarketKeyboard.h"
#import "JCLMarketObj.h"
#import "JCLStockMain.h"

#import "JCLMarketSearchHeader.h"
#import "JCLMarketSearchFooter.h"
#import "TSJRRealTimeMarket.h"
#import "TSJRStokeCoderModel.h"

@interface JCLMarketSearchList ()<UITextFieldDelegate>
@property (nonatomic, weak) JCLMarketSearchHeader *header;
@property (nonatomic, weak) JCLMarketSearchFooter *footer;
@property (nonatomic, strong) NSMutableArray *historys;
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, weak) JCLSearchBar *search;
@property (nonatomic, weak) JCLMarketKeyboard *keyboard;
@end

@implementation JCLMarketSearchList
- (void)viewDidLoad {
    [super viewDidLoad];
    self.historical = YES;
    self.navi.right.title = @"取消";
    __weak typeof(self) weakSelf = self;
    self.rightActionBlock = ^(){
        [weakSelf.navigationController popViewControllerAnimated:YES];
     };
    JCLSearchBar *search = [[JCLSearchBar alloc] initWithFrame:CGRectMake(14, New_Device?38:27, JCLWIDTH - 74, 30)];
    search.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.navi addSubview:search];
    self.search = search;
    
    search.placeholder = @"请输入股票代码或简拼";
    //[search becomeFirstResponder];
    search.font = [UIFont systemFontOfSize:14];
    [search addTarget:self action:@selector(changedAction:) forControlEvents:(UIControlEventEditingChanged)];
    [search addTarget:self action:@selector(beginAction:) forControlEvents:(UIControlEventEditingDidBegin)];
    self.table.contentInset  = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self InitHeadHead:YES];
 
    //    JCLMarketSearchHeader *header = [[JCLMarketSearchHeader alloc]init];
//    header.height = 0;
//    header.height = [JCLKitObj JCLHeight:44];
//    header.text.text = @"搜索历史";
//    self.table.tableHeaderView = header;
    
//    self.historys = [[NSMutableArray alloc]init];
//    NSArray *infos = FileRead(CachesFile(CodeHis));
//    NSLog(@"--infosinfos--- %@",infos)
//    [self.historys addObjectsFromArray:infos];
//    [self.arrM addObjectsFromArray:infos];
//
//    if (self.historys.count) {
//        [self InitHeadHead:YES];
//        [self InitHeadFoot:YES];
//    }
    self.page = 0;
    
//    if (!self.historical) {
        self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.page = 0;
            [self  changedAction:search];
        }];
        self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            if (self.arrM.count >=self.arrM.count*self.page) {
                self.page++;
                [self  changedAction:search];
            }else{
                [self.table.mj_footer endRefreshingWithNoMoreData];
            }
        }];
//    }
    
}

-(void)InitHeadHead:(BOOL)isHave{
    JCLMarketSearchHeader *header = [[JCLMarketSearchHeader alloc]init];
    
   
    if (isHave && self.arrM.count) {
         header.height = [JCLKitObj JCLHeight:44];
        header.text.text = @"搜索历史";
        self.table.tableHeaderView = header;
    }
}

///清除历史纪录
-(void)InitHeadFoot:(BOOL)isHave{
    JCLMarketSearchFooter *footer = [[JCLMarketSearchFooter alloc]init];
    footer.height = 0;
    
    [footer tapActionBlock:^{
//        [self.arrM removeAllObjects];
//        FileWrite(CachesFile(CodeHis), self.arrM);
 
//        删除我的历史股票
        NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlA,@"delAllHistorylStock"];
        [JCLHttps httpPOSTRequest:postUrl params:@{@"userId":userId()} success:^(id obj) {
            NSLog(@"objobj %@",obj);
            MMResultV2Model *model =(MMResultV2Model *)obj;
            if (model.code.intValue == 200) {
                
                [self.arrM removeAllObjects];
                [self InitHeadHead:YES];
                [self InitHeadFoot:NO];
                [self.table reloadData];
            }
            
        } failure:^(NSError *error) {
//            [JCLFramework showErrorHud:@"服务器异常"];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
//        [self.table reloadData];
    }];
    self.table.tableFooterView= footer;
    
    if (isHave && self.arrM.count) {
        footer.height = [JCLKitObj JCLHeight:44];
        footer.text.text = @"清除历史记录";
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self loadJson];
    [self.table reloadData];
}

-(void)loadJson{
    [self.table.mj_header endRefreshing];
    [self.table.mj_footer endRefreshing];
//    我的历史股票列表
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlA,@"listHistoryStock"];
    [JCLHttps httpPOSTRequest:postUrl params:@{@"userId":userId()} success:^(id obj) {
        NSLog(@"objobj %@",obj);
        MMResultV2Model *model =(MMResultV2Model *)obj;
        if (model.code.intValue == 200) {
            [self.arrM removeAllObjects];
            for (id objcm in model.data) {
                
                 NSLog(@"model.data %@",model.data);
                TSJRStokeCoderModel *codeM = [TSJRStokeCoderModel modelWithDictionary:objcm];
                [self.arrM addObject:codeM];
                [self InitHeadHead:YES];
                [self InitHeadFoot:YES];
                [self.table reloadData];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
        }
         [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
  
        [JCLFramework showErrorHud:@"服务器异常"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
//    NSString *url = [NSString stringWithFormat:@"%@getOptionalStock.do?userid=%@", JCLSelfURL, [JCLUserData getUserInfo].username];
//    [JCLHttpsObj JCLGetJson:url success:^(id obj) {
//        self.arr = obj[@"list"];
//    } failure:^(NSError *error) { }];
}

-(void)beginAction:(UITextField *)textFie{
    if (self.keyboard == nil) {
        CGFloat h = 0.54*JCLWIDTH;
        JCLMarketKeyboard *keyboard = [[JCLMarketKeyboard alloc]initWithFrame:CGRectMake(0, JCLHEIGHT - h, JCLWIDTH, h)];
//        self.search.inputView = keyboard;
        __weak typeof(keyboard)weak = keyboard;
        keyboard.submitActionBlock = ^(UIButton *button){
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC));
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                if (weak.azBg.hidden) {
                    switch (button.tag) {
                        case 4: [self.search deleteBackward]; break;
                        case 5: textFie.text = @""; break;
                        case 3: weak.numBg.hidden = YES; weak.azBg.hidden = NO; ; break;
                            //case 15: self.keyboard.hidden = YES; textFie.inputView = nil; [textFie endEditing:YES]; [textFie becomeFirstResponder]; break;
                        case 6: [self.keyboard removeFromSuperview]; [textFie resignFirstResponder]; break;
                        case 7: [self.keyboard removeFromSuperview]; [textFie resignFirstResponder]; break;
                        default: [self.search insertText:button.title]; break;
                    }
                } else {
                    switch (button.tag) {
                        case 27: [self.search deleteBackward]; break;
                        case 19: textFie.text=@""; break;
                        case 28: weak.numBg.hidden = NO; weak.azBg.hidden = YES; break;
                        case 29: [self.search insertText:@" "]; break;
                        case 30: [self.keyboard removeFromSuperview]; [textFie resignFirstResponder]; break;
                        default: [self.search insertText:button.title.lowercaseString]; break;
                    }
                }
            });
        };
        self.keyboard = keyboard;
    }
}

//查询结果
-(void)changedAction:(UITextField *)text{
    if (text.text.length  == 0) {
        self.historical =YES;
        [self loadJson];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    if (self.arrM.count) {
//        [self.arrM removeAllObjects];
//    }
    self.historical =NO;
    NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlA,@"searchStocks"];
    [JCLHttps httpPOSTRequest:postUrl params:@{@"key": text.text.uppercaseString,@"userId":userId(),@"page":@(self.page)} success:^(id obj) {
        NSLog(@"objobj %@",obj);
        MMResultV2Model *model =(MMResultV2Model *)obj;
         NSLog(@"objcmobjcm %@",model.data);
        if (model.code.intValue == 200) {
            if (self.page == 0) {
                [self.arrM removeAllObjects];
            }
            for (id objcm in model.data) {
                TSJRStokeCoderModel *codeM = [TSJRStokeCoderModel modelWithDictionary:objcm];
                [self.arrM addObject:codeM];
             }
           
            if (!self.arrM.count) {
                [self InitHeadHead:YES];
                [self InitHeadFoot:YES];
            } else {
                [self InitHeadHead:NO];
                [self InitHeadFoot:NO];
            
            }
            [self.table.mj_header endRefreshing];
            [self.table.mj_footer endRefreshing];
         [MBProgressHUD hideHUDForView:self.view animated:YES];
           [self.table reloadData];
        }
         [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
//        [JCLFramework showErrorHud:@"服务器异常"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.table.mj_header endRefreshing];
        [self.table.mj_footer endRefreshing];
    }];
    
//    NSArray *szArr = FileRead(CachesFile(NYSE));
//    NSLog(@"szArr----- %@",szArr);
//
//    [self searchInfo:szArr val:text.text];
//    NSArray *shArr = FileRead(CachesFile(NASDAQ));
//     NSLog(@"shArr----- %@",shArr);
//    [self searchInfo:shArr val:text.text];
//    NSArray *tfbArr = FileRead(CachesFile(American));
//    NSLog(@"tfbArr----- %@",tfbArr);
//    [self searchInfo:tfbArr val:text.text];
//    if (!self.arrM.count) {
//        [self.arrM addObjectsFromArray:self.historys];
//        [self InitHeadHead:YES];
//        [self InitHeadFoot:YES];
//    } else {
//        [self InitHeadHead:NO];
//        [self InitHeadFoot:NO];
//    }
//    if (self.arrM.count==0) {
//        if (text.text.length>0) {
//
//            [NSObject cancelPreviousPerformRequestsWithTarget:self];
//            [self performSelector:@selector(showNoneMessage) withObject:nil afterDelay:1];
//        }
//    }
 
}
-(void)showNoneMessage{
    [JCLFramework showErrorHud:@"未搜索到数据!"];
 }
-(void)searchInfo:(NSArray *)arr val:(NSString *)val{
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", val];
    [arr enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL *stop) {
        NSArray *group = [NSArray arrayWithArray:[obj filteredArrayUsingPredicate:preicate]];
        if (group.count) { [self.arrM addObject:obj]; }
    }];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
     
    return [UIView new];
};
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [UIView new];;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.arrM.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JCLMarketSearchCell *cell = [JCLMarketSearchCell cellWithTable:tableView style:UITableViewCellStyleDefault];
//    id obj = self.arrM[indexPath.row];
    
    NSLog(@"-------- %lu------%@",(unsigned long)self.arrM.count,self.arrM[indexPath.row]);
    
    
    TSJRStokeCoderModel *codeM = self.arrM[indexPath.row];
    cell.title.text = codeM.stock.cn_name; //[NSString stringWithFormat:@"%@",[[AppDelegate shareAppDelegate].messageNoticeStore fetchMessage:codeM.symbol]];
    cell.code.text = codeM.stock.symbol;
    if (codeM.isexist.intValue == 1) {
         cell.option.selected = YES;
         }else{
           cell.option.selected = NO;
      }
    
////    查询是否已收藏我的股票
    if (self.historical) {
        NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlA,@"isExistOptionalStock"];
        [JCLHttps httpPOSTRequest:postUrl params:@{@"userId":userId(),@"symbol":codeM.stock.symbol} success:^(id obj) {
            NSLog(@"objobj %@",obj);
            
            MMResultV2Model *model =(MMResultV2Model *)obj;
            if (model.code.intValue == 200) {
                cell.option.selected = YES;
            }else{
                cell.option.selected = NO;
            }
            
        } failure:^(NSError *error) {
            //            [JCLFramework showErrorHud:@"服务器异常"];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }
     
    __weak typeof(cell)weakCell = cell;
    cell.addActionBlock = ^(UIButton *sender){
        if (user().uName.length == 0){ JCLLOGIN; return; };
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //添加自选
        NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlA,@"addOrDelOptionalStock"];
        [JCLHttps httpPOSTRequest:postUrl params:@{@"userId":userId(),@"symbol":codeM.stock.symbol} success:^(id obj) {
            NSLog(@"objobj %@",obj);
            
            MMResultV2Model *model =(MMResultV2Model *)obj;
            if (model.code.intValue == 200) {
                [JCLKitObj showMsg:model.message];
                if ([model.message containsString:@"添加成功"]) {
                     codeM.isexist = @"1";
                }else{
                     codeM.isexist = @"0";
                }
               
                [self.table reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
        } failure:^(NSError *error) {
            [JCLFramework showErrorHud:@"服务器异常"];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
       [self addHistorylStock:codeM.stock.symbol];
  
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     id obj = self.arrM[indexPath.row];
     if (self.isPop) {
        !self.popActionBlock ? : self.popActionBlock(obj);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
     else{
         TSJRStokeCoderModel *codeM = self.arrM[indexPath.row];
         [self addHistorylStock:codeM.stock.symbol];
//        __block BOOL isHave = NO;
//        [self.historys enumerateObjectsUsingBlock:^(id  _Nonnull object, NSUInteger idx, BOOL * _Nonnull stop) {
//            if ([obj[3] isEqualToString:object[3]]) { isHave = YES; }
//        }];
//        if (!isHave) {
//            [self.historys addObject:obj]; FileWrite(CachesFile(CodeHis), self.historys);
//        }
         TSJRRealTimeMarket *mArray = [[TSJRRealTimeMarket alloc]init];
         mArray.symbol = codeM.stock.symbol;
         mArray.cn_name = codeM.stock.cn_name;
         JCLStockMain *vc = [[JCLStockMain alloc]init];
         vc.arr = mArray;
         [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}


-(void)addHistorylStock:(NSString *)code{
    // 添加我的历史股票、
    NSString *postUrlA = [NSString stringWithFormat:@"%@/%@",baseApiURlA,@"addHistoryStock"];
    
    [JCLHttps httpPOSTRequest:postUrlA params:@{@"userId":userId(),@"symbol":code} success:^(id obj) {
        NSLog(@"objobj %@",obj);
        
        MMResultV2Model *model =(MMResultV2Model *)obj;
        if (model.code.intValue == 200) {
//            [JCLKitObj showMsg:model.message];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        
    } failure:^(NSError *error) {
//        [JCLFramework showErrorHud:@"服务器异常"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
    
}
@end
