//
//  JCLTradeList.m
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/6.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradeList.h"
#import "JCLTradeHeader.h"
#import "JCLTradeCell.h"
#import "JCLBarList.h"
#import "JCLSocketObj.h"
#import "JCLTradeKeyboard.h"
#import "AppDelegate.h"
#import "JCLMarketSearchList.h"
#import "JCLTradeDefine.h"
#import "JCLBitkindViewContorller.h"
#import "JCLYKView.h"
#import "JCLTradSelectList.h"
#import "JCLCarryViewController.h"
#import "JCLPutOrderViewController.h"
#import "JCLEntrustViewController.h"


@interface JCLTradeList ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) JCLTradeHeader *header;
@property (nonatomic, strong) NSArray *keys;
@property(nonatomic, strong) JCLYKView *yk_view;
@property(nonatomic, weak) UIView *pop;
@property(nonatomic,strong)JCLTradSelectList *select;
@property(nonatomic, weak) JCLTradeKeyboard *keyboard;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic, assign) BOOL isLock;

@property(nonatomic, assign) NSInteger orderIdx;
@property(nonatomic, strong) NSString *code;
@property(nonatomic,strong)JCLCarryViewController *carray;
@property(nonatomic,strong)JCLPutOrderViewController *order;
@property(nonatomic,strong)JCLEntrustViewController *Entrust;
@property(nonatomic, assign) CGFloat price; // 最小变动价
@property(nonatomic, assign) NSInteger priceIdx;
@property(nonatomic, strong) NSArray *infos;
@property(nonatomic, assign) BOOL iselect;
@property(nonatomic, assign) NSInteger orderStyle; // 订单类型 (市价，现价)
@property(nonatomic, assign) NSInteger tradeType; // 0开 1平
@property(nonatomic, assign) BOOL isBuy;
@property(nonatomic, assign) BOOL isBack; // 是否反手
@property(nonatomic, assign) BOOL isPing; // 反手数量
@property(nonatomic, assign) int left_num;
@property(nonatomic, strong) NSDictionary*countDic;
@property(nonatomic, assign) BOOL ispass;
@property(nonatomic,strong)NSString *priceKind;
@property(nonatomic,strong)NSString *average_marketPrice;
@property(nonatomic,strong)NSString *warning_line;
@property(nonatomic,strong)NSString *dangerous_rate;
@property(nonatomic,strong)NSString *selectRow;
@property(nonatomic,assign)int time;
@property(nonatomic,assign)BOOL iscontainDot;
@end

