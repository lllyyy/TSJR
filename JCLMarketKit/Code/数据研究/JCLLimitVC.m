//
//  JCLLimitVC.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/30.
//  Copyright © 2017年 刘虎超. All rights reserved.
//

#import "JCLLimitVC.h"
#import "JCLDataCell.h"
#import "JCLLimitHeader.h"
#import "JCLLimitCell.h"
#import "JCLSJYJModel.h"
#import "JCLStockMain.h"

#import "JCLAStockRangeCell.h"
#import "JCLTodayRangeCell.h"
#import "JCLFirmRangeCell.h"
#import "JCLStockHotHead.h"
#import "LHCNewMenuView.h"
@interface JCLLimitVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UITableView *righttableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSMutableArray *moduleArr;
@property (nonatomic,strong) JCLLimitHeader *header;

@property (nonatomic,assign) NSInteger start;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,assign) NSInteger sort;
@property (nonatomic,assign) NSInteger coltype;

@property(nonatomic, strong) NSArray *headArr;
@property(nonatomic, strong) NSArray *AStockArr;
@property(nonatomic, strong) NSArray *AStockKeyArr;

@property (nonatomic, strong) id AStockObj;
@property (nonatomic, strong) id TodayObj;
@property (nonatomic, strong) id FirmObj;
@property (nonatomic, strong) NSMutableArray *marketArr;
@end

@implementation JCLLimitVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=JCLRGB(243, 243, 243);
    self.moduleArr=[NSMutableArray arrayWithCapacity:0];
    self.marketArr=[NSMutableArray arrayWithCapacity:0];
    [self drawHeader];
    [self drawMenuView];
    self.headArr = @[@"沪深A股涨跌分布", @"非一字板涨停今日平均涨跌幅", @"涨跌停家数", @" ", @"  ", @"  "];
    
    self.tableView=[LHCObject LHCTable:self.view target:self frame:CGRectMake(0, [LHCObject height:40]+([LHCObject height:32]+[LHCObject height:40]+108), JCLWIDTH,self.view.height-[LHCObject height:40]-64-[LHCObject height:40]-([LHCObject height:32]+[LHCObject height:40]+108)) style:UITableViewStylePlain];

    self.tableView.backgroundColor=[UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator      = YES;

    self.righttableView=[LHCObject LHCTable:self.view target:self frame:CGRectMake(0, [LHCObject height:40], JCLWIDTH,self.view.height-[LHCObject height:40]-64-[LHCObject height:40]) style:UITableViewStylePlain];
    self.righttableView.showsVerticalScrollIndicator = YES;
    self.righttableView.hidden = YES;

    __weak JCLLimitVC *weakself=self;
    [_tableView JCLHeaderGifBlock:^{
        [weakself loadNew];
    }];
    
    [self.tableView JCLFooterBlock:^{
        [weakself loadMore];
    }];
    
    self.start=0;
    self.type=0;
    self.sort=1;
    self.coltype=1;
    [self loadData];
}


//上拉加载更多
- (void)loadMore{
    if(self.dataArr.count>29){
        self.start+=30;
        [self loadData];
    }else{
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

//下拉加载最新
- (void)loadNew{
    self.start-=30;
    if(self.start<0)
    {
       self.start=0;
    }
    [self loadData];
}

- (void)drawHeader{
    JCLLimitHeader *header=[[JCLLimitHeader alloc]init];
    header.backgroundColor=[UIColor whiteColor];
    header.titleArr=@[@"涨停板",@"涨停打开",@"跌停板",@"跌停打开"];
    header.topaction = ^(NSInteger idx) {
       
    };
    
    //升降排序回调
    __weak JCLLimitVC *weakself=self;
    header.sortaction = ^(NSInteger idx) {
        weakself.coltype=header.selectBtn.tag;
        weakself.sort=idx;
        [JCLSVProgressHUD showHUD];
        [weakself loadData];
    };
    
    //板块选择回调
    header.action  = ^(NSInteger idx) {
        [JCLSVProgressHUD showHUD];
        [_dataArr removeAllObjects];
        self.start=0;
        self.type=idx; [self loadData];
    };
    
    header.frame=CGRectMake(0,[LHCObject height:40] , JCLWIDTH, [LHCObject height:32]+[LHCObject height:40]+108);
    [self.view addSubview:header];
    self.header=header;
}

- (void)drawMenuView{
    LHCNewMenuView *menuView=[[LHCNewMenuView alloc]init];
    menuView.titleArr = @[@"涨停强度",@"爆炒热度"];
    menuView.frame         = CGRectMake(0, 0, 0.5*JCLWIDTH, [LHCObject height:40]);
    menuView.ChangeBlock       = ^(NSInteger idx){
               //切换栏目回调
       if(idx==0){
       self.righttableView.hidden = YES;
       self.tableView.hidden      = NO;
       }else{
       self.righttableView.hidden = NO;
       self.tableView.hidden      = YES;
        }
    [_tableView reloadData];
    };
    [self.view addSubview:menuView];
    
    UIView *bgView = [LHCObject LHCView:self.view backgroundColor:[UIColor whiteColor]];
    bgView.frame   = CGRectMake(menuView.maxX, menuView.y, menuView.width, menuView.height);
}

#pragma mark tableView的代理和数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.righttableView==tableView){
        return 3;
    }
    return 1;
}

