//
//  JCLHotspotVC.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/24.
//  Copyright © 2017年 刘虎超. All rights reserved.
//

#import "JCLHotspotVC.h"
#import "JCLHotspotCell.h"
#import "MJRefresh.h"
#import "WKWebViewJavascriptBridge.h"
#import "CHDDropDownMenu.h"
#import "JCLPlateDetailVC.h"
#import "JCLMarketInfoList.h"
#import "JCLHeaderBgView.h"
#import "LHCMenuView.h"

@interface JCLHotspotVC ()<UITableViewDelegate,UITableViewDataSource,WKUIDelegate,chdMenuDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    NSInteger start;
    WKWebView *_webView;
    JCLHeaderBgView *_bgView;
    CHDDropDownMenu *_dropmenu;
}
@property WKWebViewJavascriptBridge* bridge;
@property (nonatomic,strong) LHCMenuView *menuView;
@property (nonatomic,strong) NSArray *fallArr;
//字典数组
@property (nonatomic,strong) NSMutableArray *dictArr;

@property (nonatomic,strong) NSString *MainType;
@property (nonatomic,strong) NSString *industryStr;
@property (nonatomic,strong) NSString *numStr;
@property (nonatomic,strong) NSString *dayStr;
//流入
@property (nonatomic,strong) NSArray *lrArr;
//流出
@property (nonatomic,strong) NSArray *lcArr;
@property (nonatomic,assign) NSInteger selectRow;

@property (nonatomic,strong) NSString *sort;
@end

@implementation JCLHotspotVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [JCLSVProgressHUD showshadowHUD];
    self.dictArr=[NSMutableArray arrayWithCapacity:0];
    //刚开始进来默认是全部板块
    self.type=WholeType;
    _bgView=[[JCLHeaderBgView alloc]initWithFrame:CGRectMake(0,64+40 , JCLWIDTH, 30)];
    _bgView.titleArr=@[@"名称",@"涨跌幅",@"涨跌分布",@"领涨个股"];
    [self.view addSubview:_bgView];
    //tableView;
    [self initTable];
    [self drawWeb];
    [self drawOtherView];
#pragma marl 获取板块信息数据
    //主力净流入
    self.lrArr=@[[NSString stringWithFormat:@"%zd",JCL_Market_ZLJLR],[NSString stringWithFormat:@"%zd",JCL_Market_ZLJLR3],[NSString stringWithFormat:@"%zd",JCL_Market_ZLJLR5]];
    //主力净流出
        self.lcArr=@[[NSString stringWithFormat:@"%zd",JCL_Market_ZLJLR],[NSString stringWithFormat:@"%zd",JCL_Market_ZLJLR3],[NSString stringWithFormat:@"%zd",JCL_Market_ZLJLR5]];
    
//    self.lcArr=@[[NSString stringWithFormat:@"%zd",JCL_Market_ZLJLC],[NSString stringWithFormat:@"%zd",JCL_Market_ZLJLC3],[NSString stringWithFormat:@"%zd",JCL_Market_ZLJLC5]];
    self.MainType=[NSString stringWithFormat:@"%zd",JCL_Market_ZLJLR] ;
    self.industryStr=[NSString stringWithFormat:@"%zd",JCL_Market_Main_Idea];
    self.numStr=@"10";
    self.dayStr=@"今日";
    self.selectRow=0;
    self.sort = @"1";
    [self timeType:self.MainType MainType:self.MainType IndustryStr:self.industryStr RankStr:self.numStr];

}
//资金地图的web
- (void)drawWeb{
    _webView=[[WKWebView alloc]init];
    _webView.frame=CGRectMake(0, 64+40, JCLWIDTH, JCLSCROLL-40);
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"index.html"] withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    _webView.hidden=YES;
    _webView.scrollView.scrollEnabled=NO;
    _webView.UIDelegate=self;
    //下面是用于交互的测试
    [WKWebViewJavascriptBridge enableLogging];// 开启日志
    _bridge = [WKWebViewJavascriptBridge bridgeForWebView:_webView];
    [_bridge setWebViewDelegate:self];
    //禁止一些手势
    NSMutableString *javascript = [NSMutableString string];
    [javascript appendString:@"document.documentElement.style.webkitUserSelect='none';"];//禁止选择
    [javascript appendString:@"document.documentElement.style.webkitTouchCallout='none';"];//禁止长按
    WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:javascript
                                                            injectionTime:WKUserScriptInjectionTimeAtDocumentEnd
                                                         forMainFrameOnly:YES];
    
    WKUserContentController*userContentController = [[WKUserContentController alloc] init];
    [userContentController addUserScript:noneSelectScript];
    WKWebViewConfiguration*configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;
    //控件加载
    [_webView.configuration.userContentController addUserScript:noneSelectScript];
}