@implementation JCLTradeList
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.table.hidden = YES;
    self.code = self.codes[1];
    self.navi.left.img = @"";
    
    self.navi.right.img = @"gengduo";
    [self.navi.right tapActionBlock:^{
        
        JCLBitkindViewContorller *kind = [[JCLBitkindViewContorller alloc]init];
        [self.navigationController pushViewController:kind animated:YES];
    }];
    self.navi.middle.title = @"交易";
    self.infos = [JCLMarketObj JCLStockInfo:self.code];
    JCLTradeHeader *header = [[JCLTradeHeader alloc]init];
    header.x = 0;
    header.y = self.navi.maxY;
    header.width = JCLWIDTH;
    header.height = 0.66*JCLWIDTH;
    header.quan.text = [NSString stringWithFormat:@"动态权益: --"];
    header.usable.text = [NSString stringWithFormat:@"可用: --"];
    header.use.text = [NSString stringWithFormat:@"风险度: --"];
    header.sub1.val.text = self.codes[0]; header.sub1.val.delegate = self;
    self.isLock=YES;
    header.block = ^(NSDictionary *dic) {
      
        [self actionswithcode:dic];
    };
    [header.sub1.lock tapActionBlock:^{
        
        if (self.isLock==YES) {
            
             header.sub1.lock.img = @"suo-12";
            
        } else {
            
             header.sub1.lock.img = @"suo-13";
            
        }
        self.isLock = self.isLock ? NO : YES;
        
        
    }];
    [header.sub1.val tapActionBlock:^{
        if (self.isLock==NO) {
            
            [JCLFramework showErrorHud:@"合约已锁!"];
            return;
        }
        UITabBarController *tabBar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        UINavigationController *nav = (UINavigationController *)tabBar.selectedViewController;
        JCLMarketSearchList *list = [[JCLMarketSearchList alloc]init];
        list.isPop = YES;
        list.popActionBlock = ^(NSArray *infos){
            self.code = [NSString stringWithFormat:@"%@%@",infos[1],infos[2]];
            header.sub1.val.text = infos[3];
            self.header.market = nil;
            self.header.stock_code = nil;
            self.header.objs = infos;
            self.dic = nil;
            [self setNeedsDate];
        };
        [nav pushViewController:list animated:YES];
        
    }];
    [header.sub1.search tapActionBlock:^{
        if (self.isLock==NO) {
            
            [JCLFramework showErrorHud:@"合约已锁!"];
            
            return;
        }
        UITabBarController *tabBar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        UINavigationController *nav = (UINavigationController *)tabBar.selectedViewController;
        JCLMarketSearchList *list = [[JCLMarketSearchList alloc]init];
        list.isPop = YES;
        list.popActionBlock = ^(NSArray *infos){
            self.code = [NSString stringWithFormat:@"%@%@",infos[1],infos[2]];
            NSLog(@"%@",infos);
            header.sub1.val.text = infos[3];
            self.header.market = nil;
            self.header.stock_code = nil;
            self.header.objs = infos;
            self.dic = nil;
            [self setNeedsDate];
        };
        [nav pushViewController:list animated:YES];
    }];
        
    header.sub21.key.text = @"手数"; header.sub21.val.text = @"1"; header.sub21.val.delegate = self;
    header.sub22.key.text = @"价格";
    header.sub22.val.text = @"";