-(nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(self.righttableView==tableView){
    JCLStockHotHead *head = [[JCLStockHotHead alloc]init]; head.text.text = self.headArr[section];
    return head;
    }return [UIView new];
};

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(self.righttableView==tableView){return 38;}return 0; }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.righttableView==tableView){
        return 1;
    }else{
       return _dataArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.righttableView){
        return 220;
    }
    return [LHCObject height:50];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(self.righttableView==tableView){
        if(section==2){return 0;}
        return 5;}return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.righttableView==tableView)
    {
        switch (indexPath.section) {
            case 0: return  [self AStockRange:tableView]; break;
            case 1: return  [self TodayRange:tableView]; break;
            case 2: return  [self FirmRange:tableView]; break;
                
            default:
                break;
        }
    }
    JCLLimitCell *cell=[JCLLimitCell CellWithTableView:tableView];
    JCLSJYJModel *model=_dataArr[indexPath.row];
    if(model.setcode==0){
        cell.codeLab.text=[NSString stringWithFormat:@"SZ%@",model.code];
    }else{
        cell.codeLab.text=[NSString stringWithFormat:@"SH%@",model.code];
    }
    cell.nameLab.text=model.name;
    if(model.code.length){
        if([[model.code substringToIndex:2] isEqualToString:@"15"] || [[model.code substringToIndex:2] isEqualToString:@"16"] ||  [[model.code substringToIndex:2] isEqualToString:@"50"] ||  [[model.code substringToIndex:2] isEqualToString:@"13"] ||  [[model.code substringToIndex:2] isEqualToString:@"20"] ||  [[model.code substringToIndex:2] isEqualToString:@"14"]){
            cell.label2.text=[NSString stringWithFormat:@"%.3lf",model.now];
            cell.label1.text=[NSString stringWithFormat:@"%.2lf%%",model.zf];
        }else{
            cell.label2.text=[NSString stringWithFormat:@"%.2lf",model.now];
            cell.label1.text=[NSString stringWithFormat:@"%.2lf%%",model.zf];
        }
    }
    cell.label1.textColor=[LHCObject Newprice:cell.label1.text Price:@"0.00"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.righttableView==tableView)
    {return;}
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    JCLLimitCell *cell= (JCLLimitCell *)[tableView cellForRowAtIndexPath:indexPath];
    self.action(@[cell.nameLab.text,cell.codeLab.text]);
}

