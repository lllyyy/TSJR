//
//  JCLNewStockVC.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/30.
//  Copyright © 2017年 刘虎超. All rights reserved.
//  次新擒牛

#import "JCLNewStockVC.h"
#import "JCLDataCell.h"
#import "JCLSJYJModel.h"
#import "LHCMenuScrollView.h"
#import "JCLNewStockHeader.h"
#import "LHCNewMenuView.h"
@interface JCLNewStockVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) NSInteger start;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,assign) NSInteger sort;
@property (nonatomic,assign) NSInteger coltype;

@property (nonatomic,strong) NSMutableArray *cellArrM;
@property (nonatomic,strong) JCLNewStockHeader *header;

@end

@implementation JCLNewStockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawMenuView];
    self.dataArr  = [NSMutableArray arrayWithCapacity:0];
    
    self.tableView=[LHCObject LHCTable:self.view target:self frame:CGRectMake(0, [LHCObject height:40]*2, JCLWIDTH, self.view.height-[LHCObject height:40]-64-[LHCObject height:40]*2) style:UITableViewStylePlain];
    
    self.tableView.showsVerticalScrollIndicator=YES;
    
    //上拉刷新
    [self.tableView JCLFooterGifBlock:^{
        [self loadMore];
    }];
    //下拉
    
    [self.tableView JCLHeaderGifBlock:^{
        [self loadNew];
    }];
    self.start=0;
    self.type=5;
    self.sort=1;
    self.coltype=1;
    [self loadData];
    
    __weak JCLNewStockVC *weakSelf = self;
    
    self.style=NewFirstDay;
    self.header = [[JCLNewStockHeader alloc]init];
    self.header.frame = CGRectMake(0, [LHCObject height:40], JCLWIDTH, [LHCObject height:40]);
    [self.view addSubview:self.header];
    _titleArray=@[@"当日涨幅",@"最新价",@"连板数",@"累计涨幅"];
    self.header.textArr=_titleArray;

    self.header.slideActionBlock =^(UIScrollView *scroll){ [weakSelf scrollViewDidScroll:scroll]; };
    self.header.codeActionBlock = ^(NSInteger idx){  };
    self.header.riseActionBlock =^(NSInteger idx){  };
    self.header.dropActionBlock =^(NSInteger idx){  };
    
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
    [JCLSVProgressHUD showHUD];
    self.start-=30;
    if(self.start<0)
    {
        self.start=0;
    }
    [self loadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JCLDataCell *cell = [JCLDataCell cellWithTableView:tableView style:UITableViewCellStyleDefault];
    JCLSJYJModel *model=_dataArr[indexPath.row];
    cell.scroll.delegate=self;
    if(model.setcode==0){
        cell.code.text=[NSString stringWithFormat:@"SZ%@",model.code];
    }else{
        cell.code.text=[NSString stringWithFormat:@"SH%@",model.code];
    }
    cell.title.text=model.name;
    
    switch (self.style) {
        case NewHigh:
        {
            //对应当日涨幅、最新价
            cell.colorArr=@[[LHCObject Newprice:[NSString stringWithFormat:@"%.2lf%%",model.zf] Price:@"0.00"],[UIColor whiteColor],[UIColor blackColor]];
            
            cell.arr=@[[NSString stringWithFormat:@"%.2lf%%",model.zf],@"",[NSString stringWithFormat:@"%.2lf",model.now]];
        }
            break;
            
        case NewFall:
        {
            //对应当日涨幅、最新价
            cell.colorArr=@[[LHCObject Newprice:[NSString stringWithFormat:@"%.2lf%%",model.zf] Price:@"0.00"],[UIColor blackColor],[LHCObject Newprice:[NSString stringWithFormat:@"%.2lf%%",model.cxzd] Price:@"0.00"]];
            
            cell.arr=@[[NSString stringWithFormat:@"%.2lf%%",model.zf],[NSString stringWithFormat:@"%.2lf",model.now],[NSString stringWithFormat:@"%.2lf%%",model.cxzd]];
        }
            break;
            
        case NewPrice:{
            //对应当日涨幅、最新价
            cell.colorArr=@[[LHCObject Newprice:[NSString stringWithFormat:@"%.2lf%%",model.zf] Price:@"0.00"],[UIColor blackColor],[UIColor blackColor]];
            
            cell.arr=@[[NSString stringWithFormat:@"%.2lf%%",model.zf],[NSString stringWithFormat:@"%.2lf",model.now],[NSString stringWithFormat:@"%.2lf",model.ssprice]];
        }
            break;
            
        default:
            //对应当日涨幅、最新价、累计跌幅
            cell.colorArr=@[[LHCObject Newprice:[NSString stringWithFormat:@"%.2lf%%",model.zf] Price:@"0.00"],[UIColor blackColor],[UIColor blackColor],[LHCObject Newprice:[NSString stringWithFormat:@"%.2lf%%",model.cxzf] Price:@"0.00"]];
            
            cell.arr=@[[NSString stringWithFormat:@"%.2lf%%",model.zf],[NSString stringWithFormat:@"%.2lf",model.now],[NSString stringWithFormat:@"%zd",model.continue_num],[NSString stringWithFormat:@"%.2lf%%",model.cxzf]];
            break;
    }
    [self.cellArrM addObject:cell.scroll];
    
    if(_titleArray.count>3){
        cell.scroll.scrollEnabled=YES;
        self.header.scroll.scrollEnabled=YES;
    }else{
        cell.scroll.scrollEnabled=NO;
        self.header.scroll.scrollEnabled=NO;
    }
    cell.actionBlock = ^{
       self.PushList(@[cell.title.text,cell.code.text]);
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [LHCObject height:50];
}

#pragma mark 初始化MenuView
- (void)drawMenuView{
    LHCNewMenuView *menuView=[[LHCNewMenuView alloc]init];
    menuView.titleArr=@[@"首日打开",@"成功回封",@"一字连板",@"再创新高",@"阶段超跌",@"低价潜力"];
    menuView.ChangeBlock = ^(NSInteger idx) {
        self.style=idx;
        [_dataArr removeAllObjects];
        for (UIScrollView *scroll in self.cellArrM){
            [scroll setContentOffset:CGPointMake(0, 0)];
            [self.header.scroll setContentOffset:CGPointMake(0, 0)];
        }
        if(idx==4){
            self.type=14;
        }else if(idx==5){
            self.type=15;
        }else{
            self.type=idx+5;
        }
        self.start=0;
        [JCLSVProgressHUD showHUD];
        [self loadData];
        
        switch (self.style) {
            case NewHigh:
                _titleArray=@[@"当日涨幅",@"hidden",@"最新价"];
            
                break;
             case NewFall:
                _titleArray=@[@"当日涨幅",@"最新价",@"累计跌幅"];
                
                break;
            case NewPrice:
                _titleArray=@[@"当日涨幅",@"最新价",@"上市价格"];
             
                break;
            default:
                _titleArray=@[@"当日涨幅",@"最新价",@"连板数",@"累计涨幅"];
                break;
        }
        self.header.textArr=_titleArray;
    };
    menuView.frame = CGRectMake(0, 0, JCLWIDTH, [LHCObject height:40]);
    menuView.contentSize = CGSizeMake(1.5*JCLWIDTH, [LHCObject height:40]);
    [self.view addSubview:menuView];
}

- (void)loadData
{
    [_tableView reloadData];
    NSString *URL=[NSString stringWithFormat:@"%@zdfdata?start=%zd&num=30&type=%zd&sorttype=%zd&coltype=%zd",SJYJ,self.start,self.type,self.sort,self.coltype];
    [JCLHttps getJson:URL success:^(id obj) {
        //数组里面分别是蓄势(xs)  冲关(cg)  封板(fb)对应的数据
        self.dataArr=[JCLSJYJModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
             if(!_dataArr.count){
                 [self nodataImg:@""];
                 _tableView.hidden=YES;
             }else{
                 [self hiddenNodataView];
                 _tableView.hidden=NO;
             }
        [_tableView reloadData];
        [JCLSVProgressHUD dimissHUD];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }failure:^(NSError *error) {
        
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView==self.tableView){
        
    }else{
        [self.header.scroll setContentOffset:scrollView.contentOffset];
        for (UIScrollView *scroll in self.cellArrM){
            [scroll setContentOffset:scrollView.contentOffset];
        }
    }
}


- (NSMutableArray *)cellArrM {
    if(!_cellArrM){
        _cellArrM=[NSMutableArray arrayWithCapacity:0];
    }
    return _cellArrM;
}
@end
