//
//  JCLBusinessRankVC.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/4/14.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLBusinessRankVC.h"
#import "JCLBusinessRankHeader.h"
#import "JCLBusinessOpeneader.h"
#import "JCLBillboardTableViewCell.h"
#import "JCLBunsinessCellModel.h"
#import "JCLStockList.h"
#import "JCLMonkeyView.h"
#import "JCLStockMain.h"
#import "JCLStockRankNotionCell.h"
#import "JCLStockRankMarketCell.h"
#import "JCLStockRankModel.h"
#import "JCLStockRankHistoryCell.h"
#import "LHCMenuView.h"

@interface JCLBusinessRankVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSMutableArray *codeArr;
@property (nonatomic,strong) NSMutableArray *stockArr;
//记录前一个选中的idx
@property (nonatomic,assign) NSInteger beforeIdx;

@property(nonatomic, strong) NSArray *notionArr;
@property(nonatomic, strong) NSArray *marketArr;

@property(nonatomic, strong) NSArray *rangeArr;
@property(nonatomic, strong) NSArray *riseScaleArr;

@property(nonatomic, strong) id historyObj;

@property (nonatomic,assign) NSInteger type;

@end

@implementation JCLBusinessRankVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [JCLSVProgressHUD showshadowHUD];
    if(self.navigationItem.title.length<14){
        self.navi.middle.title=self.navigationItem.title;
    }else{
    JCLMonkeyView* paomav = [[JCLMonkeyView alloc] initWithFrame:CGRectMake(0, 20, 0.7*JCLWIDTH, 44) title:self.navigationItem.title];
    paomav.centerX=self.view.centerX;
    [self.navi addSubview:paomav];
    }
    
    self.stockArr=[NSMutableArray arrayWithCapacity:0];
    self.dataArr=[NSMutableArray arrayWithCapacity:0];
    self.codeArr=[NSMutableArray arrayWithCapacity:0];
    [self loadInfoType:1];
    
    LHCMenuView *menuView=[LHCMenuView MenuViewTitleArray:@[@"近一月",@"近三月",@"近六月",@"近一年"] SelectLineHeight:3 SelectLineColor:[UIColor redColor] Selectidx:0 Blcok:^(UIButton *btn) {
        self.marketArr=nil;
        self.notionArr=nil;
        /*点击切换数据*/
        [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        [JCLSVProgressHUD showshadowHUD];
        self.type=btn.tag+1;
        [self loadMarketData];
        [self loadHistoryData];
        
        [self loadInfoType:btn.tag+1];
    }];
    menuView.frame=CGRectMake(0, 64, JCLWIDTH, 40);
    [self.view addSubview:menuView];
    
    self.tableView=[LHCObject LHCTable:self.view target:self frame:CGRectMake(0, menuView.maxY, JCLWIDTH, JCLHEIGHT-menuView.maxY) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.showsVerticalScrollIndicator=YES;
    
    self.type=1;
    [self loadMarketData];
    [self loadHistoryData];
    
}


#pragma mark -tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4+_dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0 || section==1 ||section==2 || section==3+_dataArr.count ){
        return 1;
    }
    JCLBunsinessCellModel *model = _dataArr[section-3];
    NSInteger count = model.isOpen?self.codeArr.count:0;
    return count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section==0){
        return [self headerViewForStr:@"营业部买入偏好概念"];
    }if(section==1){
         return [self headerViewForStr:@"营业部买入偏好行业"];
    }else if(section==2){
        return [self headerViewForStr:@"协同营业部"];
    }else if(section==3+_dataArr.count){
         return [self headerViewForStr:@"历史回测"];
    }else{
        if(_dataArr.count){
        JCLBunsinessCellModel *model=_dataArr[section-3];
        return [self headerOpenForStr:model.relate_company_name Idx:section];
        }
        return [UIView new];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
       return  self.notionArr.count? 300 :10;
      
    }else if(indexPath.section==1){
       return  self.marketArr.count?260 :10;
    }
    else if(indexPath.section==2){
        return 0;
    }else if(indexPath.section==3+_dataArr.count){
        return 220;
    }else{
        return [LHCObject height:55];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section ==0  || section ==1 || section ==2 || section==_dataArr.count+3){
        return [LHCObject height:35];
    }
    JCLBunsinessCellModel *model = _dataArr[section-3];
    if(model.isOpen){
        return [LHCObject height:50]+35;
    }
    return [LHCObject height:50];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger idx=3+_dataArr.count;
    if(indexPath.section==idx){
        return [self HistoryCell:tableView];
    }
    
    switch (indexPath.section) {
        case 0:
            return [self NotionCell:tableView];
            break;
            
        case 1:
            return [self MarketCell:tableView];
            break;
         
        default:{
            JCLBillboardTableViewCell *cell=[JCLBillboardTableViewCell CellWithTableView:tableView];
            if(self.stockArr.count){
                id obj=self.stockArr[indexPath.row];
                cell.roseLab.text=[NSString stringWithFormat:@"%.2lf",[obj[2] floatValue]];
                cell.moneyLab.text=[NSString stringWithFormat:@"%.2lf%%",[obj[4] floatValue]];
                
                cell.moneyLab.textColor=[LHCObject Newprice:cell.moneyLab.text Price:@"0.00"];
                cell.stockCodeLab.text=[NSString stringWithFormat:@"%@",obj[1]];;
                cell.stockNameLab.text=[NSString stringWithFormat:@"%@",obj[0]];
            }
            return cell;
        }
            break;
    }}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(indexPath.section ==0  || indexPath.section ==1 || indexPath.section ==2 || indexPath.section==3+_dataArr.count)
    {
       
    }else{
        JCLStockMain *listVC=[[JCLStockMain alloc]init];
        JCLBillboardTableViewCell *cell =(JCLBillboardTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        listVC.arr=@[cell.stockNameLab.text,cell.stockCodeLab.text];
        [self.navigationController pushViewController:listVC animated:YES];
    }
}

