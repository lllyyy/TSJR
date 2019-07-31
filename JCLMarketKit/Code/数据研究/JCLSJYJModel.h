//
//  JCLSJYJModel.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/4/6.
//  Copyright © 2017年 刘虎超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCLSJYJModel : NSObject
//股票名字
@property (nonatomic,strong) NSString *name;
//股票代码
@property (nonatomic,strong) NSString *code;
//股票最新价
@property (nonatomic,assign) float now;
//股票涨幅
@property (nonatomic,assign) float zf;
//总市值
@property (nonatomic,assign) double grosscapital;
@property (nonatomic,assign) NSInteger jj_flag;
//连板数
@property (nonatomic,assign) NSInteger continue_num;
//时间
@property (nonatomic,assign) NSInteger time;
//0深圳 1上海
@property (nonatomic,assign) NSInteger setcode;
//累计涨跌幅
@property (nonatomic,assign) float cxzd;

@property (nonatomic,assign) float ssprice;
@property (nonatomic,assign) float cxzf;
//五日和三日涨幅
@property (nonatomic,assign) float wuzf;
@property (nonatomic,assign) float sanzf;
@end
