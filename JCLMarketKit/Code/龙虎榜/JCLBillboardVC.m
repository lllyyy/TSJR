//
//  JCLBillboardVC.m
//  Jincelue_iOS
//
//  Created by  on 2017/3/6.
//  Copyright © 2017年 ruixue. All rights reserved.
//

#import "JCLBillboardVC.h"
#import "JCLBillboardSegment.h"
#import "LHCMenuView.h"
#import "JCLBillboardView.h"
#import "JCLBillboardTableViewCell.h"
#import "JCLDayListModel.h"
#import "JCLStockModel.h"
#import "HZQDatePickerView.h"
#import "JCLStockMain.h"
#import "JCLBusinessRankVC.h"
#import "JCLMarketSearchList.h"

@interface JCLBillboardVC ()<UITableViewDelegate,UITableViewDataSource,HZQDatePickerViewDelegate>
{
    UITableView *_tableView;
    LHCMenuView *_menuView;
    LHCMenuView *_menuView2;
    LHCMenuView *_menuView3;
    
    HZQDatePickerView *_pikerView;
    NSString *_url;
    NSString *_url1;
    NSString *_url2;
    UIButton *_timeBtn;
    NSInteger _count;
    NSInteger _page;
    //个股排名类型
    NSInteger type;
    //营业部排名type
     NSInteger type2;
    NSString *_date;
    NSMutableArray *_dataArr;
    //每日上榜选中类型分为 全部股票 沪市 深市
    NSInteger dayIdx;
}

@property (nonatomic,strong)  JCLBillboardView *header;

@end

@implementation JCLBillboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navi.right.img=@"sousuo1";
    __weak JCLBillboardVC *weakSelf=self;
    
    self.rightActionBlock = ^{
        [weakSelf.navigationController pushViewController:[[JCLMarketSearchList alloc]init] animated:YES];
    };
    _dataArr=[NSMutableArray arrayWithCapacity:0];
    self.type= BillboardTypeDay;
     [JCLSVProgressHUD showshadowHUD];
    //根据类型匹配需要选中的
    [self drawSegment:self.type];
    //初始化一些其他控件
    [self drawView];
    //头部
    [self drawHeader];
    //默认为今天
    _date = _timeBtn.currentTitle;
    
    type=1;
    type2=1;
    _count=30;
    _page=1;
    //默认为每日上榜  
    _url=[NSString stringWithFormat:@"%@PageStockonListServlet?count=%zd&pageNo=%zd&date=%@",LHBURL,_count,_page,_date];
    [self selectTypeDataUrl:_url];
}

#pragma mark-UITableViewDelegate、UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.type) {
        //营业部排名
        case BillboardTypeRank:
        {
            return   [self billboardRankCell:tableView Idx:indexPath];
        }
            break;
        //因为个股和每日上榜cell一样所以共用
        default:
        {
          return   [self billboardTableViewCell:tableView Idx:indexPath];
        }
            break;
    }
}

#pragma  mark -自定义cell cell内容过长单独抽出来方便查阅
//营业部排名cell
- (UITableViewCell *)billboardRankCell:(UITableView *)tableView Idx:(NSIndexPath *)indexPath;
{
    JCLBillboardRank *cell=[JCLBillboardRank CellWithTableView:tableView];
    JCLRankModel *model=_dataArr[indexPath.row];
    cell.nameLab.attributedText = [JCLBaseManage RXAttStr:model.company_name spac:8];
    cell.numberLab.text= [NSString stringWithFormat:@"%zd",model.times_buy];
    return cell;
}

