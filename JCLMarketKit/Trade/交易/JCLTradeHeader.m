//
//  JCLTradeHeader.m
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/8.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradeHeader.h"
#import "JCLSocketObj.h"
#import "JCLTradeDefine.h"
@interface JCLTradeHeader()
@property (nonatomic, weak) UIView *bg;
@property (nonatomic, weak) UIView *info;
@end

@implementation JCLTradeHeader
-(instancetype)init{
    if (self = [super init]){
        self.backgroundColor = JCL_Bg_COL;
        
        self.bg = [JCLKitObj JCLView:self color:JCLRGBA(29, 30, 40, 0.6)];
        self.quan = [JCLKitObj JCLLable:self font:13 color:JCLRGB(112, 113, 115) alignment:1];
        self.usable = [JCLKitObj JCLLable:self font:13 color:JCLRGB(112, 113, 115) alignment:1];
//        self.use = [JCLKitObj JCLLable:self font:13 color:JCLRGB(112, 113, 115) alignment:1];
        
        JCLTradeSub1 *sub1 = [[JCLTradeSub1 alloc]init];
        [self addSubview:sub1];
        self.sub1 = sub1;
        //
        JCLTradeSub2 *sub21 = [[JCLTradeSub2 alloc]init];
        [self addSubview:sub21]; self.sub21 = sub21;
        //金额输入框
        JCLTradeSub2 *sub22 = [[JCLTradeSub2 alloc]init];
        [self addSubview:sub22]; self.sub22 = sub22;
        
        self.info = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        JCLTradeSub3 *sub31 = [[JCLTradeSub3 alloc]init]; [self.info addSubview:sub31]; self.sub31 = sub31;
       JCLTradeSub3 *sub32 = [[JCLTradeSub3 alloc]init]; [self.info addSubview:sub32]; self.sub32 = sub32;

        self.order1 = [JCLKitObj JCLButton:self img:@"" size:15 target:self action:nil];
        self.order1.backgroundColor = JCLRiseRGB; self.order1.layer.cornerRadius = 5;
        self.order2 = [JCLKitObj JCLButton:self img:@"" size:15 target:self action:nil];
        self.order2.backgroundColor = JCLFallRGB; self.order2.layer.cornerRadius = 5;
        self.order3 = [JCLKitObj JCLButton:self img:@"" size:15 target:self action:nil];
        self.order3.backgroundColor = JCLHexCol(@"#DADBDD"); self.order3.layer.cornerRadius = 5;
        self.order4 = [JCLKitObj JCLButton:self img:@"" size:15 target:self action:nil];
        self.order4.backgroundColor = JCLFallRGB; self.order4.layer.cornerRadius = 5;
        self.order1.title = @"买";
        self.order2.title = @"卖";
        self.order3.title = @" 平";
        self.order3.color = [UIColor blackColor];
        self.order4.title = @"止盈止损";
        [self.order1 tapActionBlock:^{
           
            [self buySellAction:0];
        }];
        [self.order2 tapActionBlock:^{
           
            [self buySellAction:1];
        }];
        [self.order3 tapActionBlock:^{
            
            [self buySellAction:3];

        }];

        JCLBarList *bar = [[JCLBarList alloc]init]; [self addSubview:bar]; self.bar = bar;
    }
    return self;
}

