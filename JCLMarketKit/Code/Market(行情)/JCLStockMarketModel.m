//
//  JCLStockMarketModel.m
//  Jincelue_Sdk
//
//  Created by 邢昭俊 on 2017/2/22.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockMarketModel.h"

@implementation JCLStockMarketModel
-(NSString *)range{ return [JCLMarketObj JCLMarketRange:self.current close:self.close]; }
-(NSString *)scale{ return [JCLMarketObj JCLMarketScale:self.current close:self.close]; }
@end
