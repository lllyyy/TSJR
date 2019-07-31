//
//  StockInfoView.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/14/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLStockInfoMenu : UIView
@property (nonatomic, copy) void (^infoActionBlock)();
@property (nonatomic, copy) void (^dissActionBlock)();

@property (nonatomic, assign) BOOL isPop;
@property (nonatomic, strong) NSArray *infoArr;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *decimal;

-(void)isReload;

@property(nonatomic, copy) void (^actionBlock)(NSArray *arr);
@end
