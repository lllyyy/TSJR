//
//  HQColorObj.h
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/8/29.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <Foundation/Foundation.h>

#define JCL_Bg_COL [JCLColorObj JCLBgCol]
#define JCL_Cell_COL [JCLColorObj JCLCellCol]
#define JCL_Line_COL [JCLColorObj JCLLineCol]

#define JCL_Text_COL [JCLColorObj JCLTextCol]
#define JCL_SelText_COL [JCLColorObj JCLSelTextCol]

#define JCL_Rise_COL [JCLColorObj JCLRiseCol]
#define JCL_Fall_COL [JCLColorObj JCLFallCol]
 

@interface JCLColorObj : NSObject
+(UIColor *)JCLBgCol;
+(UIColor *)JCLCellCol;
+(UIColor *)JCLLineCol;
+(UIColor *)JCLTextCol;
+(UIColor *)JCLSelTextCol;
+(UIColor *)JCLKlineCol;

+(UIColor *)JCLRiseCol;
+(UIColor *)JCLFallCol;
+ (UIColor *)Newprice:(NSString *)Newprice Price:(NSString *)price;
@end