//头部视图
- (JCLBusinessRankHeader *)headerViewForStr:(NSString *)str{
    JCLBusinessRankHeader *headerView=[[JCLBusinessRankHeader alloc]init];
    headerView.titleLab.text=str;
    return headerView;
}

- (JCLBusinessOpeneader *)headerOpenForStr:(NSString *)str Idx:(NSInteger)tag{
    
    JCLBusinessOpeneader *headerView=[[JCLBusinessOpeneader alloc]init];
    headerView.textLab.attributedText = [JCLBaseManage RXAttStr:str spac:8];
    headerView.tag=tag;
    JCLBunsinessCellModel *model=_dataArr[tag-3];
    
    if(model.isOpen){
        headerView.bg.hidden=NO;
        [UIView animateWithDuration:0.5 delay:0.5 options: UIViewAnimationOptionAllowUserInteraction |UIViewAnimationOptionCurveLinear animations:^{
            
            CGAffineTransform currentTransform = headerView.img.transform;
            CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, M_PI); // 在现在的基础上旋转指定角度
            headerView.img.transform = newTransform;
        } completion:^(BOOL finished) {
            
        }];
    }else{
        headerView.bg.hidden=YES;
        [UIView animateWithDuration:0.5 delay:0.5 options: UIViewAnimationOptionAllowUserInteraction |UIViewAnimationOptionCurveLinear animations:^{
            
            CGAffineTransform currentTransform = headerView.img.transform;
            CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, 2*M_PI); // 在现在的基础上旋转指定角度
            headerView.img.transform = newTransform;
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
    [headerView addTarget:self action:@selector(openCellHeaderAction:) forControlEvents:UIControlEventTouchDown];
    return headerView;
}

- (void)openCellHeaderAction:(UIButton *)sender{
    [self.codeArr removeAllObjects];
    
    JCLBunsinessCellModel *model = _dataArr[sender.tag-3];
    model.isOpen = !model.isOpen;
    
    if(self.beforeIdx!=0 && self.beforeIdx!=sender.tag){
        JCLBunsinessCellModel *model2 = _dataArr[self.beforeIdx-3];
        model2.isOpen = NO;
    }
    
    NSArray *array = [model.relate_symbols componentsSeparatedByString:@","];
    for(NSInteger i =0;i<array.count;i++){
        NSString *str=[NSString stringWithFormat:@"%@",array[i]];
        NSString *code = [str substringToIndex:6];
        NSString *setCode= [str substringFromIndex:7];
        NSString *newCode=[NSString stringWithFormat:@"%@%@",setCode,code];
        [self.codeArr addObject:newCode];
    }
    
    self.beforeIdx=sender.tag;
    [self loadStockData];
}
//取协同营业部
- (void)loadInfoType:(NSInteger)type{
    
    [self.dataArr removeAllObjects];
    NSString *url=[NSString stringWithFormat:@"%@PageDeptCompanyThemesServlet?companyid=%@&type=%zd",LHBURL,self.company_id,type];
    [JCLHttps getJson:url success:^(id obj) {
    /*一个取证 一个取负*/
        self.dataArr = [JCLBunsinessCellModel mj_objectArrayWithKeyValuesArray:obj[@"pcompanies"]];
        
        NSMutableArray *pcompaniesArr=[JCLBunsinessCellModel mj_objectArrayWithKeyValuesArray:obj[@"ncompanies"]];
        
        [self.dataArr addObjectsFromArray:pcompaniesArr];
        
        [JCLSVProgressHUD dimissHUD];
        dispatch_async(dispatch_get_main_queue(), ^(){
            [_tableView reloadData];
        });
    } failure:^(NSError *error) {
       
    }];
}

/*取行情数据*/
- (void)loadStockData
{
     [JCLMarketDataObj JCLGetMarketInfos:JCLMarketURL code:self.codeArr success:^(NSArray *obj) {
        if(obj){
        NSArray *arr = [JCLHttpsObj JCLHandleStr:obj begin:2 end:obj.count - 3];
        __block NSMutableArray *arrM = [[NSMutableArray alloc]init];
        __block NSInteger index = 0;
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx % 2 != 0) {
                NSString *price = [NSString stringWithFormat:@"%.2lf", [obj[4] floatValue]];
                NSString *close = obj[1];
                NSString *range = [JCLMarketObj JCLMarketRange:price close:close];
                NSString *scale = [JCLMarketObj JCLMarketScale:range close:close];
                NSArray *info = [JCLMarketObj JCLStockInfo:self.codeArr[index]];
                if(info.count){
                [arrM addObject:@[info[3], [NSString stringWithFormat:@"%@%@", info[1], info[2]], price, range, scale]];
                }
                index++;
            }
        }];
        self.stockArr = arrM;
        dispatch_async(dispatch_get_main_queue(), ^(){
            [_tableView reloadData];
        });
        [JCLSVProgressHUD dimissHUD];
        }
    } failure:^(NSError *error) {
       
    }];
}
//加载营业部买入偏好概念数据
-(void)loadMarketData{
    NSString *url = [NSString stringWithFormat:@"%@/data_lhb/servlet/PageDeptCompanyThemesServlet?companyid=%@&type=%zd", lhurl, self.company_id,self.type];
    [JCLHttpsObj JCLGetJson:url success:^(id obj) {
        if (obj) {
            self.notionArr = [JCLStockRankModel mj_objectArrayWithKeyValuesArray:obj[@"themes"]];
            self.marketArr = [JCLStockRankModel mj_objectArrayWithKeyValuesArray:obj[@"industries"]];
            dispatch_async(dispatch_get_main_queue(), ^(){
                [_tableView reloadData];
            });
        }
    } failure:^(NSError *error) { }];
}

