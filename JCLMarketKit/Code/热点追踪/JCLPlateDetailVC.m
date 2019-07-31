//
//  JCLPlateDetailVC.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/4/1.
//  Copyright © 2017年 刘虎超. All rights reserved.
//

#import "JCLPlateDetailVC.h"
#import "CHDDropDownMenu.h"
#import <WebKit/WebKit.h>
#import "WKWebViewJavascriptBridge.h"
#import "JCLStockMain.h"
@interface JCLPlateDetailVC ()<chdMenuDelegate,WKUIDelegate>
{
     CHDDropDownMenu *_dropmenu;
     WKWebView *_webView;
}
@property WKWebViewJavascriptBridge* bridge;
@property (nonatomic,strong) NSString *timeType;
@property (nonatomic,strong) NSString *mainType;
@property (nonatomic,strong) NSString *numberType;
//字典数组
@property (nonatomic,strong) NSMutableArray *dictArr;
//流入
@property (nonatomic,strong) NSArray *lrArr;
//流出
@property (nonatomic,strong) NSArray *lcArr;
@property (nonatomic,assign) NSInteger selectRow;

@property (nonatomic,strong) NSArray *fallArr;

@property (nonatomic,strong) NSString *sort;
@end

@implementation JCLPlateDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [JCLSVProgressHUD showshadowHUD];
    
    self.dictArr=[NSMutableArray arrayWithCapacity:0];
    NSString *nameStr=[JCLMarketObj JCLStockInfo:self.codeStr][3];
    self.navi.middle.title=nameStr;
    [self drawWeb];
    [self drawMenu];
    
#pragma marl 获取板块信息数据
    //主力净流入
    self.lrArr=@[[NSString stringWithFormat:@"%zd",JCL_Market_ZLJLR],[NSString stringWithFormat:@"%zd",JCL_Market_ZLJLR3],[NSString stringWithFormat:@"%zd",JCL_Market_ZLJLR5]];
    //主力净流出
    self.lcArr=@[[NSString stringWithFormat:@"%zd",JCL_Market_ZLJLC],[NSString stringWithFormat:@"%zd",JCL_Market_ZLJLC3],[NSString stringWithFormat:@"%zd",JCL_Market_ZLJLC5]];
    self.timeType=[NSString stringWithFormat:@"%zd",JCL_Market_ZLJLR];
    self.mainType=[NSString stringWithFormat:@"%zd",JCL_Market_ZLJLR] ;
    self.numberType=@"10";
    self.selectRow=0;
    self.sort = @"1";
    [self stockDataTimeType:self.timeType MainType:self.mainType Number:self.numberType];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate.shareAppDelegate.timerAtionBlock = ^() {
        [self timerRelodata];
    };
}

/**定时刷新*/
- (void)timerRelodata{
       NSLog(@"秒数%zd===",[LHCObject second]);
     [self stockDataTimeType:self.timeType MainType:self.mainType Number:self.numberType];
}

/**绘制头部*/
- (void)drawMenu{
    NSArray *array=@[@"今日",@"主力净流入",@"前30"];
    NSMutableArray *ShowArr = [NSMutableArray array];
    for (int i =0; i<array.count; i++) {
        NSMutableArray *temp = [NSMutableArray array];
        chdModel *model = [[chdModel alloc] init];
        model.text = [NSString stringWithFormat:@"%@",array[i]];
        [temp addObject:model];
        [ShowArr addObject:temp];
    }
    
    NSArray *array2=@[@[@"今日",@"3日",@"5日"],@[@"主力净流入",@"主力净流出"],@[@"前10",@"前20",@"前30"]];
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
    _dropmenu.isStock=YES;
    [_dropmenu initWithFrame:CGRectMake(0, 64, JCLWIDTH, 40) showOnView:self.view AllDataArr:arr showArr:ShowArr];
    _dropmenu.delegate=self;
    
}

- (void)drawWeb{
    _webView=[[WKWebView alloc]init];
    _webView.frame=CGRectMake(0, 104, JCLWIDTH, JCLSCROLL-40);
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"index.html"] withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    _webView.scrollView.scrollEnabled=NO;
    _webView.UIDelegate=self;
    //下面是用于交互的测试
    [WKWebViewJavascriptBridge enableLogging];// 开启日志
    _bridge = [WKWebViewJavascriptBridge bridgeForWebView:_webView];
    [_bridge setWebViewDelegate:self];
    
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

- (void)stockDataTimeType:(NSString *)timeype MainType:(NSString *)maintype Number:(NSString *)number{
    [self.dictArr removeAllObjects];
    NSString  *type;
    if([self.sortType isEqualToString:@"31"])
    {
       type=@"100";
    }else if([self.sortType isEqualToString:@"32"]){
        type=@"200";
    }else{
        type=@"300";
    }
        
    [JCLMarketDataObj JCLGetMarketSortInfo:JCLMarketURL page:0
                                    number:[number integerValue]
                                  mainType:type
                                  sortType:maintype
                                      info:[NSString stringWithFormat:@"1*0*6*3*2*4*5*36*10*%@",maintype]
                                      sort:self.sort
                                      code:self.codeStr
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
                                           }}
                                       NSMutableDictionary *dict2=[NSMutableDictionary dictionary];
                                       dict2[@"list"]=self.dictArr;
                                       NSString *jsonStr=[self dictionaryToJson:dict2];
                                       [_bridge callHandler:@"showAlert" data:jsonStr responseCallback:^(id responseData) {

                                       }];
                                       [JCLSVProgressHUD dimissHUD];

                                   } failure:^(NSError *error) {
                                      // [JCLSVProgressHUD showErrorHud:@"请求超时!"];
                                   }];
}

/*下拉框选择代理方法*/
- (void)selectColum:(NSInteger)colum Row:(NSInteger)row Model:(chdModel*)model{
    [JCLSVProgressHUD showHUD];
    if(colum==2)
    {
        if(row==0)
        {
            self.numberType=@"10";
        }else if(row==1){
             self.numberType=@"20";
        }else {
            self.numberType=@"30";
        }
    }
    if(colum==0){
        self.selectRow=row;
        if([self.mainType isEqualToString:[NSString stringWithFormat:@"%zd",JCL_Market_ZLJLR]] ||  [self.mainType isEqualToString:[NSString stringWithFormat:@"%zd",JCL_Market_ZLJLR3]] || [self.mainType isEqualToString:[NSString stringWithFormat:@"%zd",JCL_Market_ZLJLR5]])
        {
            self.mainType=self.lrArr[row];
        }else{
            self.mainType=self.lcArr[row];
        }}
    
    if(colum==1)
        
    {
        if(row==0)
        {
            self.sort = @"1";
            self.mainType=self.lrArr[self.selectRow];
        }else{
            self.sort = @"2";
            self.mainType=self.lcArr[self.selectRow];
        }
    }
    NSLog(@"流入或者留出%@",self.timeType);
     [self stockDataTimeType:self.mainType MainType:self.mainType Number:self.numberType];
}


- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"%@+==",message);
    JCLStockMain*listVC=[[JCLStockMain alloc]init];
    NSMutableArray *arr=[NSMutableArray arrayWithCapacity:0];
    [arr addObject:[JCLMarketObj JCLStockInfo:message][4]];
    [arr addObject:message];
    listVC.arr=arr;
    [self.navigationController pushViewController:listVC animated:YES];
    completionHandler();
}

@end
