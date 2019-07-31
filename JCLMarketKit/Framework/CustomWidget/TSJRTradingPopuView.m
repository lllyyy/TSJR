//
//  MMServiceStuatPopuView.m
//  Doctor
//
//  Created by 卢杨 on 17/3月/3.
//  Copyright © 2017年 com.cti. All rights reserved.
//
#import "UIViewController+LewPopupViewController.h"
#import "LewPopupViewAnimationFade.h"
#import "LewPopupViewAnimationSlide.h"
#import "LewPopupViewAnimationSpring.h"
#import "LewPopupViewAnimationDrop.h"
#import "TSJRTradingPopuView.h"
@interface TSJRTradingPopuView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, copy) NSString * selectValue;
 


@end

@implementation TSJRTradingPopuView

-(instancetype)initWithFrame:(CGRect)frame selectValue:(NSString *)selectValue{
    self = [super initWithFrame:frame];
    if (self) {
//        if ([selectValue isEqualToString:@"选择状态"]) {
//            self.selectValue = @"全部";
//        }else{
//           self.selectValue = selectValue;
//        }
      
         self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 3*45)];
         self.tableView.backgroundColor = [UIColor clearColor];;
         self.tableView.backgroundView.backgroundColor = [UIColor clearColor];;
         self.tableView.separatorColor = JCL_Bg_COL;
         self.tableView.delegate = self;
         self.tableView.dataSource = self;
         self.tableView.scrollEnabled = NO;
        [self addSubview:self.tableView];
    }
    return self;
}
+ (instancetype)defaultPopupView;
{
    return [[TSJRTradingPopuView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 216 + 44)];
}

-(void)layoutSubviews{
   
}

#pragma mark - UITableView Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1 ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = JCL_Cell_COL;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
 
//    if (([cell.textLabel.text rangeOfString: self.selectValue].location != NSNotFound)  ) {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        cell.textLabel.textColor = MAIN_COLOR;
//    } else {
//        cell.textLabel.textColor = TitleBColor;
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectValue = _dataArray[indexPath.row];
       
    if (self.selectBlock) {
        self.selectBlock(_dataArray[indexPath.row]);
    }
    
//    [self.tableView reloadData];
    [_parentVC lew_dismissPopupView];
}



@end
