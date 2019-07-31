//
//  StockController.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/11/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "JCLStockList.h"
#import "JCLStockHeader.h"
#import "JCLStockHead.h"
#import "TSJRTradingPopuView.h"
#import "JCLStockSubmit.h"
#import "JCLStockIdxCell.h"
#import "JCLStockIdxDetails.h"
#import "LewPopupViewController.h"
#import "TSJRBuyingSellingVC.h"
#import "ShareView.h"
#import "TSJRRealTimeMarket.h"
#import "MMResultModel.h"
#define JCLIdxNames @[@"道琼斯", @"纳斯达克", @"标普500"]

@interface JCLStockList ()
@property (nonatomic, weak) JCLStockHeader *header;
@property (nonatomic, strong) NSArray *headerArr;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *valueA;
@property (nonatomic, weak) JCLStockSubmit *submit;
@property (nonatomic, strong) JCLStockIdxDetails *idx;
@property (nonatomic, strong) TSJRRealTimeMarket *mstockM;
@property (nonatomic, assign) NSInteger idxIdx;
@property (nonatomic, weak) UIView *popBg;
@property (nonatomic, assign) BOOL isPop;

@property (nonatomic, assign) BOOL isCode;
@property (nonatomic, strong) NSString *decimal;
@property (nonatomic, assign) BOOL isRefresh;
@end

@implementation JCLStockList
-(void)viewDidLoad{
    [super viewDidLoad];
    
//    NSArray *obj = [JCLMarketObj JCLStockInfo: self.arr[1]];
//    NSArray *arr = self.arr;
    self.mstockM = (TSJRRealTimeMarket *)self.arr;
    
    if ([self.mstockM.symbol isEqualToString:@".DJI"]) {
       self.navi.middle.title = [NSString stringWithFormat:@"%@(%@)",@"道琼斯",self.mstockM.symbol] ;
    }else if ([self.mstockM.symbol isEqualToString:@".IXIC"]){
       self.navi.middle.title = [NSString stringWithFormat:@"%@(%@)",@"纳斯达克",self.mstockM.symbol];
    }else if ([self.mstockM.symbol isEqualToString:@".INX"]){
        self.navi.middle.title =[NSString stringWithFormat:@"%@(%@)",@"标普指数",self.mstockM.symbol];
    }else{
        NSLog(@"self.mstockM %@",self.mstockM.cn_name);
        self.navi.middle.title = [NSString stringWithFormat:@"%@(%@)",self.mstockM.cn_name.length > 0 ?self.mstockM.cn_name:self.mstockM.name,self.mstockM.symbol]; //[NSString stringWithFormat:@"%@",[[AppDelegate shareAppDelegate].messageNoticeStore fetchMessage:self.mstockM.symbol]];
    }
    
    self.code = self.mstockM.symbol;
//    self.navi.middle.title = arr[0];
    self.navi.subMiddle.title =  @" " ;
    self.decimal = [JCLMarketObj JCLStockInfo:self.code][4];
    
    //按钮
   [self InitSubmit];
    //弹出K线小窗口
    [self InitIdx];
    // K线图
   [self InitTable];
   [self timeAction];
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{ [self loadInfo]; }];
 
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if (self.isReload) {
         self.header.isKline = YES;
    }
 
    self.isRefresh = NO;
    AppDelegate.shareAppDelegate.timerAtionBlock = ^() {
        self.isRefresh ? : [self timeAction];
    };
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self.header name:KLineLongNot object:nil];
}

-(void)InitTable{
    self.table.height = self.idx.y-JCLNAVI;
    JCLStockHeader *header = [[JCLStockHeader alloc]init];
    header.height = self.table.height;
    self.table.tableHeaderView = header; self.header = header;

    NSNotificationCenter *not = [NSNotificationCenter defaultCenter];
    [not addObserver:self selector:@selector(gestureNot:) name:KLineGestureNot object:nil];
}

