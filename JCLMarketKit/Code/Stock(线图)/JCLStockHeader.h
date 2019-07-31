//
//  StockHeader.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/13/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSJRRealTimeMarket.h"
#import "JCLBaseMenu.h"

@protocol StockHeaderDelegate <NSObject>
@optional
-(void)SwitchOrientation;
@end
//弹出K线小图
@interface JCLStockHeader : UIView
@property (nonatomic, strong) TSJRRealTimeMarket *mstokeModel;
@property (nonatomic, strong) NSArray *infoArr;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *decimal;
@property (nonatomic, copy) NSString *valueA;

@property (weak, nonatomic) id<StockHeaderDelegate> delegate;
@property (nonatomic, copy) void (^infoActionBlock)();

@property (nonatomic, strong) JCLBaseMenu *aboutMenu;
@property (nonatomic, assign) BOOL isInfo;
@property (nonatomic, assign) BOOL isKline;
@end