- (void)initTable{
    _tableView = [LHCObject LHCTable:self.view target:self frame:CGRectMake(0, _bgView.maxY, JCLWIDTH, JCLHEIGHT-_bgView.maxY) style:UITableViewStylePlain];
    _tableView.rowHeight=[LHCObject height:55];
    _tableView.showsVerticalScrollIndicator=YES;
    
    
    [_tableView JCLFooterGifBlock:^{
        //下拉刷新num加上30条
        if(_dataArr.count<30){
            [_tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        start+=30;
        [self dataStart:start];
    }];
    
    [_tableView JCLHeaderGifBlock:^{
        if(start==0){
            [_tableView.mj_header endRefreshing];
            return ;
        }
        start-=30;
        [self dataStart:start];
    }];
    
    //第一次进来 start默认为0
    start=0;
    [JCLSVProgressHUD showHUD];
    [self dataStart:start];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate.shareAppDelegate.timerAtionBlock = ^() {
        [self timerRelodata];
    };
}

//分段选择器 menuView 下拉框
- (void)drawOtherView
{
    UISegmentedControl *segmnet=[[UISegmentedControl alloc]initWithItems:@[@"热点追踪",@"资金地图"]];
    segmnet.selectedSegmentIndex=0;
    [segmnet addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    segmnet.size=CGSizeMake(0.5*JCLWIDTH, 30);
    segmnet.centerX=self.view.centerX;
    segmnet.y=25;
    [self.navi addSubview:segmnet];
    
    LHCMenuView *menuView=[LHCMenuView MenuViewTitleArray:@[@"全部",@"行业",@"地区",@"概念"] SelectLineHeight:2.8 SelectLineColor:[UIColor redColor] Selectidx:0 Blcok:^(UIButton *btn) {
        //menuView点击回调事件
        //更改模块 num改为30 并且滚动到最顶部
        self.type=btn.tag;
        [JCLSVProgressHUD showHUD];
        start=0;
        [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        [self dataStart:0];
    }];
    menuView.backgroundColor=[UIColor whiteColor];
    menuView.frame=CGRectMake(0, 64, JCLWIDTH, 40);
    [self.view addSubview:menuView];
    self.menuView=menuView;
    
    NSArray *array=@[@"今日",@"主力净流入",@"概念",@"前30"];
    NSMutableArray *ShowArr = [NSMutableArray array];
    for (int i =0; i<array.count; i++) {
        NSMutableArray *temp = [NSMutableArray array];
        chdModel *model = [[chdModel alloc] init];
        model.text = [NSString stringWithFormat:@"%@",array[i]];
        [temp addObject:model];
        [ShowArr addObject:temp];
    }
    
    NSArray *array2=@[@[@"今日",@"3日",@"5日"],@[@"主力净流入",@"主力净流出"],@[@"概念",@"地区",@"行业"],@[@"前10",@"前20",@"前30"]];
    //列表展示的模型
    NSMutableArray *arr = [NSMutableArray array];
    for (int i =0; i<array2.count; i++) {
        NSMutableArray *temp = [NSMutableArray array];;
        NSArray *arr2=array2[i];
        for (int j =0; j<arr2.count;j++) {
            chdModel *model = [[chdModel alloc] init];
            model.text = [NSString stringWithFormat:@"%@",arr2[j]];
            [temp addObject:model];
        }
        [arr addObject:temp];
    }
    _dropmenu=[[CHDDropDownMenu alloc]init];
    [_dropmenu initWithFrame:CGRectMake(0, 64, JCLWIDTH, 40) showOnView:self.view AllDataArr:arr showArr:ShowArr];
    _dropmenu.delegate=self;
    _dropmenu.hidden=YES;
}


#pragma  mark -tableView的代理和数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count-1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JCLHotspotCell *cell=[JCLHotspotCell CellWithTableView:tableView];
    if(_dataArr.count)
    {
        cell.array=_dataArr[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    JCLMarketInfoList *vc = [[JCLMarketInfoList alloc]init]; vc.isPlate = YES;
    if(self.type==0){
        
        NSString *code=[NSString stringWithFormat:@"%@",_dataArr[indexPath.row][1]];
        code =[code substringWithRange:NSMakeRange(2, 3)];
        if([code isEqualToString:@"880"]){
             vc.plateType=PlateOfIndustry;
        }else if([code isEqualToString:@"881"])
        {
            vc.plateType=PlateOfRegion;
        }else{
            vc.plateType=PlateOfConcept;
        }
        
    }else if(self.type==1){
        vc.plateType=PlateOfIndustry; //行业
    }else if(self.type==2){
        vc.plateType=PlateOfRegion;  //地区
    }else{
        vc.plateType=PlateOfConcept; //概念
    }
    
    vc.array = _dataArr[indexPath.row];
    vc.isCapital = NO;
    [self.navigationController pushViewController:vc animated:YES];
}

/**@param num 条数*/
- (void)dataStart:(NSInteger)num
{
    NSInteger type;
    //匹配当前是属于什么模块分别是全部、行业、地区、概念
    switch (self.type) {
        case WholeType:
            type=30;
            break;
        case IndustryType:
            type=32;
            break;
        case RegionType:
            type=31;
            break;
        default:
            type=33;
            break;
    }
    if(num<30){num=0;}
    NSString *url=[NSString stringWithFormat:@"%@/FreeSortWebServer/domainsorthq?start=%zd&num=30&setdomain=%zd&coltype=14&sortid=1*0*6*3*2*4*5*205*157*158*159&subsortid=1*0*6*3*2*4*5*205&sorttype=1=30&synid=10012&r=748555",JCLMarketURL,num,type];
    //热点追踪
    [JCLHttps getString:url success:^(NSArray *obj) {
        _dataArr = [JCLHttps splitArrayM:obj begin:1 end:obj.count - 1];
        [_tableView reloadData];
        [JCLSVProgressHUD dimissHUD];
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
    }failure:^(NSError *error) {
        
    }];
}

//定时器
- (void)timerRelodata{
    [self dataStart:start];
    [self timeType:self.MainType MainType:self.MainType IndustryStr:self.industryStr RankStr:self.numStr];
}

//监听分段器的点击
- (void)segmentChange:(UISegmentedControl *)segment
{
    _tableView.hidden    = YES;
    _webView.hidden      = YES;
    self.menuView.hidden = YES;
    _bgView.hidden       = YES;
    _dropmenu.hidden     = YES;
    if(segment.selectedSegmentIndex==0)
    {
        _tableView.hidden    = NO;
        _bgView.hidden       = NO;
        self.menuView.hidden = NO;
    }else{
        _webView.hidden      = NO;
        _dropmenu.hidden     = NO;
    }
}

#pragma mark --下拉框的点击方法
- (void)selectColum:(NSInteger)colum Row:(NSInteger)row Model:(chdModel*)model;
{
    [JCLSVProgressHUD showHUD];
    
    if(colum==0){
        NSArray *arr=@[@"今日",@"3日",@"5日"];
        self.dayStr=arr[row];
        self.selectRow=row;
        if([self.MainType isEqualToString:[NSString stringWithFormat:@"%zd",JCL_Market_ZLJLR]] ||  [self.MainType isEqualToString:[NSString stringWithFormat:@"%zd",JCL_Market_ZLJLR3]] || [self.MainType isEqualToString:[NSString stringWithFormat:@"%zd",JCL_Market_ZLJLR5]])
        {
            self.MainType=self.lrArr[row];
        }else{
            self.MainType=self.lcArr[row];
        }}
    
    if(colum==1)
    {
        if(row==0)
        {
            self.sort = @"1";
            self.MainType=self.lrArr[self.selectRow];
        }else{
            self.sort = @"2";
            self.MainType=self.lcArr[self.selectRow];
        }
    }
    //排名
    if(colum==3){
        if(row==0)
        {
            self.numStr=@"10";
        }else if(row==1){
            self.numStr=@"20";
        }else {
            self.numStr=@"30";
        }
    }
    //地域 行业
    if(colum==2)
    {
        if(row==1){
            self.industryStr=[NSString stringWithFormat:@"%zd",JCL_Market_Main_Region];
        }else if(row==2){
            self.industryStr=[NSString stringWithFormat:@"%zd",JCL_Market_Main_Industry];
        }else{
             self.industryStr=[NSString stringWithFormat:@"%zd",JCL_Market_Main_Idea];
        }
    }
    [JCLSVProgressHUD showHUD];
    [self timeType:self.MainType MainType:self.MainType IndustryStr:self.industryStr RankStr:self.numStr];
}

//typeStr 时间  mainType是主力   Industry是板块 31地域  32行业  RankStr是排名
- (void)timeType:(NSString *)typeStr MainType:(NSString *)mainStr IndustryStr:(NSString *)industryStr  RankStr:(NSString *)rankStr{
    [self.dictArr removeAllObjects];
    [JCLMarketDataObj JCLGetMarketSortInfo:JCLMarketURL page:0
                                       number:[rankStr intValue]
                                     mainType:industryStr
                                     sortType:mainStr
                                      info:[NSString stringWithFormat:@"1*0*6*3*2*4*5*36*10*%@",mainStr]
                                         sort:self.sort
                                      success:^(NSArray *obj) {
                                          self.fallArr = [JCLHttpsObj JCLHandleStr:obj begin:1 end:obj.count - 2];
                                          
                                        for (NSInteger i=0;i<self.fallArr.count;i++)
                                          {
                                            NSMutableDictionary *dict=[NSMutableDictionary dictionary];

                                            id objc=self.fallArr[i];
                                              if([objc[2] intValue]!=0 && [objc[4] intValue]!=0)
                                              {
                                                  dict[@"name"]=objc[0];
                                                  dict[@"symbol"]=objc[1];
                                                  dict[@"num"]=[NSString stringWithFormat:@"%@",objc[9]];
                                                  NSString *zdf=[NSString stringWithFormat:@"%@",[JCLMarketObj JCLMarketRange:objc[2] close:objc[4]]];
                                                  NSString *zdf1=[NSString stringWithFormat:@"%@",[JCLMarketObj JCLMarketScale:zdf close:objc[4]]];
                                                  dict[@"zdf"]=[NSString stringWithFormat:@"%.2lf",[zdf1 floatValue]];
                                                  [self.dictArr addObject:dict];
                                              }
                                          }
                                          NSMutableDictionary *dict2=[NSMutableDictionary dictionary];
                                          dict2[@"list"]=self.dictArr;
                                          
                                          NSString *jsonStr=[self dictionaryToJson:dict2];
                                          [_bridge callHandler:@"showAlert" data:jsonStr responseCallback:^(id responseData) {
                                          }];
                                          [JCLSVProgressHUD dimissHUD];
                                      }failure:^(NSError *error) {
                                          
                                      }];
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    JCLPlateDetailVC *vc=[[JCLPlateDetailVC alloc]init];
    vc.codeStr=message;
    vc.sortType=self.industryStr;
    [self.navigationController pushViewController:vc animated:YES];
    completionHandler();
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
@end
