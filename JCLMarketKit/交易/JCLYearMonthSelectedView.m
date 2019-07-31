//
//  JCLYearMonthSelectedView.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/11.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "JCLYearMonthSelectedView.h"

//  CJYearMonthSelectedView.m


@interface JCLYearMonthSelectedView () <UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong, nonatomic) UIPickerView *picker;    //选择器
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *minDateStr;
 
@property ( nonatomic,copy) NSString *selectValue;   //选择的值
@property (strong, nonatomic) NSMutableArray<NSString *> *data;

@end

@implementation JCLYearMonthSelectedView

+ (void)showDatePickerWithTitle:(NSString *)title minDateStr:(NSString *)minDateStr resultBlock:(BRDateResultBlock)resultBlock{
    
    JCLYearMonthSelectedView *datePicker = [[JCLYearMonthSelectedView alloc] initWithTitle:title minDateStr:minDateStr resultBlock:resultBlock];
    [datePicker showWithAnimation:YES];
}

//初始化方法
- (instancetype)initWithTitle:(NSString *)title minDateStr:(NSString *)minDateStr resultBlock:(BRDateResultBlock)resultBlock{
    if (self = [super init]) {
        _title = title;
        _minDateStr = minDateStr;
        _resultBlock = resultBlock;
        
        [self initUI];
    }
    
    return self;
}

//UI布局，主要就是在弹出视图上添加选择器
- (void)initUI{
    [super initUI];
    self.titleLabel.text = _title;
    // 添加时间选择器
    [self.alertView addSubview:self.picker];
}

//选择器的初始化和布局
- (UIPickerView *)picker{
    if (!_picker) {
        _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kTopViewHeight + 0.5, SCREEN_WIDTH, kDatePicHeight)];
        //        _picker.backgroundColor = [UIColor whiteColor];
        _picker.showsSelectionIndicator = YES;
        //设置代理
        
        _picker.delegate =self;
        _picker.dataSource =self;
       [_picker selectRow:0 inComponent:0 animated:YES ] ;
    }
    return _picker;
}

//选择器数据的加载，从设定的最小日期到当前月
- (NSMutableArray<NSString *> *)data{
    if (!_data) {
        _data = [[NSMutableArray alloc] init];
        NSDate *currentDate = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM"];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
        NSString *dateStr = [formatter stringFromDate:currentDate];
        NSInteger lastIndex = 0;
        NSDate *newdate;
         [_data addObject:@"全部"];
        //循环获取可选月份，从当前月份到最小月份
        while (!([dateStr compare:self.minDateStr] == NSOrderedAscending)) {
            [_data addObject:dateStr];
            lastIndex--;
            //获取之前几个月
            [lastMonthComps setMonth:lastIndex];
            newdate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];
            dateStr = [formatter stringFromDate:newdate];
        }
    }
    return _data;
}

#pragma mark - UIPickerView的数据和布局，和tableview类似
//返回多少列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSDictionary* titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIColor orangeColor],NSForegroundColorAttributeName,
                                         [UIFont systemFontOfSize:15], NSFontAttributeName,
                                         nil];
    
 
    NSString *str = [NSString stringWithFormat:@"%@", self.data[row]];
    NSAttributedString *restr = [[NSAttributedString alloc] initWithString:str attributes:titleTextAttributes];
    return restr;
}


//返回多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.data.count;
}

//每一行的数据
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.data[row];
}

//选中时的效果
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.selectValue = self.data[row];
    NSLog(@"selectValue %@",_selectValue);
}

//返回高度
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 35.0f;
}

//返回宽度
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return SCREEN_WIDTH;
}

#pragma mark - 背景视图的点击事件
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender {
    //    [self dismissWithAnimation:NO];
}

#pragma mark - 弹出视图方法
- (void)showWithAnimation:(BOOL)animation {
    //1. 获取当前应用的主窗口
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    if (animation) {
        // 动画前初始位置
        CGRect rect = self.alertView.frame;
        rect.origin.y = SCREEN_HEIGHT;
        self.alertView.frame = rect;
        // 浮现动画
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.alertView.frame;
            rect.origin.y -= kDatePicHeight + kTopViewHeight;
            self.alertView.frame = rect;
        }];
    }
}

#pragma mark - 关闭视图方法
- (void)dismissWithAnimation:(BOOL)animation {
    // 关闭动画
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.alertView.frame;
        rect.origin.y += kDatePicHeight + kTopViewHeight;
        self.alertView.frame = rect;
        
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.leftBtn removeFromSuperview];
        [self.rightBtn removeFromSuperview];
        [self.titleLabel removeFromSuperview];
        [self.lineView removeFromSuperview];
        [self.topView removeFromSuperview];
        [self.picker removeFromSuperview];
        [self.alertView removeFromSuperview];
        [self.backgroundView removeFromSuperview];
        [self removeFromSuperview];
        
        self.leftBtn = nil;
        self.rightBtn = nil;
        self.titleLabel = nil;
        self.lineView = nil;
        self.topView = nil;
        self.picker = nil;
        self.alertView = nil;
        self.backgroundView = nil;
    }];
}

#pragma mark - 取消按钮的点击事件
- (void)clickLeftBtn {
    [self dismissWithAnimation:YES];
}

#pragma mark - 确定按钮的点击事件
- (void)clickRightBtn {
    NSLog(@"点击确定按钮后，执行block回调");
    [self dismissWithAnimation:YES];
    if (_resultBlock) {
        NSInteger row = [self.picker selectedRowInComponent:0];
        NSString *value = self.data[row];
        NSLog(@"----- %@",value);
        _resultBlock(value);
    }
}

@end
 
