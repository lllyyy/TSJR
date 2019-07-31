
#import "BAWebpController.h"
#import <WebKit/WebKit.h>
 

@interface BAWebpController ()
@property (nonatomic,strong)WKWebView *wkWebview;
  @property (nonatomic, strong) UIProgressView * progressView;
@end

@implementation BAWebpController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self loadData];
    [self setupUI];
    
}

 
-(void)loadData{
    //    新闻列表
    [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlE,@"newsDetail"];
    [JCLHttps httpPOSTRequest:postUrl params:@{@"newsid":self.did} success:^(id obj) {
        NSLog(@"objobj %@",obj);
        MMResultModel *model =(MMResultModel *)obj;
        if (model.code.intValue == 200&&model.data.count > 0) {
           
//            self.conten = model.data[0][@"content"];
            self.navi.middle.title =  model.data[0][@"title"];
 
            [self.wkWebview loadHTMLString:[self htmlBody:model.data[0][@"content"] title:model.data[0][@"title"]]
                                   baseURL:nil];
        }
         [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
        [JCLFramework showErrorHud:@"服务器异常"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
- (void)setupUI
{
    self.wkWebview.hidden = NO;
    
    [self.view setBackgroundColor:JCL_Cell_COL];
    [self ba_registerURLProtocol];
    [self.view addSubview:self.wkWebview];
   [self.view addSubview:self.progressView];
    
    //添加监测网页加载进度的观察者
    [self.wkWebview addObserver:self
                   forKeyPath:NSStringFromSelector(@selector(estimatedProgress))
                      options:0
                      context:nil];
    [self.wkWebview addObserver:self
                   forKeyPath:@"title"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    
}
//kvo 监听进度 必须实现此方法
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context{
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
        && object == self.wkWebview) {
        
        NSLog(@"网页加载进度 = %f",self.wkWebview.estimatedProgress);
        self.progressView.progress = self.wkWebview.estimatedProgress;
        if (self.wkWebview.estimatedProgress >= 1.0f) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.progress = 0;
            });
        }
        
    }else if([keyPath isEqualToString:@"title"]
             && object == self.wkWebview){
        self.navigationItem.title = self.wkWebview.title;
    }else{
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}
- (NSString*)htmlBody:(NSString *)str title:(NSString *)title
{
    
    NSURL *templateURL = [[NSBundle mainBundle] URLForResource:@"news_template" withExtension:@"html"];
    
    
    NSError *error = nil;
    NSMutableString *templateString = [NSMutableString stringWithContentsOfURL:templateURL encoding:NSUTF8StringEncoding error:&error];
    NSAssert(templateString, @"failed to load News story HTML template");
    
    __block NSDictionary *templateBindings = nil;
    
    
    
    
    templateBindings = @{@"__TITLE__": title,
                         
                         @"__BODY__":  str,
                         
                         };
    
    
    
    
    [templateBindings enumerateKeysAndObjectsUsingBlock:^(NSString *placeholder, id value, BOOL *stop) {
        if ([value isKindOfClass:[NSString class]]) {
            [templateString replaceOccurrencesOfString:placeholder
                                            withString:(NSString*)value
                                               options:0
                                                 range:NSMakeRange(0, [templateString length])];
        } else if ([value respondsToSelector:@selector(stringValue)]) {
            [templateString replaceOccurrencesOfString:placeholder
                                            withString:[value stringValue]
                                               options:0
                                                 range:NSMakeRange(0, [templateString length])];
        } else if ([value isKindOfClass:[NSNull class]]) {
            [templateString replaceOccurrencesOfString:placeholder
                                            withString:@""
                                               options:0
                                                 range:NSMakeRange(0, [templateString length])];
        }
    }];
    
    return templateString;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.wkWebview.frame = CGRectMake(0, JCLNAVI, JCLWIDTH, JCLSCROLL);
}

#pragma mark - 注册自定义 NSURLProtocol
- (void)ba_registerURLProtocol
{
    [NSURLProtocol registerClass:NSClassFromString(@"BAURLSessionProtocol")];
    // 注册registerScheme使得WKWebView支持NSURLProtocol
    [NSURLProtocol ba_web_registerScheme:@"http"];
    [NSURLProtocol ba_web_registerScheme:@"https"];
}

- (void)dealloc
{
    [NSURLProtocol unregisterClass:NSClassFromString(@"BAURLSessionProtocol")];
    // 移除 registerScheme
    [NSURLProtocol ba_web_unregisterScheme:@"http"];
    [NSURLProtocol ba_web_unregisterScheme:@"https"];
}

- (WKWebView *)wkWebview
{
    if (!_wkWebview)
    {
        _wkWebview = [[WKWebView alloc]init];
         [_wkWebview setBackgroundColor:JCL_Cell_COL];
    }
    return _wkWebview;
}
- (UIProgressView *)progressView
{
    if (!_progressView){
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, JCLNAVI + 1, self.view.frame.size.width, 2)];
        _progressView.tintColor = [UIColor blueColor];
        _progressView.trackTintColor = [UIColor clearColor];
    }
    return _progressView;
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self.progressView setProgress:0.0f animated:NO];
}
@end
