//
//  JCLStockSubmit.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/30.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockSubmit.h"

@implementation JCLStockSubmit
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
            self.backgroundColor = JCL_Cell_COL;
        self.deal = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:nil];
        NSString *trade = PreRead(isTrade);
        
//        if ([[JCLUserSession getCurrentAccount] isEqualToString:@"1"]) {
             self.deal.title =  @"分享" ;
//        }else{
//            self.deal.title =  @"开户" ;
//        }
       
        self.deal.backgroundColor = JCL_SelText_COL;
        
        self.option = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:nil];
        self.option.title = @"加自选";
        self.option.selectedTitle = @"删自选";
        self.option.backgroundColor = JCL_SelText_COL;
        
        self.tradingBtn = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:nil];
        self.tradingBtn.title = @"交易";
        self.tradingBtn.backgroundColor = JCL_SelText_COL;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
 
    if ([self.code isEqualToString:@".DJI"] || [self.code isEqualToString:@".IXIC"]|| [self.code isEqualToString:@".INX"]) {
        self.deal.frame = CGRectMake(0, 0, (self.width-2)/2, self.height);
//        self.tradingBtn.frame = CGRectMake(self.deal.right+1, 0,  (self.width-3)/3, self.height);
//
        self.option.frame = CGRectMake(self.deal.right+1, 0, (self.width-2)/2, self.height);
    }else{
        self.deal.frame = CGRectMake(0, 0, (self.width-3)/3, self.height);
        self.tradingBtn.frame = CGRectMake(self.deal.right+1, 0,  (self.width-3)/3, self.height);
        
        self.option.frame = CGRectMake(self.tradingBtn.right+1, 0, (self.width-3)/3, self.height);
    }
    
    
}
@end
