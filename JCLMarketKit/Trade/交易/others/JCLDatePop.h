//
//  RXDate.h
//  NongGe_iOS
//
//  Created by 邢昭俊 on 4/22/16.
//  Copyright © 2016 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLDatePop : UIView
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, copy) void (^cancelActionBlock)();
@property (nonatomic, copy) void (^submitActionBlock)();
@property (nonatomic, weak) NSDate *minDate;
@property (nonatomic, weak) NSDate *maxDate;
@end