- (void)loadData
{
    [_moduleArr removeAllObjects];
    [self.marketArr removeAllObjects];
    [self loadAStockRange];
    NSString *URL=[NSString stringWithFormat:@"%@zdfdata?start=%zd&num=30&type=%zd&sorttype=%zd&coltype=%zd",SJYJ,self.start,self.type,self.sort,self.coltype];
    [JCLHttps getJson:URL success:^(id obj) {
    
    //self.moduleArr数组里面分别是蓄势(xs)  冲关(cg)  封板(fb)对应的数据
    self.dataArr=[JCLSJYJModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
    if(self.dataArr.count){
            [self.moduleArr addObjectsFromArray:@[obj[@"xs_t_num"],obj[@"xs_y_num"],obj[@"cg_t_num"],obj[@"cg_y_num"],obj[@"fb_t_num"],obj[@"fb_y_num"]]];
            self.header.dataArr=self.moduleArr;
            self.header.numberArr=@[[NSString stringWithFormat:@"%@/%@",self.moduleArr[0],self.moduleArr[1]],[NSString stringWithFormat:@"%@/%@",self.moduleArr[2],self.moduleArr[3]],[NSString stringWithFormat:@"%@/%@",self.moduleArr[4],self.moduleArr[5]]]; }
        
        if(obj){
            NSMutableArray *arrM = [[NSMutableArray alloc]init];
            NSArray *riseArr = obj[@"znums"], *fallArr = obj[@"dnums"];
            [riseArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [arrM addObject:[NSString stringWithFormat:@"%@", obj]];
            }];
            
            [fallArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx>0) { [arrM addObject:[NSString stringWithFormat:@"%@", obj]]; }
            }];
            
            self.AStockKeyArr = @[[NSString stringWithFormat:@"上涨(%@)", [riseArr valueForKeyPath:@"@max.floatValue"]],
                                  [NSString stringWithFormat:@"平盘(%@)", riseArr[0]],
                                  [NSString stringWithFormat:@"下跌(%@)", [fallArr valueForKeyPath:@"@max.floatValue"]]];
            self.AStockArr = arrM; [self.righttableView reloadData];
        }
        [_tableView reloadData];
        [self.righttableView reloadData];
        [JCLSVProgressHUD   dimissHUD];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }failure:^(NSError *error) {
        //[JCLSVProgressHUD showErrorHud:@"请求超时!"];
    }];
}


-(UITableViewCell *)AStockRange:(UITableView *)table{
    JCLAStockRangeCell *cell = [JCLAStockRangeCell cellWithTable:table style:UITableViewCellStyleDefault];
    id obj = self.AStockObj;
    if (obj) {
        NSMutableArray *arrM = [[NSMutableArray alloc]init];
        NSArray *riseArr = obj[@"znums"], *fallArr = obj[@"dnums"];
        [[[riseArr reverseObjectEnumerator] allObjects] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx<riseArr.count-1) { [arrM addObject:[NSString stringWithFormat:@"%@", obj]]; }
        }];
        [fallArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx>0) { [arrM addObject:[NSString stringWithFormat:@"%@", obj]]; }
        }];
        [arrM insertObject:[NSString stringWithFormat:@"%@", riseArr[0]] atIndex:riseArr.count-1];
        NSString *val = [riseArr valueForKeyPath:@"@sum.floatValue"];
        cell.keyArr = @[[NSString stringWithFormat:@"上涨(%d)", [val intValue] - [riseArr[0] intValue]],
                        [NSString stringWithFormat:@"平盘(%@)", riseArr[0]],
                        [NSString stringWithFormat:@"下跌(%@)", [fallArr valueForKeyPath:@"@sum.floatValue"]]];
        cell.arr = arrM;
        self.AStockObj = nil;
    }
    return cell;
}

-(UITableViewCell *)TodayRange:(UITableView *)table{
    JCLTodayRangeCell *cell = [JCLTodayRangeCell cellWithTable:table style:UITableViewCellStyleDefault];
    id obj = self.TodayObj;
    if (obj) {
        cell.idx = [obj[@"subindex"] integerValue];
        cell.arr = obj[@"azd"];
        self.TodayObj = nil;
    }
    return cell;
}

-(UITableViewCell *)FirmRange:(UITableView *)table{
    JCLFirmRangeCell *cell = [JCLFirmRangeCell cellWithTable:table style:UITableViewCellStyleDefault];
    id obj = self.FirmObj;
    if (obj) {
        cell.idx = [obj[@"subindex"] integerValue];
        cell.riseArr = obj[@"ztjs"];
        cell.fallArr = obj[@"dtjs"];
        self.FirmObj = nil;
    }
    return cell;
}



-(void)loadAStockRange{
    NSString *url = [NSString stringWithFormat:@"%@/freehqwebserver/zdfdata?start=0&num=30&type=0&sorttype=1&coltype=1", bc1Url];
    [JCLHttpsObj JCLGetJson:url success:^(id obj) {
        self.AStockObj = obj; self.TodayObj = obj; self.FirmObj = obj;
        [self.tableView reloadData];
        [self.righttableView reloadData];
    } failure:^(NSError *error) { }];
}

@end
