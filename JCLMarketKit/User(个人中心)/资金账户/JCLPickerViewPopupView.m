//
//  JCLPickerViewPopupView.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/26.
//  Copyright © 2019 邢昭俊. All rights reserved.
//

#import "JCLPickerViewPopupView.h"
#import "LewPopupViewController.h"
@interface JCLPickerViewPopupView()<UIPickerViewDelegate, UIPickerViewDataSource>
@property(nonatomic,strong) NSMutableArray *arrayA;
@property(nonatomic,strong) UIPickerView *myPicker;
@property(nonatomic,strong) NSMutableArray *arrayB;
@property(nonatomic,strong) NSMutableArray *arrayC;
@end
@implementation JCLPickerViewPopupView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = @[].mutableCopy;
        self.arrayA = @[].mutableCopy;
        self.arrayB = @[].mutableCopy;
        self.arrayC = @[].mutableCopy;
    }
    return self;
}

+ (instancetype)defaultPopupView;
{
    return [[JCLPickerViewPopupView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 216 + 44)];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor whiteColor];
    
    self.arrayA = @[@"美元",@"港币"].mutableCopy;
    self.arrayB = @[@"兑换"].mutableCopy;
    self.arrayC = @[@"港币"].mutableCopy;
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:5];
    UIBarButtonItem *flexibleSpaceItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *flexibleSpaceItem2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 0, 40, 44);
    UIColor *titleColor = TitleBColor;
    [cancelBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    UIBarButtonItem *cancelBtnItem = [[UIBarButtonItem alloc]initWithCustomView:cancelBtn];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    title.textColor = TitleAColor;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:18];
  
    
    UIBarButtonItem *titleBtnItem = [[UIBarButtonItem alloc]initWithCustomView:title];
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(0, 0, 40, 44);
    [confirmBtn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    
    
    UIBarButtonItem *confirmBtnItem = [[UIBarButtonItem alloc] initWithCustomView:confirmBtn];
    [items addObject:cancelBtnItem];
    [items addObject:flexibleSpaceItem1];
    [items addObject:titleBtnItem];
    [items addObject:flexibleSpaceItem2];
    [items addObject:confirmBtnItem];
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    toolBar.tintColor = TitleAColor;
    toolBar.items = items;
    [self addSubview:toolBar];
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0,toolBar.bottom, kScreenWidth, 0.5)];
    line.backgroundColor = SeparatorLineBColor;
    [self addSubview:line];
    UIView *tview = [[UIView alloc] initWithFrame:CGRectMake(0,line.bottom, kScreenWidth, self.height - 44) ] ;
    [tview setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:tview ] ;
    self.myPicker = [[UIPickerView alloc] init];
    self.myPicker.frame = CGRectMake(0.0, 0, kScreenWidth, 216);
    self.myPicker.showsSelectionIndicator = YES;
    self.myPicker.delegate = self;
    self.myPicker.dataSource = self;
    [self.myPicker selectRow:0 inComponent:0 animated:YES ] ;
    [tview addSubview:self.myPicker];
    
}
// 返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.dataSource.count;
}
// 返回多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 1||component == 2 ) {
        return 1;
    }else{
        return 2;
    }
}
// 返回每行的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
         return self.arrayA[row];
    }else if(component == 1){
        return self.arrayB[row];
    }else{
        return self.arrayC[row];
    }
   
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
       
        if ([self.arrayA[row] isEqualToString:@"美元"]) {
             [self.arrayC replaceObjectAtIndex:0 withObject:@"港币"];
             [self.myPicker reloadComponent:2];
             [self.myPicker selectRow:0 inComponent:0 animated:YES];
        }else{
            [self.arrayC replaceObjectAtIndex:0 withObject:@"美元"];
            [self.myPicker reloadComponent:2];
         
            [self.myPicker selectRow:0 inComponent:2 animated:YES];
        }
        
    }
    
}

//- (BOOL)anySubViewScrolling:(UIView *)view{
//    if ([view isKindOfClass:[UIScrollView class]]) {
//        UIScrollView *scrollView = (UIScrollView *)view;
//        if (scrollView.dragging || scrollView.decelerating) {
//            return YES;
//        }
//    }
//    for (UIView *theSubView in view.subviews) {
//        if ([self anySubViewScrolling:theSubView]) {
//            return YES;
//        }
//    }
//    return NO;
//}

- (void)save {
   NSString *str = self.arrayA[[self.myPicker selectedRowInComponent:0]];
    NSLog(@"strstr %@",str);
   NSString *strA = self.arrayA[[self.myPicker selectedRowInComponent:0]];
   NSLog(@"strA %@",strA);
//    if (![self anySubViewScrolling:self.myPicker]) {
//
//        NSInteger row = [self.myPicker selectedRowInComponent:0];
//
//        NSString *value = self.dataSource[0][row];
//
//        switch (dataPickType) {
//            case sexType:
//            {
//                value = [NSString stringWithFormat:@"%ld", (long)row];
//            }
//            default:
//                break;
//        }
//
//        if (self.selectBlock) {
//            self.selectBlock(value);
//        }
//        [self cancel];
//    }
    
}
- (void)cancel {
    [_parentVC lew_dismissPopupView];
}

//- (void)setupDataSource:(DataPickType) type department:(NSString *)dept{
//    dataPickType = type;
//    NSMutableArray *array = @[].mutableCopy;
//    switch (type) {
//
//        case sexType:
//        {
//            [array addObject:@"女"];
//            [array addObject:@"男"];
//            [self.dataSource addObject:array];
//            break;
//        }
//
//        case jobType:
//        {
//            array = [MMGlobalClass getFilePathFromTechnical:@"iniset"][dept];
//
//            [self.dataSource addObject:array];
//            break;
//        }
//
//        default:
//            break;
//    }
//
//    [self.myPicker reloadAllComponents];
//}
//
//- (void)setupDataSource2:(DataPickType) type dataArrray:(NSMutableArray *) dataArrray {
//    dataPickType = type;
//    [self.dataSource removeAllObjects];
//    [self.dataSource addObject:dataArrray];
//
//    //  NSLog(@"sdfasdfdf%@", self.dataSource);
//    [self.myPicker reloadAllComponents];
//}



@end
