//
//  YSTableList.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/1.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "YSTableList.h"

@interface YSTableList ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@end

@implementation YSTableList
-(void)viewDidLoad {
    [super viewDidLoad];
    self.table = [JCLKitObj JCLTable:self.view target:self frame:CGRectMake(0, JCLNAVI, JCLWIDTH, JCLSCROLL) style:UITableViewStyleGrouped];
    self.table.contentInset  = UIEdgeInsetsMake(0, 0, 0, 0);
    self.table.backgroundColor = JCL_Bg_COL;
    self.table.emptyDataSetSource = self;
    self.table.emptyDataSetDelegate = self;
    self.vals = [[NSMutableArray alloc]init];
    self.arrM = [[NSMutableArray alloc]init];
}


//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{ return 0; }
-(  UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
 return nil;
    
};
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return 0.1; }
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{ UITableViewCell *cell; return cell; }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ return 0; }

-(  UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *foot; foot.backgroundColor = JCLBGRGB; return foot;
};

    
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{ }

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{ [self.view endEditing:YES]; }
#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"default_search"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"暂无相关结果";
    UIColor *color = TitleCColor;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                 NSForegroundColorAttributeName:color};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
//    [self.viewModel.requestRemoteDataCommand execute:@(1)];
//}
//

#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return self.arrM == nil;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView {
    return CGPointMake(0, -(self.table.contentInset.top - self.table.contentInset.bottom) / 2);
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -100;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 20;
}
@end