- (void)buySellAction:(int)type{
    [self endEditing:YES];

    if(!self.sub1.val.text.length) { [JCLFramework showErrorHud:@"请选择合约"]; return; }
    if(!self.sub22.val.text.length){ [JCLFramework showErrorHud:@"请输入委托价格"]; return; }
    if(!self.sub21.val.text.length){ [JCLFramework showErrorHud:@"请输入委托手数"]; return; }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [[UIView appearanceWhenContainedIn:[UIAlertController class], nil] setTintColor:[UIColor blackColor]];
    
    NSString *title = @"委托";
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithString:title];
    [strM addAttribute:NSForegroundColorAttributeName value:JCL_Text_COL range:NSMakeRange(0, title.length)];
    [strM addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, title.length)];
    [alert setValue:strM forKey:@"attributedTitle"];
    
    NSString *info = [NSString stringWithFormat:@"合约名称: %@\n委托价格: %@\n委托数量: %@\n是否同意发出该笔委托?",
                      self.sub1.val.text, self.sub22.val.text, self.sub21.val.text];
    NSMutableAttributedString *infoM = [[NSMutableAttributedString alloc] initWithString:info];
    [infoM addAttribute:NSForegroundColorAttributeName value:JCL_Text_COL range:NSMakeRange(0, info.length)];
    [infoM addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, info.length)];
    [alert setValue:infoM forKey:@"attributedMessage"];
    
    UIAlertAction *diss = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
        [[UIView appearanceWhenContainedIn:[UIAlertController class], nil] setBackgroundColor:[UIColor clearColor]];
    }];
    [diss setValue:JCL_Text_COL forKey:@"_titleTextColor"];
    [alert addAction:diss];
    
    NSLog(@"--%@",self.sub22.val.text);
    
    int priceType;
   __block NSString *order_money;
    
    priceType = 0;
    order_money  =[NSString stringWithFormat:@"%@",self.sub22.val.text];

    UIAlertAction *submit = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        
        if (type==3) {
            NSDictionary *parlarms = @{
                                       @"entrust_vol":self.sub21.val.text,
                                       @"type":@(priceType),
                                       @"order_money":order_money
                                       };
            self.block(parlarms);
            
        } else {
            
            if (self.objs.count!=0) {
                
                NSLog(@"%@",self.objs);
                self.market = self.objs[0];
                self.stock_code = self.objs[2];
              
            }
            NSString *market_code;
            switch (self.market.intValue) {
                case 21:
                {
                    
                    market_code = [NSString stringWithFormat:@"NYSE%@", self.stock_code];
                    
                }
                    break;
                case 22:
                {
                    market_code = [NSString stringWithFormat:@"NASDAQ%@", self.stock_code];
                    
                }
                    break;
                case 23:
                {
                    
                    market_code = [NSString stringWithFormat:@"AMERICAN%@", self.stock_code];
                    
                }
                    break;
                    
                default:
                    break;
            }
 
                [JCLFramework JCLProgressHUD:@"下单中..."];
           
                [JCLStockDataObj JCLGetStockFiveInfo:JCLMarketURL code:market_code success:^(id obj) {
                    
                    NSArray *buys = [JCLHttpsObj JCLHandleStr:obj begin:8 end:5];
                    NSArray *sells = [JCLHttpsObj JCLHandleStr:obj begin:3 end:5];
                    //         /卖1              /买1
                    NSString *sell = buys[0][0], *buy = sells[0][0];
                    
                    if (priceType==3) { //对手价
                        
                        if (type==0) { //买
                            
                            order_money = sell;
                            
                        } else { //卖
                            
                            order_money = buy;
                        }
                        
                    } else if (priceType==4){ //排队价
                        
                        if (type==0) { //买
                            
                            order_money = buy;
                            
                        } else { //卖
                            
                            order_money = sell;
                        }
                    }
                    NSDictionary *dic = @{
                                          @"client_id" : [JCLUserData getUserInfo].username,
                                          @"exchange_type" : @([self.market integerValue]),
                                          @"stock_code" : self.stock_code,
                                          @"entrust_bs" : @(type),
                                          @"entrust_type" : @(0),
                                          @"entrust_price" : order_money,
                                          @"entrust_vol" :  @([self.sub21.val.text intValue]),
                                          @"pid": @(0), // 平仓单的订单ID
                                          @"entrust_direction" :  @(0),
                                          @"hedge_type" :  @(0),
                                          @"entrust_way" : @(2),
                                          @"auth_id" : PreRead(Online),
                                          };
                    NSLog(@"--%@",dic[@"stock_code"]);
                    NSLog(@"--%@",dic);
                    [[JCLSocketObj share] JCLSocketRequst:dic idx:JCL_PROTOCOL_WTMM];
                    
                } failure:^(NSError *error) {
                    
                }];
        }
        
        [[UIView appearanceWhenContainedIn:[UIAlertController class], nil] setBackgroundColor:[UIColor clearColor]];
    }];
    [submit setValue:JCL_Text_COL forKey:@"_titleTextColor"];
    [alert addAction:submit];
    [[UIView appearanceWhenContainedIn:[UIAlertController class], nil] setBackgroundColor:JCL_Cell_COL];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat w = self.width/2, h = self.height-2*14;
    CGFloat infoH = 0.18*h;
    self.quan.frame = CGRectMake(10, 0, w, infoH);
    self.usable.frame = CGRectMake(JCLWIDTH-w-10, 0, w, infoH);
//  self.use.frame = CGRectMake(self.usable.maxX, 0, w, infoH)
    
    self.bg.frame = CGRectMake(0, self.quan.maxY, self.width, self.height-self.quan.maxY);

    CGFloat x = 14, s = 6, subW = 0.6*(self.width-2*x), subH = 0.34*h;
    CGFloat sub1H = 0.5*(subH-s);
    self.sub1.frame = CGRectMake(x, self.quan.maxY+14, subW, sub1H);
    CGFloat sub2W = 0.5*(subW-s);
    self.sub21.frame = CGRectMake(x, self.sub1.maxY+s, sub2W, sub1H);
    self.sub22.frame = CGRectMake(self.sub21.maxX+s, self.sub1.maxY+s, sub2W, sub1H);
    
    CGFloat buyH = (subH-2*s)/2;
    self.info.frame = CGRectMake(self.sub1.maxX+s, self.quan.maxY+14, self.width-(self.sub1.maxX+s+x), subH);
    self.sub31.frame = CGRectMake(0, s, self.info.width, buyH);
    self.sub32.frame = CGRectMake(0, self.sub31.maxY, self.info.width, buyH);
//    self.sub33.frame = CGRectMake(0, self.sub32.maxY, self.info.width, subH/3);

    CGFloat ow = (self.width-2*x-2*s)/3, oh = 0.19*h;
    self.order1.frame = CGRectMake(x, self.info.maxY+x, ow, oh);
    self.order2.frame = CGRectMake(self.order1.maxX+s, self.info.maxY+x, ow, oh);
    self.order3.frame = CGRectMake(self.order2.maxX+s, self.info.maxY+x, ow, oh);
//    self.order4.frame = CGRectMake(self.order3.maxX+s, self.info.maxY+x, ow, oh);

    self.bar.frame = CGRectMake(0, self.order2.maxY+x, self.width, 0.2*h);
}
@end
