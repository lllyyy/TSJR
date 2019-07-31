//
//  JCLTradMainHeader.h
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/17.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCLBarList.h"

@interface JCLTradMainHeader : UIView
@property (nonatomic, weak) UILabel *assets;
@property (nonatomic, weak) UILabel *marketVal;
@property (nonatomic, weak) UILabel *cash;
@property (nonatomic, weak) UILabel *arrears;
@property (nonatomic, weak) UILabel *frozen;
@property (nonatomic, weak) UILabel *draw;

@property (nonatomic, strong) JCLBarList *bar;
@end
