//
//  JCLYearMonthSelectedView.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/11.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCLBaseView.h"

//日期选择完成之后的操作
typedef void(^BRDateResultBlock)(NSString *selectValue);
NS_ASSUME_NONNULL_BEGIN

@interface JCLYearMonthSelectedView : JCLBaseView
//对外开放的类方法
@property (copy, nonatomic) BRDateResultBlock resultBlock;
+ (void)showDatePickerWithTitle:(NSString *)title minDateStr:(NSString *)minDateStr resultBlock:(BRDateResultBlock)resultBlock;
 
@end

NS_ASSUME_NONNULL_END