//    header.sub22.val.enabled = NO;
    header.sub22.val.delegate = self;
    header.sub31.idx.text = @"新"; header.sub31.idx.backgroundColor = JCLFallRGB;
    header.sub32.idx.text = @"昨"; header.sub32.idx.backgroundColor = JCLRiseRGB;

    header.bar.vals = @[@"持仓", @"挂单", @"委托", @"查询"];
    self.priceKind  = header.sub22.val.text;
    header.bar.actionBlock = ^(NSInteger idx){
        self.orderIdx = idx;
        self.vals = [NSMutableArray array];
        [self removeAllview];
        switch (idx) {
           
            case 0:  self.carray.view.hidden = NO;[self userPositionInfo]; break;
            case 1:  self.order.view.hidden = NO; [self dayEntrustInfo];  break;
            case 2:  self.Entrust.view.hidden = NO;[self dayEntrustInfo]; break;
            case 3:  self.select.view.hidden = NO; break;
            default: break;
        }

    };
    self.header = header;
    [self.view addSubview:self.header];
    [self initBaseView];
    
    
    self.price = 0;
    NSArray *trades = PreRead(JCLTradeInfo);
    [trades enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj[@"stock_code"] isEqualToString:self.codes[0]]) {
            self.price = [obj[@"price_step"] doubleValue];
        }
    }];
    __weak typeof(self) weakself = self;
    [self.header.order4 tapActionBlock:^{
        if (self.dic==nil) {
            
            [JCLFramework showErrorHud:@"请选择合约"];
            return;
        }
        self.yk_view =  [[JCLYKView alloc]initWithFrame:self.view.frame];
        self.yk_view.market = self.dic[@"exchange_type"];
        self.yk_view.code = self.dic[@"stock_code"];
        [self.yk_view showWindow];
        [self.yk_view updateStatus:self.dic[@"profit_price"] with:self.dic[@"loss_price"]];
        NSLog(@"%@",self.dic);
        
        self.yk_view.block = ^(BOOL y_select, BOOL k_select,NSString *profitPrice,NSString *lossPrice) {
            
           
            if (y_select==NO&&k_select==NO) {
                [JCLFramework JCLProgressHUD:@"设置中..."];
                [weakself ykSendDataWith:@"0" with:@"0" with:weakself.dic[@"position_id"]];
                
            }
            if (y_select==YES&&k_select==NO) {
                
                if (profitPrice.length==0) {
                    [JCLFramework showErrorHud:@"请输入止盈价格"];
                    return;
                }
                [JCLFramework JCLProgressHUD:@"设置中..."];
                [weakself ykSendDataWith:profitPrice with:@"0" with:weakself.dic[@"position_id"]];
            }
            if (y_select==NO&&k_select==YES) {
                if (lossPrice.length==0) {
                    [JCLFramework showErrorHud:@"请输入止损价格"];
                    return;
                }
                [JCLFramework JCLProgressHUD:@"设置中..."];
                [weakself ykSendDataWith:@"0" with:lossPrice with:weakself.dic[@"position_id"]];
            }
            if (y_select==YES&&k_select==YES) {
                if (profitPrice.length==0&&lossPrice.length==0) {
                    [JCLFramework showErrorHud:@"请输入止盈止损价格"];
                    return;
                }
                if (profitPrice.length==0) {
                    [JCLFramework showErrorHud:@"请输入止盈价格"];
                    return;
                }
                if (lossPrice.length==0) {
                    [JCLFramework showErrorHud:@"请输入止损价格"];
                    return;
                }
                [JCLFramework JCLProgressHUD:@"设置中..."];
                [weakself ykSendDataWith:profitPrice with:lossPrice with:weakself.dic[@"position_id"]];
                
            }
             [weakself.yk_view removeFromSuperview];
        };
        
    }];
    
}
-(void)initBaseView{
    CGFloat tabbarHeight = iPhoneX?83:49;
    JCLCarryViewController *carray  =[[JCLCarryViewController alloc]init];
    carray.listH =JCLHEIGHT-self.header.maxY-tabbarHeight;
    carray.view.frame = CGRectMake(0, self.header.maxY, JCLWIDTH, JCLHEIGHT-self.header.maxY-JCLTABHEIGHT);
    [self.view addSubview:carray.view];
    self.carray = carray;
    __weak typeof(self) wself = self;
    self.carray.block = ^(NSString * _Nonnull code,NSDictionary *obj) {
      
        wself.code = code;
        wself.header.objs = nil;
        wself.header.market = obj[@"exchange_type"];
        wself.header.stock_code = obj[@"stock_code"];
        wself.header.sub1.val.text = obj[@"stock_name"];
        wself.header.sub21.val.text = [NSString stringWithFormat:@"%@",obj[@"enable_vol"]];
        wself.dic = obj;
        wself.infos = [JCLMarketObj JCLStockInfo:wself.code];
        [wself setNeedsDate];
    };
    NSLog(@"%f    %f",self.header.maxY, carray.view.frame.size.height);
    JCLPutOrderViewController *order  =[[JCLPutOrderViewController alloc]init];
    order.listH = self.carray.listH;
    order.view.frame =self.carray.view.frame;
    [self.view addSubview:order.view];
    self.order = order;
    
    JCLEntrustViewController *Entrust  =[[JCLEntrustViewController alloc]init];
    Entrust.listH =self.carray.listH;
    Entrust.view.frame = self.carray.view.frame;
    [self.view addSubview:Entrust.view];
    self.Entrust = Entrust;
    
    CGFloat listH = JCLHEIGHT-self.header.maxY-tabbarHeight;
    JCLTradSelectList *select = [[JCLTradSelectList alloc]init];
    select.listH = listH;
    select.view.hidden = YES;
    select.view.frame=CGRectMake(0, self.header.maxY, JCLWIDTH, JCLHEIGHT-self.header.maxY-JCLTABHEIGHT);
    [self.view addSubview:select.view];
    self.select = select;
    
}
-(void)removeAllview{
    
    self.carray.view.hidden = YES;
    self.order.view.hidden = YES;
    self.Entrust.view.hidden = YES;
    self.select.view.hidden = YES;
    
}
-(void)ykSendDataWith:(NSString *)y_price with:(NSString *)k_price with:(NSString *)code{
    
    NSDictionary *dic = @{
                          @"client_id" : PreRead(JCLUserInfo)[@"username"],
                          @"entrust_no" : code,
                          @"loss_price" :@(k_price.doubleValue),
                          @"profit_price" :@(y_price.doubleValue)
                          };
    
    [[JCLSocketObj share] JCLSocketRequst:dic idx:JCL_PROTOCOL_YK];
}

