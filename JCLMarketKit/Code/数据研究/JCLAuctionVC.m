//
//  JCLAuctionVC.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/30.
//  Copyright © 2017年 刘虎超. All rights reserved.
//  集合竞价

#import "JCLAuctionVC.h"
#import "JCLDataCell.h"
#import "JCLSJYJModel.h"
#import "JCLStockList.h"
#import "LHCMenuScrollView.h"
#import "JCLNewStockHeader.h"
#import "LHCNewMenuView.h"

@interface JCLAuctionVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) NSInteger start;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,assign) NSInteger sort;
@property (nonatomic,assign) NSInteger coltType;
@property (nonatomic,assign) NSInteger idx;
@property (nonatomic,strong) JCLNewStockHeader *header;
@property (nonatomic,strong) NSMutableArray *cellArrM;
@end

@implementation JCLAuctionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawMenuView];
    
    self.dataArr=[NSMutableArray arrayWithCapacity:0];
    self.tableView=[LHCObject LHCTable:self.view target:self frame:CGRectMake(0, [LHCObject height:35]*2, JCLWIDTH,self.view.height-[LHCObject height:40]-64-[LHCObject height:35]*2) style:UITableViewStylePlain];
    self.tableView.showsVerticalScrollIndicator=YES;
    
    //上拉刷新

    [self.tableView JCLFooterGifBlock:^{
        [self loadMore];
    }];
    
    [self.tableView JCLHeaderGifBlock:^{
        [self loadNew];
    }];
    
    self.header = [[JCLNewStockHeader alloc]init];
    self.header.frame = CGRectMake(0, [LHCObject height:40], JCLWIDTH, [LHCObject height:40]);
    [self.view addSubview:self.header];
    _titleArray=@[@"当日涨幅",@"最新价",@"试盘时间",@"集竞多空"];
    self.header.textArr=_titleArray;
    
    self.header.slideActionBlock =^(UIScrollView *scroll){ [self scrollViewDidScroll:scroll]; };
    self.header.codeActionBlock = ^(NSInteger idx){  };
    self.header.riseActionBlock =^(NSInteger idx){  };
    self.header.dropActionBlock =^(NSInteger idx){  };
    
    self.start=0;
    self.type=9;
    self.sort=1;
    self.coltType=1;
    self.idx=0;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JCLDataCell *cell=[JCLDataCell cellWithTableView:tableView style:UITableViewCellStyleDefault];
    if(_dataArr.count){
    JCLSJYJModel *model=_dataArr[indexPath.row];
    cell.scroll.delegate=self;
    if(model.setcode==0){
        cell.code.text=[NSString stringWithFormat:@"SZ%@",model.code];
    }else{
        cell.code.text=[NSString stringWithFormat:@"SH%@",model.code];
    }
    cell.title.text=model.name;
    NSString *flag;
    if(self.idx==0 || self.idx==1){
        switch (model.jj_flag) {
                case 0:
                flag=@"无状态";
                break;
                
                case 1:
                flag=@"看多";
                break;
                
            case 2:
                flag=@"看空";
            break;
                                
            default:
                flag=@"多空混战";
            break;
        }
        cell.colorArr = @[[LHCObject Newprice:[NSString stringWithFormat:@"%.2lf%%",model.zf] Price:@"0.00"],[UIColor blackColor],[UIColor blackColor],[UIColor blackColor]];
        
        cell.arr=@[[NSString stringWithFormat:@"%.2lf%%",model.zf],[NSString stringWithFormat:@"%.2lf",model.now],[LHCObject FormatTimeString:[NSString stringWithFormat:@"%zd",model.time]],[NSString stringWithFormat:@"%@",flag]];
    }else{
        cell.colorArr = @[[LHCObject Newprice:[NSString stringWithFormat:@"%.2lf%%",model.zf] Price:@"0.00"],[UIColor blackColor],[LHCObject Newprice:[NSString stringWithFormat:@"%.2lf%%",model.sanzf] Price:@"0.00"],[LHCObject Newprice:[NSString stringWithFormat:@"%.2lf%%",model.wuzf] Price:@"0.00"]];
        cell.arr=@[[NSString stringWithFormat:@"%.2lf%%",model.zf],[NSString stringWithFormat:@"%.2lf",model.now],[NSString stringWithFormat:@"%.2lf%%",model.sanzf],[NSString stringWithFormat:@"%.2lf%%",model.wuzf]];
    }
        
    
    [self.cellArrM addObject:cell.scroll];
    }
    if(_titleArray.count>3){
        cell.scroll.scrollEnabled=YES;
        self.header.scroll.scrollEnabled=YES;
    }else{
        cell.scroll.scrollEnabled=NO;
        self.header.scroll.scrollEnabled=NO;
    }
    cell.actionBlock = ^{
        self.AuctionAction(@[cell.title.text,cell.code.text]);
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [LHCObject height:50];
}




#pragma mark MenuView
- (void)drawMenuView{
    LHCNewMenuView *menuView=[[LHCNewMenuView alloc]init];
    menuView.titleArr=@[@"涨停试盘",@"跌停试盘",@"集竞看多",@"集竞看空",@"多空混战"];
    menuView.frame=CGRectMake(0, 0,JCLWIDTH, [LHCObject height:40]);
    menuView.contentSize=CGSizeMake(5*0.25*JCLWIDTH, [LHCObject height:40]);
    [self.view addSubview:menuView];
    menuView.ChangeBlock = ^(NSInteger idx) {
        for (UIScrollView *scroll in self.cellArrM){
            [scroll setContentOffset:CGPointMake(0, 0)];
            [self.header.scroll setContentOffset:CGPointMake(0, 0)];
        }
        switch (idx) {
            case 0:
                _titleArray=@[@"当日涨幅",@"最新价",@"试盘时间",@"集竞多空"];
                 break;
             case 1:
                _titleArray=@[@"当日涨幅",@"最新价",@"试盘时间",@"集竞多空"];
                break;
                
              default:
                _titleArray=@[@"当日涨幅",@"最新价",@"近三日涨幅",@"近五日涨幅"];
                break;
        }
        self.header.textArr=_titleArray;
        [self changedata:idx];
    };
}


- (void)loadData
{
    NSString *URL=[NSString stringWithFormat:@"%@zdfdata?start=%zd&num=30&type=%zd&sorttype=%zd&coltype=%zd",SJYJ,self.start,self.type,self.sort,self.coltType];
    [JCLHttps getJson:URL success:^(id obj) {
        self.dataArr=[JCLSJYJModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
             if(!_dataArr.count){
                 [self nodataImg:@""];
                 _tableView.hidden=YES;
             }else{
                 [self hiddenNodataView];
                 _tableView.hidden=NO;
                 [_tableView reloadData];
             }
        [JCLSVProgressHUD dimissHUD];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
      
    }];
}

- (void)changedata:(NSInteger )idx
{
    [self.dataArr removeAllObjects];
    self.idx=idx;
    self.start=0;
    self.sort=1;
    self.coltType=1;
    //改变类型
    self.type=9+idx;
    [JCLSVProgressHUD showHUD];
    [self loadData];
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
