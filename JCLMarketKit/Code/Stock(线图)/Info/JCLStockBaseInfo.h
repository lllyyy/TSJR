//
//  JCLStockBaseInfo.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/5/3.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLStockBaseInfo : UIView
@property (nonatomic, strong) NSString *code;
@property (nonatomic, assign) BOOL isScroll;
@property (nonatomic, strong) NSArray *infoArr;
@property (nonatomic, assign) BOOL isIdnex;

@property (nonatomic, strong) NSString *decimal;

-(void)setNeedsDate:(BOOL)is;
-(void)setNeedsDate;

@property(nonatomic, copy) void (^actionBlock)(NSArray *arr);
@end