-(void)actionswithcode:(NSDictionary *)info{
    
   
//  self.isBack = YES;
    NSDictionary *dic = info;
    self.countDic = dic;
   __block NSString *order_money = dic[@"order_money"];
  
    int type = [dic[@"type"] intValue];
    int entrust_vol = [dic[@"entrust_vol"] intValue];
    
    int sellDirection;
    
    if ([self.dic[@"entrust_bs"]intValue]==0) {
        
        sellDirection = 1;
        
    } else {
        
        sellDirection = 0;
        
    }
    if (self.dic!=nil) {
        
        [JCLFramework JCLProgressHUD:@"下单中..."];
        __block  NSDictionary *requsetDic;
        //优先平昨 然后平今
        //总持仓
         int total_enable_val  =[self.dic[@"enable_vol"] intValue];
        //昨持仓
         int yes_enable_val  =[self.dic[@"enable_vol"] intValue] - [self.dic[@"today_enable_vol"] intValue];
        //今持仓
        int today_enable_val  =[self.dic[@"today_vol"] intValue];

        if (entrust_vol>total_enable_val) {
            
            [JCLFramework showErrorHud:@"平仓手数大于总持仓手数!"];
            return;
        }
        if (yes_enable_val==0&&today_enable_val==0) {
            
            [JCLFramework showErrorHud:@"可用持仓不足!无法平仓"];
            return;
        }
        if (self.vals.count==0) {
            return;
        }
        NSString *market_code;
        switch ([self.dic[@"exchange_type"] integerValue]) {
            case 21:
            {
                
                market_code = [NSString stringWithFormat:@"NYSE%@", self.dic[@"stock_code"]];
                
            }
                break;
            case 22:
            {
                market_code = [NSString stringWithFormat:@"NASDAQ%@", self.dic[@"stock_code"]];
                
            }
                break;
            case 23:
            {
                
                market_code = [NSString stringWithFormat:@"AMERICAN%@", self.dic[@"stock_code"]];
                
            }
                break;
                
            default:
                break;
        }
            [JCLStockDataObj JCLGetStockFiveInfo:JCLMarketURL code:market_code success:^(id obj) {
                
                NSArray *buys = [JCLHttpsObj JCLHandleStr:obj begin:8 end:5];
                NSArray *sells = [JCLHttpsObj JCLHandleStr:obj begin:3 end:5];
                //         /卖1              /买1
                NSString *sell = buys[0][0], *buy = sells[0][0];
                
                if (type==3) { //对手价
                    
                    if (sellDirection==0) { //买
                        
                        order_money = sell;
                        
                    } else { //卖
                        
                        order_money = buy;
                    }
                    
                } else if (type==4){ //排队价
                    
                    if (sellDirection==0) { //买
                        
                        order_money = buy;
                        
                    } else { //卖
                        
                        order_money = sell;
                    }
                }
                self.average_marketPrice = order_money;

                requsetDic = @{@"client_id":name(), //  用户代码
                               @"exchange_type":@([self.dic[@"exchange_type"] integerValue]), // 市场类型
                               @"entrust_type":@(0), // 0 限价 1 市价
                               @"entrust_bs":  @(sellDirection), // 0 卖 1 买
                               @"entrust_direction": @(1), // 开平仓方向
                               @"stock_code":self.dic[@"stock_code"], // 证券代码
                               @"entrust_price":order_money, // 订单价格
                               @"entrust_vol":@(entrust_vol), // 手数
                               @"pid": self.dic[@"position_id"], // 非平仓单，送0
                               @"auth_id": PreRead(Online), // 认证ID
                               @"hedge_type":@(0), // 投机/套报类型
                               @"entrust_way": @(2), // IOS 交易端
                               };
                [[JCLSocketObj share] JCLSocketRequst:requsetDic idx:JCL_PROTOCOL_WTMM];

            } failure:^(NSError *error) {
                
            }];

    } else{
        [JCLFramework showErrorHud:@"请选择持仓合约!"];
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)text{
    
    
    text.text = @"";
    
    if (self.isLock==NO && text == self.header.sub1.val) {
        [JCLFramework showErrorHud:@"合约已锁"];
        
        return NO;
    }
        if (text == self.header.sub1.val) {
        return NO;
    }
    self.pop = [JCLKitObj JCLView:[AppDelegate shareAppDelegate].window color:JCLRGBA(0, 0, 0, 0.1)];
    self.pop.frame = CGRectMake(0, 0, JCLWIDTH, JCLHEIGHT);
    [self.pop tapActionBlock:^{
        [self.pop removeFromSuperview]; [self.keyboard removeFromSuperview];
    }];
    JCLTradeKeyboard *keyboard = [[JCLTradeKeyboard alloc]init]; [self.pop addSubview:keyboard];
    [keyboard.diss tapActionBlock:^{
        [self.pop removeFromSuperview]; [self.keyboard removeFromSuperview];
    }];
    keyboard.valAction = ^(UIButton *sender){
        text.text = sender.title;
        [self.pop removeFromSuperview]; [self.keyboard removeFromSuperview];
    };
    //排队价  对手价  市价
    keyboard.wayAction = ^(UIButton *sender){
        
        self.priceIdx = sender.tag; [self setNeedsDate];
        text.text = sender.title;
        [self.pop removeFromSuperview]; [self.keyboard removeFromSuperview];
        self.priceKind = text.text;
        [self setNeedsDate];
        self.header.order1.title = [NSString stringWithFormat:@" 买"];
        self.header.order2.title = [NSString stringWithFormat:@" 卖" ];
        self.header.order3.title = [NSString stringWithFormat:@" 平"];
    
    };
    keyboard.volAction = ^(UIButton *sender){

        NSString *val = text.text;
        if (![self isNum:val]) { val = @""; }
        if (val.length>6) {
            
            val = [val substringToIndex:6];
        }
        if (sender.tag == 11) {
            
            if (val.length) {
                
                if (text.text.length==val.length+1) {
                
                text.text = [val substringToIndex:val.length];
                
            } else {
                
                text.text = [val substringToIndex:val.length-1];
                
            } }
        } else {
            
            text.text = [NSString stringWithFormat:@"%@%@", val, sender.title];
        }
    };
    keyboard.numAction = ^(UIButton *sender){
        NSString *val = text.text;
        

        if (val.length>=6) {
            
            val = [val substringToIndex:6];
        }
       
        if (sender.tag == 11) {
            
            if (val.length) {
                
                if (text.text.length==val.length+1) {
                    
                     text.text = [val substringToIndex:val.length];
                    
                } else {
                    
                      text.text = [val substringToIndex:val.length-1];
                    
                }
            
            }
            
        } else {
            
            text.text = [NSString stringWithFormat:@"%@%@", val, sender.title];
            
            
        }
       
//        if (self.dic!=nil) {
//
//            self.header.order1.title = [NSString stringWithFormat:@"(%@) 买", text.text];
//            self.header.order2.title = [NSString stringWithFormat:@"(%@) 卖", text.text];
//            self.header.order3.title = [NSString stringWithFormat:@"(%@) 平", text.text];
//
//        } else {
//
//            self.header.order1.title = [NSString stringWithFormat:@"(%@) 买", text.text];
//            self.header.order2.title = [NSString stringWithFormat:@"(%@) 卖", text.text];
//            self.header.order3.title = [NSString stringWithFormat:@"(%@) 平", text.text];
//
//        }
//
//
//        self.priceKind =nil;
//        if (text.text.length==0) {
//            self.header.order1.title = [NSString stringWithFormat:@" 买"];
//            self.header.order2.title = [NSString stringWithFormat:@" 卖" ];
//            self.header.order3.title = [NSString stringWithFormat:@" 平"];
//
//        }
    };
    keyboard.optAction = ^(UIButton *sender){
        double price = sender.tag == 0 ? text.text.doubleValue + self.price : text.text.doubleValue - self.price;
        text.text = [NSString stringWithFormat:@"%g", price];
    };
    CGFloat h = 0.64*JCLWIDTH;
    if (text == self.header.sub1.val) {
        keyboard.val.text = @"    从自选中选择合约";
        keyboard.isCode = YES;
    } if (text == self.header.sub21.val) {
        keyboard.isPrice = YES;
        // keyboard.val.text = [NSString stringWithFormat:@"    最大可开仓手数: %g" , self.price];
    } if (text == self.header.sub22.val) {
        h = 0.74*JCLWIDTH;
//        keyboard.val.text = [NSString stringWithFormat:@"    最小变动价为: %g" , self.price];
        keyboard.val.text = [NSString stringWithFormat:@""];
//        keyboard.val.hidden = YES;
    }
    keyboard.frame = CGRectMake(0, JCLHEIGHT-h, JCLWIDTH, h);
    self.keyboard = keyboard;
    return NO;
}
- (BOOL)isNum:(NSString *)checkedNumString {
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
   
    [self userCapitalInfo];
    AppDelegate.shareAppDelegate.timerAtionBlock = ^(){
        if (![JCLUserData getUserInfo].username) {
            return;
        }
        [self setNeedsDate];
        if (self.orderIdx==0) {

             [self userPositionInfo];
        }
    };
    [self responseSocket];
}
// socket解析
-(void)responseSocket{
    
    [JCLSocketObj share].socketActionBlock = ^(NSDictionary *dic, NSInteger idx) {
    
        if ([dic[@"status"] isEqualToNumber:@(0)]) {
            if (idx != JCL_PROTOCOL_ZJCX) {
                
                [self.vals removeAllObjects];
            }
            switch (idx) {
                    
                case JCL_PROTOCOL_ZJCX:{//资金查询
                    NSDictionary *obj = dic[@"data"];
                    NSLog(@"--%@",obj);
                    self.header.quan.text = [NSString stringWithFormat:@"动态权益: %.2f", [obj[@"fund_balance"] doubleValue]];
                    self.header.usable.text = [NSString stringWithFormat:@"可用: %.2f",  [obj[@"enable_balance"]doubleValue]];
                    self.header.use.text = [NSString stringWithFormat:@"风险度: %.2f%%", [obj[@"rate"] doubleValue]];
                   
                   
                } break;
                case JCL_PROTOCOL_CCSJ://持仓数据
                {
                    NSLog(@"--%@",dic);
                    [self.vals addObjectsFromArray:dic[@"holders"]];
                    [self.carray reloadData:self.vals];
                   
                }
                    break;
                case JCL_PROTOCOL_YK:{//设置止盈止损
                    NSLog(@"%@",dic);
                    [JCLFramework Dismiss];
                    [JCLFramework showSuccess:@"设置成功!"];
                    [self userPositionInfo];
                    [self update];
                    
                } break;
                case JCL_PROTOCOL_DRWT://当日委托
                {
                     NSLog(@"--%@",dic);
                    NSMutableArray *array = [NSMutableArray array];
                    if (self.orderIdx==1) {
                        
                        for (NSDictionary *total_dic in dic[@"records"]) {
                            
                             if ([total_dic[@"entrust_status"] integerValue] == 0 || [total_dic[@"entrust_status"] integerValue] == 3 || [total_dic[@"entrust_status"] integerValue] == 4){
                                 
                                 [array addObject:total_dic];
                             }
                        }
                        
                    } else {
                        
                        [array addObjectsFromArray:dic[@"records"]];
                    }
                    
                    for (int i=0; i<array.count; i++) {
                        
                        NSInteger time = [array[i][@"entrust_time"] integerValue];
                        
                        for (int j=i+1; j<array.count; j++) {
                            
                        NSInteger next_time = [array[j][@"entrust_time"] integerValue];
                            
                            if (time<next_time) {
                                
                                [array exchangeObjectAtIndex:i withObjectAtIndex:j];
                            }
                        }
                    }
                     [self.vals addObjectsFromArray:array.copy];
                     self.orderIdx==1?[self.order reloadData:self.vals]:[self.Entrust reloadData:self.vals];
                }
                    break;
                case JCL_PROTOCOL_CJCX:{//成交查询
                    
                    NSArray *data = dic[@"records"];
                    NSMutableArray *array = data.mutableCopy;
                    for (int i=0; i<array.count; i++) {
                    
                        NSInteger time = [array[i][@"business_time"] integerValue];
                        
                        for (int j=i+1; j<array.count; j++) {
                            
                            NSInteger next_time = [array[j][@"business_time"] integerValue];
                            
                            if (time<next_time) {
                                
                                [array exchangeObjectAtIndex:i withObjectAtIndex:j];
                            }
                        }
                    }
                     [self.vals addObjectsFromArray:array];
                    [self.table reloadData];
                     [JCLFramework Dismiss];
                }
                    break;

                case JCL_PROTOCOL_WTCD:{
                    
                     [JCLFramework showSuccess:@"撤单成功"];
                     [self dayEntrustInfo];
                }
                    break;
                case JCL_PROTOCOL_WTMM: {
                    
                    switch (self.orderIdx) {
                        case 0:
                        {
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [self userPositionInfo];
                            });
                            
                        }
                            break;
                        case 1:
                        {
                            [self dayEntrustInfo];
                            
                        }
                            break;
                        case 2:
                        {
                            [self dayEntrustInfo];
                            
                        }
                            break;
                            
                        default:
                            break;
                    }

                    [JCLFramework Dismiss];
                    [JCLFramework showSuccess:@"下单成功"];
                    [self resetData];
                    [self userCapitalInfo];
                } break;
                default: break;
            }
        } else {
            
            [JCLFramework Dismiss];
            if (idx==JCL_PROTOCOL_ZJCX) {
                
                self.header.quan.text =@"动态权益:--" ;
                self.header.usable.text =@"可用:--";
            }
            if (![dic[@"describe"] isEqualToString:@"查找用户信息失败"]) {
                [JCLFramework showErrorHud:dic[@"describe"]];
            }
        }
    };
}
-(void)resetData{
    
    self.header.sub1.val.text = nil;
    self.header.sub21.val.text = nil;
    self.dic = nil;
    self.code = nil;
    self.header.sub32.key.text = [NSString stringWithFormat:@"%@",@"--"];
    self.header.sub32.val.text = [NSString stringWithFormat:@"%@", @"--"];
    self.header.sub31.key.text = [NSString stringWithFormat:@"%@",@"--" ];
    self.header.sub31.val.text = [NSString stringWithFormat:@"%@",@"--" ];
    
}
// 用户资金信息查询  11103
-(void)userCapitalInfo{
   
    NSDictionary *dic = @{ @"client_id" : name() };
    [[JCLSocketObj share] JCLSocketRequst:dic idx:JCL_PROTOCOL_ZJCX];
}


