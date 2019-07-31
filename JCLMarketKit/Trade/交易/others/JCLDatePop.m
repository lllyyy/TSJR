//
//  RXDate.m
//  NongGe_iOS
//
//  Created by 邢昭俊 on 4/22/16.
//  Copyright © 2016 邢昭俊. All rights reserved.
//

#import "JCLDatePop.h"

@interface JCLDatePop()
@property (nonatomic, weak) UIView *bg;
@property (nonatomic, weak) UIButton *cancel;
@property (nonatomic, weak) UIButton *submit;
@end

@implementation JCLDatePop
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JCLBGRGB;
 
        self.bg = [JCLKitObj JCLView:self color:JCLBGRGB];
        self.cancel = [JCLKitObj JCLButton:self.bg img:@"" size:15 target:self action:@selector(cancelAction)];
        self.cancel.title = @"取消"; self.cancel.color = JCLRISERGB;
        self.submit = [JCLKitObj JCLButton:self.bg img:@"" size:15 target:self action:@selector(submitAction)];
        self.submit.title = @"完成"; self.submit.color = JCLRISERGB;
        
        UIDatePicker *date = [[UIDatePicker alloc] init]; [self addSubview:date];
        date.datePickerMode = UIDatePickerModeDate;
        date.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        date.backgroundColor = [UIColor whiteColor];
        self.datePicker = date;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat y = 5, h = [JCLKitObj JCLHeight:44];
    self.bg.frame = CGRectMake(0, 0, self.width, h+y);
    self.cancel.frame = CGRectMake(0, 0, 0.5*self.width, h+y);
    self.submit.frame = CGRectMake(self.cancel.maxX, 0, 0.5*self.width, h+y);
    self.datePicker.frame = CGRectMake(0, self.cancel.maxY-y, self.width, self.height - h);
}

-(void)cancelAction{ !self.cancelActionBlock ? : self.cancelActionBlock(); }
-(void)submitAction{ !self.submitActionBlock ? : self.submitActionBlock(); }

-(void)setMinDate:(NSDate *)minDate{
    _minDate = minDate;
    self.datePicker.minimumDate = self.minDate;
    [self.datePicker setDate:minDate animated:YES];
}

-(void)setMaxDate:(NSDate *)maxDate{
    _maxDate = maxDate;
    self.datePicker.maximumDate = self.maxDate;
    [self.datePicker setDate:maxDate animated:YES];
}
@end