//每日上榜  个股排名cell
- (UITableViewCell *)billboardTableViewCell:(UITableView *)tableView Idx:(NSIndexPath *)indexPath
{
    JCLBillboardTableViewCell *cell=[JCLBillboardTableViewCell CellWithTableView:tableView];
    if(self.type==BillboardTypeDay)
    {
        JCLDayListModel *model=_dataArr[indexPath.row];
        cell.stockCodeLab.text=[NSString stringWithFormat:@"%@%@",[model.setcode uppercaseString],model.stock_code];
        cell.stockNameLab.text=model.stock_name;
        //四舍五入不准确
        NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                  scale:2
                                       raiseOnExactness:NO                                        raiseOnOverflow:NO
                                      raiseOnUnderflow:NO
                                      raiseOnDivideByZero:NO];

        
        NSDecimalNumber *numberA = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%.3lf%%",model.cp]];
        
        NSString *tempStr =[[numberA decimalNumberByRoundingAccordingToBehavior:roundingBehavior] stringValue];
        cell.roseLab.text=[NSString stringWithFormat:@"%@%%",tempStr];
        //涨跌幅
        cell.roseLab.textColor=[LHCObject Newprice:cell.roseLab.text Price:@"0.00"];
        if(model.amount_buy_net/10000.0>=10000.0 || model.amount_buy_net/10000.0<-10000.0)
        {
            cell.moneyLab.text=[NSString stringWithFormat:@"%.2lf亿",model.amount_buy_net/10000.0/10000.0];
        }else{
            cell.moneyLab.text=[NSString stringWithFormat:@"%.2lf万",model.amount_buy_net/10000.0];
        }
        
        cell.moneyLab.textColor=[LHCObject Newprice:cell.moneyLab.text Price:@"0.00"];
    }else{
        JCLStockModel *model=_dataArr[indexPath.row];
        cell.stockCodeLab.text=[NSString stringWithFormat:@"%@%@",[model.setcode uppercaseString],model.stock_code];
        cell.stockNameLab.text=model.stock_name;
        cell.roseLab.text=[NSString stringWithFormat:@"%zd",model.times];
        cell.roseLab.textColor=[UIColor blackColor];
       if(model.amount_net_buy/10000.0>=10000.0 || model.amount_net_buy/10000.0<-10000.0)
        {
            cell.moneyLab.text=[NSString stringWithFormat:@"%.2lf亿",model.amount_net_buy/10000.0/10000.0];
        }else{
           cell.moneyLab.text=[NSString stringWithFormat:@"%.2lf万",model.amount_net_buy/10000.0];
        }
        cell.moneyLab.textColor=[LHCObject Newprice:cell.moneyLab.text Price:@"0.00"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(self.type!=BillboardTypeRank){
    JCLStockMain *listVC=[[JCLStockMain alloc]init];
    NSMutableArray *arr=[NSMutableArray arrayWithCapacity:0];
    JCLBillboardTableViewCell *cell=(JCLBillboardTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [arr addObject:[JCLMarketObj JCLStockInfo:cell.stockCodeLab.text][4]];
    [arr addObject:cell.stockCodeLab.text];
    listVC.arr=arr;
    [self.navigationController pushViewController:listVC animated:YES];
    }else{
        JCLBusinessRankVC *vc=[[JCLBusinessRankVC alloc]init];
        JCLRankModel *model=_dataArr[indexPath.row];
        vc.navigationItem.title=model.company_name;
        vc.company_id=model.company_id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark-其他
- (void)drawView
{
    self.view.backgroundColor=[UIColor whiteColor];
    //每日上榜
    _menuView=[LHCMenuView MenuViewTitleArray:@[@"全部股票",@"沪市",@"深市"] SelectLineHeight:2.8 SelectLineColor:[UIColor redColor] Selectidx:0 Blcok:^(UIButton *btn) {
        _count=30;
        dayIdx=btn.tag;
        [JCLSVProgressHUD showshadowHUD];

        
        [self selectTypeDataUrl:[self dayTypeUrl:dayIdx]];
    }];
    _menuView.frame=CGRectMake(0, 64, JCLWIDTH*0.72, [LHCObject height:40]);
    [self.view addSubview:_menuView];
    _menuView.lineView.width=JCLWIDTH;
    [_menuView setNeedsLayout];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit| NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:[[NSDate alloc] init]];
    [components setDay:([components day])];
    NSDate *lastWeek  = [cal dateFromComponents:components];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:lastWeek];
    //时间选择按钮
    _timeBtn=[LHCObject LHCButton:self.view Img:@"" Title:dateTime backgroundColor:[UIColor clearColor] Target:self Action:@selector(chooseTimeAction:)];
    _timeBtn.color=[UIColor blackColor];
    _timeBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    _timeBtn.frame=CGRectMake(0.72*JCLWIDTH, 64, 0.28*JCLWIDTH, [LHCObject height:40]);
    //个股排名点击头部切换
    _menuView2=[LHCMenuView MenuViewTitleArray:@[@"近一月",@"近三月",@"近六月",@"近一年"] SelectLineHeight:2.8 SelectLineColor:[UIColor redColor] Selectidx:0 Blcok:^(UIButton *btn) {
        type=btn.tag+1;
        _count=30;
         [JCLSVProgressHUD showshadowHUD];
        _url1=[NSString stringWithFormat:@"%@PageStockonRankServlet?count=%zd&pageNo=%zd&type=%zd",LHBURL,_count,_page,type];
        [self selectTypeDataUrl:_url1];
    }];
    _menuView2.hidden=YES;
    _menuView2.frame=CGRectMake(0, 64, JCLWIDTH, [LHCObject height:40]);
    [self.view addSubview:_menuView2];
    
    //营业部
    _menuView3=[LHCMenuView MenuViewTitleArray:@[@"近一月",@"近三月",@"近六月",@"近一年"] SelectLineHeight:2.8 SelectLineColor:[UIColor redColor] Selectidx:0 Blcok:^(UIButton *btn) {
        type=btn.tag+1;
        _count=30;
         [JCLSVProgressHUD showshadowHUD];
        _url2=[NSString stringWithFormat:@"%@PageDeptonRankServlet??count=%zd&pageNo=%zd&type=%zd",LHBURL,_count,_page,type];
        [self selectTypeDataUrl:_url2];
    }];
    _menuView3.hidden=YES;
    _menuView3.frame=CGRectMake(0, 64, JCLWIDTH, [LHCObject height:40]);
    [self.view addSubview:_menuView3];
    
    _tableView=[LHCObject LHCTable:self.view target:self frame:CGRectMake(0, _menuView.maxY+[LHCObject height:35], JCLWIDTH, JCLHEIGHT-_menuView.maxY-[LHCObject height:35]) style:UITableViewStylePlain];
    _tableView.showsVerticalScrollIndicator=YES;
    _tableView.rowHeight=[LHCObject height:51];
    
    [_tableView JCLHeaderGifBlock:^{
        [self loadNew];
    }];
    
    [_tableView JCLHeaderGifBlock:^{
        [self loadMore];
    }];
}

- (void)drawSegment:(BillboardType)billboardType{
    JCLBillboardSegment *segment=[[JCLBillboardSegment alloc]initWithFrame:CGRectMake(0.15*JCLWIDTH, 25, 0.7*JCLWIDTH, 30)];
    segment.titleArray=@[@"每日上榜",@"个股排名",@"营业部排名"];
    //判断类型匹配选择那一个
    segment.selectIdx=billboardType;
    //点击回调block 并且刷新表格
    segment.block=^(UISegmentedControl *segment){
    
        [JCLSVProgressHUD showshadowHUD];
        _menuView2.hidden=YES;
        _menuView.hidden=YES;
        _menuView3.hidden=YES;
        _timeBtn.hidden=YES;
        _count=30;
        self.type=segment.selectedSegmentIndex;
        [self drawHeader];
      /* 分段选择点击切换 默认还原状态*/
        if(segment.selectedSegmentIndex==0){
            _menuView.hidden=NO;
            _timeBtn.hidden=NO;
            _url=[NSString stringWithFormat:@"%@PageStockonListServlet?count=%zd&pageNo=%zd&date=%@",LHBURL,_count,_page,_date];
            [self selectTypeDataUrl:_url];
        }else if(segment.selectedSegmentIndex==1){
            _menuView2.hidden=NO;
            _url1=[NSString stringWithFormat:@"%@PageStockonRankServlet?count=%zd&pageNo=%zd&type=%zd",LHBURL,_count,_page,type];
            [self selectTypeDataUrl:_url1];
            [self hiddenNodataView];
        }else{
            _menuView3.hidden=NO;
            _url2=[NSString stringWithFormat:@"%@PageDeptonRankServlet?count=%zd&pageNo=%zd&type=%zd",LHBURL,_count,_page,type];
            [self selectTypeDataUrl:_url2];
            [self hiddenNodataView];
        }
    };
    [self.view addSubview:segment];
}



/**根据类型改变头部视图文本*/
- (void)drawHeader{
    switch (self.type) {
        case BillboardTypeRank:
        {self.header.titleArr=@[@"营业部名称",@"",@"买入上榜次数"];}
            break;
            
        case BillboardTypeStock:
        {self.header.titleArr=@[@"股票名称",@"上榜次数",@"净买入额"];}
            break;
            
        default:
        {self.header.titleArr=@[@"股票名称",@"涨幅",@"净买入额"];}
            break;
    }
}

- (JCLBillboardView *)header
{
    if(!_header){
        JCLBillboardView *header=[[JCLBillboardView alloc]init];
        header.frame=CGRectMake(0, _menuView.maxY, JCLWIDTH, [LHCObject height:35]);
        [self.view addSubview:header];
        _header=header;
    }
    return _header;
}

//tableView下拉加载最新
- (void)loadNew{
    _count=30;
    switch (self.type) {
        case BillboardTypeDay:
        {
           [self selectTypeDataUrl:[self dayTypeUrl:dayIdx]];
        }
            break;
            
        case BillboardTypeStock:
        {
            _url1=[NSString stringWithFormat:@"%@PageStockonRankServlet?count=%zd&pageNo=%zd&type=%zd",LHBURL,_count,_page,type];
            [self selectTypeDataUrl:_url1];
        }
            break;
            
        default:
            _url2=[NSString stringWithFormat:@"%@PageDeptonRankServlet??count=%zd&pageNo=%zd&type=%zd",LHBURL,_count,_page,type];
            [self selectTypeDataUrl:_url2];
            break;
    }
}

//tableView上拉加载更多
- (void)loadMore{
    if(_dataArr.count<_count)
    {
         [_tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    _count+=30;
    switch (self.type) {
        case BillboardTypeDay:
        {
            [self selectTypeDataUrl:[self dayTypeUrl:dayIdx]];
        }
            break;
            
          case BillboardTypeStock:
        {
            _url1=[NSString stringWithFormat:@"%@PageStockonRankServlet?count=%zd&pageNo=%zd&type=%zd",LHBURL,_count,_page,type];
            [self selectTypeDataUrl:_url1];
        }
            break;

        default:
            _url2=[NSString stringWithFormat:@"%@PageDeptonRankServlet??count=%zd&pageNo=%zd&type=%zd",LHBURL,_count,_page,type];
            [self selectTypeDataUrl:_url2];
            break;
    }
}
//根据选中idx返回不同的url
- (NSString *)dayTypeUrl:(NSInteger )idx
{
    NSString *url;
    if(idx==0){
        url=[NSString stringWithFormat:@"%@PageStockonListServlet?count=%zd&pageNo=%zd&date=%@",LHBURL,_count,_page,_date];
    }else if(idx==1){
        url=[NSString stringWithFormat:@"%@PageStockonListServlet?setcode=sh&count=%zd&pageNo=%zd&date=%@",LHBURL,_count,_page,_date];
    }else{
        url=[NSString stringWithFormat:@"%@PageStockonListServlet?setcode=sz&count=%zd&pageNo=%zd&date=%@",LHBURL,_count,_page,_date];
    }
    return url;
}

- (void)selectTypeDataUrl:(NSString *)url{
    
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
    [JCLHttps getJson:url success:^(id obj) {
        [self DataTypeFormatting:obj];
        [JCLSVProgressHUD dimissHUD];
    } failure:^(NSError *error) {
        [JCLSVProgressHUD showErrorHud:@"请求超时!"];
    }];
}

//感觉当前type 转成不同的模型
- (void)DataTypeFormatting:(id)obj{
    [_dataArr removeAllObjects];
    //默认不隐藏
    _tableView.hidden=NO;
    switch (self.type) {
        case BillboardTypeDay:
            _dataArr=[JCLDayListModel mj_objectArrayWithKeyValuesArray:obj[@"jsonList"]];
            if(_dataArr.count){
            JCLDayListModel *model=_dataArr[0];
            NSArray *time=[model.ondate componentsSeparatedByString:@" "];
            [_timeBtn setTitle:[NSString stringWithFormat:@"%@", time[0]] forState:UIControlStateNormal];
            }
            if(_dataArr.count==0){
                [self nodataImg:@"暂无数据"];
                _tableView.hidden=YES;
            }else{
                [self hiddenNodataView];
                _tableView.hidden=NO;
            }
            break;
            
        case BillboardTypeStock:
            _dataArr=[JCLStockModel mj_objectArrayWithKeyValuesArray:obj[@"jsonList"]];
            break;
            
        default:
            _dataArr=[JCLRankModel mj_objectArrayWithKeyValuesArray:obj[@"jsonList"]];
            break;
    }
    [_tableView reloadData];
}

//选择时间
- (void)chooseTimeAction:(UIButton *)sender
{
    [self setupDateView:DateTypeOfEnd];
}


- (void)setupDateView:(DateType)type {
    
    _pikerView = [HZQDatePickerView instanceDatePickerView];
    _pikerView.frame = CGRectMake(0, 0, JCLWIDTH, JCLHEIGHT + 20);
    [_pikerView setBackgroundColor:[UIColor clearColor]];
    _pikerView.delegate = self;
    _pikerView.type = type;
    // 今天开始往后的日期
    [_pikerView.datePickerView setMaximumDate:[NSDate date]];
    
    NSDate *strForDate = [self stringToDate:[NSString stringWithFormat:@"%@",_timeBtn.currentTitle] formatter:@"yyyy-MM-dd"];
    _pikerView.datePickerView.date=strForDate;
    [self.view addSubview:_pikerView];
}

- (NSDate *)stringToDate:(NSString *)datetime formatter:(NSString*)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:datetime];
    return date;
}

- (void)getSelectDate:(NSString *)date type:(DateType)type {
    [_timeBtn setTitle:[NSString stringWithFormat:@"%@", date] forState:UIControlStateNormal];
    _date=_timeBtn.currentTitle;
    [JCLSVProgressHUD showshadowHUD];
    _count=30;
    [self selectTypeDataUrl:[self dayTypeUrl:dayIdx]];
}
@end