// 通过行情获取对应数据
-(void)setNeedsDate{
    if (self.code) {
        
        //http://116.62.117.131/FreeHQWebServer/ReportResource?symbol=COMEXCLZ7
        [JCLMarketDataObj JCLGetMarketInfos:JCLMarketURL code:@[self.code] success:^(NSArray *obj){
            NSLog(@"--%@",obj);
            NSLog(@"--%@",obj[1]);
            if (obj.count >=5) {
                NSArray *infos = [JCLHttpsObj JCLHandleStr:obj begin:2 end:obj.count - 3][1];
                NSLog(@"%@",infos);
                self.header.sub32.key.text = [NSString stringWithFormat:@"%@", infos[1]];
                //            self.header.sub32.val.text = [NSString stringWithFormat:@"%@", infos[0][1]];
                
                
                self.header.sub31.key.text = [NSString stringWithFormat:@"%@", infos[4]];
                //            self.header.sub31.val.text = [NSString stringWithFormat:@"%@", buys[0][1]];
                
                
                
            }
        } failure:^(NSError *error) { }];
    }
    
}

// 持仓数据查询  11123
-(void)userPositionInfo{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        NSDictionary *dic = @{
                              @"client_id" : name(), // 用户代码
                              @"start" : @(0), // 起始序号
                              @"limit" : @(500), // 请求行数
                              };
        [[JCLSocketObj share] JCLSocketRequst:dic idx:JCL_PROTOCOL_CCSJ];
        
    });
    
    
}

