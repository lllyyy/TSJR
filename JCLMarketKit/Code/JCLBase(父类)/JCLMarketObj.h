//
//  JCLMarketObjManage.h
//  Jincelue_Sdk
//
//  Created by 邢昭俊 on 2017/2/24.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <Foundation/Foundation.h>

#define InitDate @"InitDate"
#define InitTime @"InitTime"

#define NYSETime @"NYSETime.plist"
#define NYSE @"NYSE.plist"
#define NASDAQTime @"NASDAQTime.plist"
#define NASDAQ @"NASDAQ.plist"
#define AmerTime @"AmerTime.plist"
#define American @"American.plist"

#define Option @"self.plist"
#define CodeHis @"codehis.plist"

#define JCLKLine @"kline"
#define JCLKLineIdx @"KLineIdx"

#define JCLRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a] // 获取RGB颜色值
#define JCLRGB(r, g, b) JCLRGBA(r, g, b, 1)

#define JCLMAINRGB JCLRGBA(252, 81, 79, 1)
#define JCLRISERGB JCLRGBA(240, 71, 57, 1)
#define JCLFALLRGB JCLRGBA(36, 138, 38, 1)
#define JCLFLATRGB JCLRGBA(188, 188, 188, 1)

@interface JCLMarketObj : NSObject

+(NSArray *)JCLSearchCode:(NSString *)code;

-(void)loadUpdateCodeData;

// 拿到服务器的时间
-(void)JCLSeverDate;

// 通过代码获取市场信息
+(NSArray *)JCLMarketInfos:(NSString *)code;
// 通过市场获取时间轴
+(NSArray *)JCLStockTimes:(NSString *)code;
// 通过代码获取个股索引
+(NSInteger)JCLStockIdx:(NSString *)code;
// 通过代码获取个股信息
+(NSArray *)JCLStockInfo:(NSString *)code;

// 通过代码获取个股现价小数点
+(NSString *)JCLStockDecimal:(NSString *)code;
+(UIColor *)JCLMarketColor:(NSString *)price;
// 通过现价和昨收获取对应色值
+(UIColor *)JCLMarketColor:(NSString *)price close:(NSString *)close;
// 通过价格获取对应单位
+(NSString *)JCLMarketUnit:(NSString *)number decimal:(NSString *)decimal style:(NSInteger)style;
// 通过代码检测市场类型
+(NSString *)JCLMarketStyle:(NSString *)code;
// 通过代码检测是否是市场指数
+(BOOL)JCLMarketIdx:(NSString *)code;

//跌涨幅
+(NSString *)JCLMarketPercent:(NSString *)str;

// 通过基金等类型确定小数点
+(NSString *)JCLMarketPrice:(CGFloat)price decimal:(NSString *)decimal;
+(NSString *)JCLMarketPrice:(NSString *)price is:(NSString *)is;
// 通过开盘价和昨收获取市场价格涨跌范围
+(NSString *)JCLMarketRange:(NSString *)open close:(NSString *)close;
+(NSString *)JCLMarketRange:(NSString *)open close:(NSString *)close is:(NSString *)is;
// 通过价格涨跌范围和昨收获取市场价格涨跌比例
+(NSString *)JCLMarketScale:(NSString *)range close:(NSString *)close;
// 清空个股信息的沙盒记录
+(void)JCLStockClear;
+(UIColor *)TSJRMarketColor:(NSString *)price close:(NSString *)close;
+(UIColor *)TSJRMarketColorA:(NSString *)price;
+ (NSString*)UTF8_To_GB2312:(NSString*)utf8string;
@end
