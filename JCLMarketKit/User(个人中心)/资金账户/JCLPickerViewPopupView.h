//
//  JCLPickerViewPopupView.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/26.
//  Copyright © 2019 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectBlock)(NSString *v);
NS_ASSUME_NONNULL_BEGIN

@interface JCLPickerViewPopupView : UIView


@property (nonatomic, weak) UIViewController *parentVC;
@property(nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,copy) SelectBlock selectBlock;

+ (instancetype)defaultPopupView;
 
//- (void)setupDataSource:(DataPickType) type department:(NSString *)dept;
//- (void)setupDataSource2:(DataPickType) type dataArrray:(NSMutableArray *) dataArrray;
@end

NS_ASSUME_NONNULL_END
