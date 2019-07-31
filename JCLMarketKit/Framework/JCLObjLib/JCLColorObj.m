//
//  HQColorObj.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/8/29.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLColorObj.h"

#define UpdateColor @"UpdateColor"
@implementation JCLColorObj
+ (UIColor *)Newprice:(NSString *)Newprice Price:(NSString *)price
{
    float s=[Newprice floatValue];
    float j=[price floatValue];
    if(s>j)
    {
        return [UIColor redColor];
    }else if(s<j){
        return JCLRGB(1, 189, 112);
    }else{
        return [UIColor whiteColor];
    }
}
+(UIColor *)JCLBgCol{
    NSString *style = PreRead(UpdateColor);
    
    if (!style.length) {
        return JCLRGB(26, 26, 34);
    } else {
        return JCLHexCol(@"#15191D");
    }
}

+(UIColor *)JCLCellCol{
//    return JCLHexCol(@"#1C1F26");
    return JCLRGB(33, 33, 42);
}

+(UIColor *)JCLLineCol{
    return JCLHexCol(@"#2E313A");
}


+(UIColor *)JCLKlineCol{
    NSString *style = PreRead(UpdateColor);
    if (!style.length) {
        return JCLRGB(20, 20, 30);
    } else {
        return JCLRGB(233, 233, 233);
    }
}

+(UIColor *)JCLRiseCol{
    return JCLHexCol(@"#D51A18");
}

+(UIColor *)JCLFallCol{
    return JCLHexCol(@"#1FB31F");
}

+(UIColor *)JCLTextCol{
    NSString *style = PreRead(UpdateColor);
    if (!style.length) {
        return [UIColor whiteColor];
    } else {
        return [UIColor blackColor];
    }
}

+(UIColor *)JCLSelTextCol{
    return JCLHexCol(@"#CAA966");
}
@end