-(void)gestureNot:(NSNotification*)sender{ self.isRefresh = [[sender.userInfo objectForKey:@"isHave"] boolValue] ? YES : NO; }
-(void)dealloc{ [[NSNotificationCenter defaultCenter] removeObserver:self name:KLinePushNot object:nil]; }
-(void)timeAction{
    [self loadInfo];
    if (!self.isPop) {
        self.idxIdx += 1;
        if (self.idxIdx >= 4)
            self.idxIdx = 1;
    }
    [self setupIdx];
}

-(void)InitIdx{
    JCLStockIdxDetails *idx = [[JCLStockIdxDetails alloc]init];
    [self.view addSubview:idx];
    self.idx = idx;
    CGFloat h = [JCLKitObj JCLHeight:50];
    idx.frame = CGRectMake(0, self.submit.y-h, JCLWIDTH, h);
    idx.isDetails = NO;
    //展开收起
    [idx.action tapActionBlock:^{
        [self InitIdxCell:idx];
    }];
    
    [idx tapActionBlock:^{
        [self InitIdxCell:idx];
    }];
    self.idx = idx;
}

-(void)InitIdxCell:(JCLStockIdxDetails *)idx{
    self.isPop = YES;
//    self.popBg = [JCLKitObj JCLView:[AppDelegate shareAppDelegate].window color:JCLRGBA(0, 0, 0, 0.1)];
//    self.popBg.frame = CGRectMake(0, 0, JCLWIDTH, JCLHEIGHT);
//    [self.popBg tapActionBlock:^{
//        [self.popBg removeFromSuperview]; [self.idx removeFromSuperview]; self.idx = idx; self.isPop = NO;
//    }];
    
    JCLStockIdxDetails *idxs = [[JCLStockIdxDetails alloc]init]; [self.view addSubview:idxs];
    CGFloat h = 0.3*JCLHEIGHT; idxs.frame = CGRectMake(0, self.submit.y-h, JCLWIDTH, h);
    idxs.isDetails = YES;
    idxs.menu.idx = self.idxIdx-1;
    idxs.menu.arr = JCLIdxNames;
    idxs.menu.menuActionBlock = ^(UIButton *sender){
        self.idxIdx = sender.tag+1; [self setupIdx];
    };
    [idxs.action tapActionBlock:^{
        [self.popBg removeFromSuperview]; [self.idx removeFromSuperview]; self.idx = idx; self.isPop = NO;
    }];
    self.idx = idxs; [self setupIdx];
}

-(void)setupIdx{
    NSArray *codeArr = @[@".DJI", @".IXIC", @".INX"];
//    NSMutableArray *linArray = [NSMutableArray new];
    NSMutableArray *array = [NSMutableArray new];
    

    
    NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlC,@"quoteRealTime"];
