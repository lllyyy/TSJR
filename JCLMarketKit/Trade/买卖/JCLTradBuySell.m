//
//  JCLBuyAndSell.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/23.
//  Copyright © 2017年 刘虎超. All rights reserved.
//  买卖View

#import "JCLTradBuySell.h"
#import "JCLHttps.h"
#import "JCLTradFiveCell.h"
#import "JCLTablePop.h"
#import "JCLSocketObj.h"
#import "JCLTradBuySellCell.h"

@interface JCLTradBuySell()<UITextFieldDelegate>
@property (nonatomic, weak) UIView *infoBg;
@property (nonatomic, weak) JCLTradBuySellCell *code;
@property (nonatomic, weak) JCLTradBuySellCell *price;
@property (nonatomic, weak) JCLTradBuySellCell *vol;

@property (nonatomic, strong) NSArray *codes;
@property (nonatomic, strong) NSArray *infos;

@end

@implementation JCLTradBuySell
-(instancetype)init{
    if (self = [super init]){
        self.backgroundColor = JCL_Bg_COL;

        JCLTradBuySellCell *code = [[JCLTradBuySellCell alloc]init]; [self addSubview:code];
        code.title.text = @"代码";
        code.text.placeholder = @"请输入股票代码";
        [code.text addTarget:self action:@selector(codeAction:) forControlEvents:(UIControlEventEditingChanged)];
        self.code = code;
        
        JCLTradBuySellCell *price = [[JCLTradBuySellCell alloc]init]; [self addSubview:price];
        price.title.text = @"价格";
        price.text.placeholder = @"请输入股票价格";
        price.text.keyboardType =  UIKeyboardTypeDecimalPad;
        price.isNum = YES;
        [price.add tapActionBlock:^{
            price.text.text = [NSString stringWithFormat:@"%.2lf", price.text.text.floatValue + 0.01];
        }];
        [price.reduce tapActionBlock:^{
            if(price.text.text.floatValue <= 0.01) return [JCLFramework JCLProgressHUD:@"价格必须大于0"];
            price.text.text = [NSString stringWithFormat:@"%.2lf", price.text.text.floatValue - 0.01];
        }];
        self.price = price;
        
        JCLTradBuySellCell *vol = [[JCLTradBuySellCell alloc]init]; [self addSubview:vol];
        vol.title.text = @"数量";
        vol.text.placeholder = @"请输入股票数量";
        vol.isVol = YES;
        [vol.add tapActionBlock:^{
            vol.text.text = [NSString stringWithFormat:@"%ld", vol.text.text.integerValue + 100];
        }];
        [vol.reduce tapActionBlock:^{
            if(vol.text.text.intValue <= 100) return [JCLFramework JCLProgressHUD:@"数量必须大于100"];
            vol.text.text = [NSString stringWithFormat:@"%ld", vol.text.text.integerValue - 100];
        }];
        self.vol = vol;
        
        self.infoBg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        self.money = [JCLKitObj JCLLable:self.infoBg font:13 color:JCL_Text_COL alignment:1];
        self.remain = [JCLKitObj JCLLable:self.infoBg font:13 color:JCL_Text_COL alignment:1];
        self.buyVol = [JCLKitObj JCLLable:self.infoBg font:13 color:JCL_Text_COL alignment:1];
        self.sellVol = [JCLKitObj JCLLable:self.infoBg font:13 color:JCL_Text_COL alignment:1];

        self.buy = [JCLKitObj JCLButton:self.infoBg img:@"" size:14 target:self action:@selector(buySellAction)];
        self.buy.title = @"买入";
        self.buy.layer.cornerRadius = 4;
        self.buy.backgroundColor = JCL_Fall_COL;

        
        self.sell = [JCLKitObj JCLButton:self.infoBg img:@"" size:14 target:self action:@selector(buySellAction)];
        self.sell.title = @"卖出";
        self.sell.layer.cornerRadius = 4;
        self.sell.backgroundColor = JCL_Rise_COL;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat s = 3, h = self.height-5*s;
    self.code.frame = CGRectMake(0, 0, self.width, 0.18*h);
    self.price.frame = CGRectMake(0, self.code.maxY+s, self.width, 0.18*h);
    self.vol.frame = CGRectMake(0, self.price.maxY+s, self.width, 0.18*h);

    self.infoBg.frame = CGRectMake(0, self.vol.maxY+s, self.width, 0.46*h);
    CGFloat x = 14, y = 10, w = (self.width-2*x)/2, infoH = (self.infoBg.height-2*y);
    self.money.frame = CGRectMake(x, y, w, 0.3*infoH);
    self.remain.frame = CGRectMake(self.money.maxX, y, w, 0.3*infoH);
    self.buyVol.frame = CGRectMake(x, self.money.maxY, w, 0.3*infoH);
    self.sellVol.frame = CGRectMake(self.money.maxX, self.money.maxY, w, 0.3*infoH);

    CGFloat submitW = (self.width-3*x)/2, subH = 0.8*(0.4*infoH);
    self.buy.frame = CGRectMake(x, self.sellVol.maxY+0.5*(0.4*infoH-subH), submitW, subH);
    self.sell.frame = CGRectMake(self.buy.maxX + x, self.sellVol.maxY+0.5*(0.4*infoH-subH), submitW, subH);
}

- (void)codeAction:(UITextField *)text{
    if(text.text.length != 6) {
        self.code.text.text = @""; self.price.text.text = @""; self.vol.text.text = @"";
    } else {
        NSArray *szArr = FileRead(CachesFile(NYSE)); [self searchInfo:szArr val:text.text];
       // NSArray *shArr = FileRead(CachesFile(CodeSH)); [self searchInfo:shArr val:text.text];
        if (self.codes.count) {
            self.code.text.text = [NSString stringWithFormat:@"%@ (%@)",text.text, self.codes[3]];
            //http://116.62.117.131/FreeHQWebServer/report?symbol=COMEXCLZ7
            [JCLStockDataObj JCLGetStockInfo:JCLMarketURL code:self.codes[6] success:^(NSArray *obj) {
                if (obj.count >=4) {
                    NSArray *infos = [JCLHttpsObj JCLHandleStr:obj begin:3 end:1][0];
                    self.price.text.text = [NSString stringWithFormat:@"%@", infos[4]];
                    self.infos = infos;
                }
            } failure:^(NSError *error) { }];
        } else {
            [JCLFramework JCLProgressHUD:@"请输入正确的股票编码"];
        }
    }
}

-(void)searchInfo:(NSArray *)arr val:(NSString *)val{
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", val];
    [arr enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL *stop) {
        NSArray *group = [NSArray arrayWithArray:[obj filteredArrayUsingPredicate:preicate]];
        if (group.count) { self.codes = obj; }
    }];
}

// 买卖
- (void)buySellAction{
    [self endEditing:YES];
    if(self.code.text.text.length != 6){ [JCLFramework JCLProgressHUD:@"请输入股票代码"]; return; }
    if(!self.price.text.text.length){ [JCLFramework JCLProgressHUD:@"委托价格错误"]; return; }
    if(!self.vol.text.text.length){ [JCLFramework JCLProgressHUD:@"委托数量错误"]; return; }
    !self.buySellActionBlock ? : self.buySellActionBlock();
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{ [self endEditing:YES]; }
@end