// 当日委托查询  11119
-(void)dayEntrustInfo{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSDictionary *dic = @{
                              @"client_id" :  [JCLUserData getUserInfo].username, // 用户代码
                              @"start" : @(0), // 起始序号
                              @"limit" : @(500), // 请求行数
                              @"entrust_type":@(0), // 市场类型
                              };
        [[JCLSocketObj share] JCLSocketRequst:dic idx:JCL_PROTOCOL_DRWT];
        
    });
   
}

// 当日成交查询 11117
-(void)userDayDealInfo{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSDictionary *dic = @{
                              @"client_id" :  [JCLUserData getUserInfo].username, // 用户代码
                              @"start" : @(0), // 起始序号
                              @"limit" : @(500), // 请求行数
                              @"entrust_type" : @([self.infos[0] integerValue]), // 交易类型 0.所有 1.股票 2.组合 3.比赛
                              @"entrust_typeid" : @(0), // 交易类型编号 当类型为2 时为组合编号，为3 时比赛ID
                              };
        [[JCLSocketObj share] JCLSocketRequst:dic idx:JCL_PROTOCOL_CJCX];
        
    });
   
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.view endEditing:YES];
//    if (self.vals.count==0) {
//
//        return;
//    }
//    if (self.orderIdx==0) {
//        if (self.isLock==NO) {
//            return;
//        }
//        self.selectRow = [NSString stringWithFormat:@"%ld",indexPath.row];
//        for (JCLTradeCell *cell in tableView.visibleCells) {
//
//            cell.bg.backgroundColor = JCL_Bg_COL;
//        }
//        JCLTradeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        cell.bg.backgroundColor = JCLRGB(27, 28, 36);
//        NSDictionary *obj = self.vals[indexPath.row];
//        NSString *market = obj[@"exchange_type"];
//        switch (market.intValue) {
//            case 21:
//            {
//
//                 self.code = [NSString stringWithFormat:@"NYSE%@", obj[@"stock_code"]];
//
//            }
//                break;
//            case 22:
//            {
//                 self.code = [NSString stringWithFormat:@"NASDAQ%@", obj[@"stock_code"]];
//
//            }
//                break;
//            case 23:
//            {
//
//                 self.code = [NSString stringWithFormat:@"AMERICAN%@", obj[@"stock_code"]];
//
//            }
//                break;
//
//            default:
//                break;
//        }
//        //设置历史选择为空
//        self.header.objs = nil;
//        self.header.market = market;
//        self.header.stock_code = obj[@"stock_code"];
//        self.header.sub1.val.text = obj[@"stock_name"];
//        self.header.sub21.val.text = [NSString stringWithFormat:@"%@",obj[@"enable_vol"]];
//        self.dic = obj;
//        self.infos = [JCLMarketObj JCLStockInfo:self.code];
//        [self setNeedsDate];
//    }
//
//}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}
-(void)update{
    
    self.header.sub1.val.text = nil;
    self.header.sub21.val.text = nil;
    self.dic = nil;
    self.code=nil;
    self.header.sub32.key.text = @"--";
    self.header.sub32.val.text = @"--";
    self.header.sub31.key.text = @"--";
    self.header.sub31.val.text = @"--";
    
}

@end