//    [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    [JCLHttps httpPOSTRequest:postUrl params:@{@"userId":userId(),@"symbols":@".DJI,.IXIC,.INX"} success:^(id obj) {
        MMResultModel *model =(MMResultModel *)obj;
        NSLog(@"model %@",model.data);
        if (model.code.intValue == 200) {
            TSJRRealTimeMarket *realTimeMarketModel  = [TSJRRealTimeMarket modelWithDictionary:model.data[self.idxIdx-1]];
            
            self.idx.code.text = JCLIdxNames[self.idxIdx-1];
            self.idx.price.text = [NSString stringWithFormat:@"%.2lf", [realTimeMarketModel.latestPrice floatValue]];
            self.idx.range.text = [JCLMarketObj JCLMarketRange:self.idx.price.text close:realTimeMarketModel.preClose];
            UIColor *color = [JCLMarketObj JCLMarketColor:self.idx.range.text];
            self.idx.price.textColor = color;
            self.idx.range.textColor = color;
            self.idx.scale.textColor = color;
            if (self.isPop) {
                self.idx.range.text = [NSString stringWithFormat:@"%@    %@", [JCLMarketObj JCLMarketRange:self.idx.price.text close:realTimeMarketModel.preClose],
                                       [JCLMarketObj JCLMarketScale:self.idx.range.text close:realTimeMarketModel.preClose]];
            }
            
           self.idx.scale.text = [JCLMarketObj JCLMarketScale:self.idx.range.text close:realTimeMarketModel.preClose];
        }
        
        NSString *postUrlA = [NSString stringWithFormat:@"%@/%@",baseApiURlC,@"timeLine"];
        [JCLHttps httpPOSTRequest:postUrlA params:@{@"userId":userId(),@"symbols":codeArr[self.idxIdx-1]} success:^(id obj) {
            MMResultModel *model =(MMResultModel *)obj;
            if (model.code.intValue == 200) {
                [array removeAllObjects];
                for (id objc in model.data[0][@"intraday"][@"items"]) {
                    NSMutableArray *arrayA = [NSMutableArray new];
                    TSJRRealTimeMarket *mm = [TSJRRealTimeMarket modelWithDictionary:objc];
                    [arrayA addObject:mm.time];
                    [arrayA addObject:mm.avgPrice];
                    [arrayA addObject:mm.price];
                    [arrayA addObject:mm.volume];
                    [arrayA addObject:@"0.00"];
                    [array addObject:arrayA];
                 }
                
                
                self.idx.time.close = @"13.13";
                self.idx.time.times = @[@[@"21:30",@"0"],@[@"16:00",@"0"]];
                self.idx.time.arr =array;
            }
            
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
        } failure:^(NSError *error) {
           // [JCLFramework showErrorHud:@"服务器异常"];
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
        
       // [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
       // [JCLFramework showErrorHud:@"服务器异常"];
        //[MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
 
}

-(void)loadInfo{
    //    /dataapi/financialDailyResponse

    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
 
    NSString *postUrlC = [NSString stringWithFormat:@"%@/%@",baseApiURlE,@"financialDailyResponse"];
    [JCLHttps httpPOSTRequest:postUrlC params:@{@"userId":userId(),@"symbols":self.code,@"fields":@"marketcap",@"beginDate":[formatter stringFromDate:[JCLDateObj getTimeAfterNowWithDay:1]],@"endDate":[formatter stringFromDate:date]} success:^(id obj) {
        MMResultModel *model =(MMResultModel *)obj;
 
        if (model.code.intValue == 200&&model.data.count>0) {
            self.header.valueA = model.data[0][@"value"];
            self.valueA = model.data[0][@"value"];
        }
      
    } failure:^(NSError *error) {
        
    }];
    
    NSString *postUrlS = [NSString stringWithFormat:@"%@/%@",baseApiURlC,@"marketState"];
    
    [JCLHttps httpPOSTRequest:postUrlS params: @{@"userId":userId()}  success:^(id obj) {
        MMResultModel *model =(MMResultModel *)obj;
        NSLog(@"marketStatusmarketStatusmarketStatus  %@",model.data)
        if (model.code.intValue == 200 &&model.data.count>0) {
            
            NSLog(@"marketStatusmarketStatusmarketStatus  %@",model.data[0][@"marketStatus"]);
            self.navi.subMiddle.title = [NSString stringWithFormat:@"%@ %@",model.data[0][@"marketStatus"],model.data[0][@"openTime"]];
         }
    } failure:^(NSError *error) {
           [JCLFramework showErrorHud:@"服务器异常"];
        // [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    
    
     NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlC,@"quoteRealTime"];
//      [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        [JCLHttps httpPOSTRequest:postUrl params:@{@"userId":userId(),@"symbols":self.code} success:^(id obj) {
            
            MMResultModel *model =(MMResultModel *)obj;
            if (model.code.intValue == 200) {
                NSLog(@"quoteRealTime %@",model.data[0]);
                TSJRRealTimeMarket *realTimeMarketModel  = [TSJRRealTimeMarket modelWithDictionary:model.data[0]];
                self.header.decimal = self.decimal;
                self.header.mstokeModel=realTimeMarketModel;
                self.mstockM.latestPrice = realTimeMarketModel.latestPrice;
                self.header.code = self.code;
             }
            [self.table.mj_header endRefreshing];
            [self.table reloadData];
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        } failure:^(NSError *error) {
            [JCLFramework showErrorHud:@"服务器异常"];
             [self.table.mj_header endRefreshing];
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    
}
// 初始化提交按钮
-(void)InitSubmit{
    CGFloat h = [JCLKitObj JCLHeight:50];
    JCLStockSubmit *submit = [[JCLStockSubmit alloc]initWithFrame:CGRectMake(0,New_Device? JCLHEIGHT - h-34:JCLHEIGHT - h, JCLWIDTH, h)]; [self.view addSubview:submit];
     //开户
    submit.code = self.code;
    [submit.deal tapActionBlock:^{
        UIImage *image_ = [self imageWithScreenshot];
        ShareView *shareviews=[[ShareView alloc]initWithFrame:[UIScreen mainScreen].bounds image:image_];
        [[[UIApplication sharedApplication]keyWindow] addSubview:shareviews];
        
        
//        !self.dealActionBlock ? :self.dealActionBlock();
    }];
    
    //    /customerapi/isExistOptionalStock
    //    查询是否已收藏我的股票
    NSString *url = [NSString stringWithFormat:@"%@/%@",baseApiURlA,@"isExistOptionalStock"];
    
    [JCLHttps httpPOSTRequest:url params:@{@"userId":userId(),@"symbol":self.code} success:^(id obj) {
            NSLog(@" 查询是否已收藏我的股票objobj %@",obj);
            MMResultModel *model =(MMResultModel *)obj;
            if (model.code.intValue == 200 ) {
                submit.option.selected = YES;
                self.isCode = YES;
            }else{
                submit.option.selected = NO;
                self.isCode = NO;
            }
           
        } failure:^(NSError *error) {
            
        }];
 
    
    //自选
    [submit.option tapActionBlock:^{
        if (!userId()){ !self.optionActionBlock ? : self.optionActionBlock(); return; };
  
//        /customerapi/addOrDelOptionalStock
//        收藏，删除我的股票
        NSString *url = [NSString stringWithFormat:@"%@/%@",baseApiURlA,@"addOrDelOptionalStock"];
        [JCLHttps httpPOSTRequest:url params:@{@"symbol":self.code,@"userId":userId()} success:^(id obj) {
           
            MMResultModel *model =(MMResultModel *)obj;
            if (model.code.intValue == 200 ) {
                if (self.isCode) {
                    self.isCode = NO;
                    submit.option.selected = NO;
                    [JCLFramework showSuccess:@"取消自选成功"];
                } else {
                    self.isCode = YES;
                    submit.option.selected = YES;
                    [JCLFramework showSuccess:@"添加自选成功"];
                }
            }
        } failure:^(NSError *error) {
            
        }];
      
    }];
    
    //交易按钮
    [submit.tradingBtn tapActionBlock:^{
        NSMutableArray *data = @[@"买入/做多",@"卖出/做空",@"平仓"].mutableCopy;
        TSJRTradingPopuView *popupView = [[TSJRTradingPopuView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 135) selectValue:@""];
       
        popupView.parentVC = self;
        popupView.dataArray = data;
        
        // 1.处方单未开 3.已完结
        popupView.selectBlock = ^(NSString *v) {
            __weak typeof(self) weakSelf =self;
            TSJRBuyingSellingVC *vc = [[TSJRBuyingSellingVC alloc]init];
            if ([v isEqualToString:@"买入/做多"]){
                vc.action = @"BUY";
               
            } else if ([v isEqualToString:@"卖出/做空"]){
                vc.action = @"SELL";
             }else{
                vc.action = @"BUY";
            }
                vc.str= @"1";
            NSLog(@"==============  %@",self.mstockM.symbol);
             NSLog(@"======latestPrice========  %@",self.mstockM.latestPrice);
             vc.symbol = self.mstockM.symbol;
             vc.limitPrice = self.mstockM.latestPrice;
             [[JCLKitObj rootVC].navigationController presentViewController:vc animated:YES completion:nil];
        };
        
        [self lew_presentPopupView:popupView animation:[LewPopupViewAnimationFade new] dismissed:^{
            NSLog(@"动画结束");
        }];
 
    }];
    
    self.submit = submit;
}

- (NSData *)dataWithScreenshotInPNGFormat
{
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize =  CGSizeMake([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-55);
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(image);
}

/**
 *  返回截取到的图片
 *
 *  @return UIImage *
 */
- (UIImage *)imageWithScreenshot
{
    NSData *imageData = [self dataWithScreenshotInPNGFormat];
    return [UIImage imageWithData:imageData];
}

@end
