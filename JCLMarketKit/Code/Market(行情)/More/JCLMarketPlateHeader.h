//
//  QuotationPlateHeader.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2016/11/7.
//  Copyright © 2016年 ruixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLMarketPlateHeader : UIView
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, copy) void (^pushActionBlock)();
@end