//加载历史回测数据
-(void)loadHistoryData{
    NSString *url = [NSString stringWithFormat:@"%@/data_lhb/servlet/PageDeptCompanyDataServlet?companyid=%@&type=%zd", lhurl, self.company_id,self.type];
    [JCLHttpsObj JCLGetJson:url success:^(id obj) {
        if (obj) {
            self.historyObj = obj;
            dispatch_async(dispatch_get_main_queue(), ^(){
                [_tableView reloadData];
            });
        }
    } failure:^(NSError *error) {
        [JCLSVProgressHUD showErrorHud:@"请求超时!"];
    }];
}

//买入偏好概念
-(UITableViewCell *)NotionCell:(UITableView *)table{
    JCLStockRankNotionCell *cell = [JCLStockRankNotionCell cellWithTable:table style:UITableViewCellStyleDefault];
    if (self.notionArr.count) {
        cell.arr = self.notionArr;
        cell.hidden = NO;
        //self.notionArr = nil;
    }else{
        cell.hidden = YES;
    }
    cell.tapAction = ^(NSArray *arr){
        JCLStockMain *list = [[JCLStockMain alloc]init]; list.arr = arr;
        [self.navigationController pushViewController:list animated:YES];
    };
    return cell;
}

//买入偏好行业
-(UITableViewCell *)MarketCell:(UITableView *)table{
    JCLStockRankMarketCell *cell = [JCLStockRankMarketCell cellWithTable:table style:UITableViewCellStyleDefault];
    if (self.marketArr.count) {
        cell.hidden=NO;
        cell.arr = self.marketArr;
//        self.marketArr = nil;
    }else{
        cell.hidden=YES;
    }
    return cell;
}

//历史回测
-(UITableViewCell *)HistoryCell:(UITableView *)table{
    JCLStockRankHistoryCell *cell = [JCLStockRankHistoryCell cellWithTable:table style:UITableViewCellStyleDefault];
    id obj = self.historyObj;
    if (obj) {
        NSString *val = obj[@"times_buy"];
        NSString *info = [NSString stringWithFormat:@"上榜次数: %@次", val];
        if([val integerValue]!=0.00){
            cell.info.attributedText = [JCLKitObj RXAttStr:info color:JCLRGB(242, 72, 85) endIdx:val.length+1];
            cell.rangeArr = @[obj[@"changepercent_1day_avg"], obj[@"changepercent_3day_avg"], obj[@"changepercent_5day_avg"],
                              obj[@"changepercent_10day_avg"]];;
            cell.scaleArr = @[obj[@"probability_rise_1day"], obj[@"probability_rise_3day"], obj[@"probability_rise_5day"],
                              obj[@"probability_rise_10day"]];
            self.historyObj = nil;
        } else {
            if (!cell.scaleArr.count) {
                NSString *info = [NSString stringWithFormat:@"上榜次数: %@次", @"0"];
                cell.info.attributedText = [JCLKitObj RXAttStr:info color:JCLRGB(242, 72, 85) endIdx:2];
                cell.rangeArr = @[@"--", @"--", @"--", @"--"];
                cell.scaleArr = @[@"--", @"--", @"--", @"--"];
            }
        }
    }
    return cell;
}
@end
