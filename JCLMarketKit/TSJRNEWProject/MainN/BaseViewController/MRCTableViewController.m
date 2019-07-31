//
//  MRCTableViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCTableViewController.h"
#import "MRCTableViewModel.h"
#import "MRCTableViewCellStyleValue1.h"
#import "MJRefresh.h"

@interface MRCTableViewController ()
// @property (nonatomic, strong) UISearchBar *searchBar;


@property (nonatomic, strong, readonly) MRCTableViewModel *viewModel;


@end

@implementation MRCTableViewController

@dynamic viewModel;

- (instancetype)initWithViewModel:(MRCViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        if ([viewModel shouldRequestRemoteDataOnViewDidLoad]) {
            @weakify(self)
            [[self rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
                @strongify(self)
                [self.viewModel.requestRemoteDataCommand execute:@1];
            }];
        }
    }
    return self;
}

- (void)setView:(UIView *)view {
    [super setView:view];
    if ([view isKindOfClass:UITableView.class]) self.tableView = (UITableView *)view;
}

//- (UIEdgeInsets)contentInset {
//    return iPhoneX ? UIEdgeInsetsMake(88, 0, 0, 0) : UIEdgeInsetsMake(64, 0, 0, 0);
//}

- (void)viewDidLoad {
    [super viewDidLoad];
      [self setupTableView];
    if (IOS11) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
//    if (self.searchBar != nil) {
//        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
//        self.tableView.tableHeaderView = tableHeaderView;
//
//        [tableHeaderView addSubview:self.searchBar];
//
//        self.searchBar.translatesAutoresizingMaskIntoConstraints = NO;
//
//        [tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[searchBar]|"
//                                                                                options:0
//                                                                                metrics:nil
//                                                                                  views:@{ @"searchBar": self.searchBar }]];
//
//        [tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[searchBar]|"
//                                                                                options:0
//                                                                                metrics:nil
//                                                                                  views:@{ @"searchBar": self.searchBar }]];
//    }
    
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc]initWithFrame: CGRectMake(0, JCLNAVI , kScreenWidth, kScreenHeight - JCLNAVI-JCLTABHEIGHT) style:UITableViewStyleGrouped];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.contentInset  = self.contentInset;
    //self.tableView.contentOffset = CGPointMake(0, 0 - self.contentInset.top);
    self.tableView.scrollIndicatorInsets = self.contentInset;
    
    self.tableView.sectionIndexColor = [UIColor darkGrayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexMinimumDisplayRowCount = 20;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerClass:[MRCTableViewCellStyleValue1 class] forCellReuseIdentifier:@"MRCTableViewCellStyleValue1"];
    [self.view addSubview:self.tableView];
    
    
    [self setupRefresh];
}
- (void)setupRefresh {
    @weakify(self)
    if (self.viewModel.shouldPullToRefresh) {
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [[[self.viewModel.requestRemoteDataCommand
               execute:@1]
              deliverOnMainThread]
             subscribeNext:^(id x) {
                 @strongify(self)
                 self.viewModel.page = 1;
             } error:^(NSError *error) {
                 @strongify(self)
                 [self.tableView.mj_header endRefreshing];
             } completed:^{
                 @strongify(self)
                 [self.tableView.mj_header endRefreshing];
             }];
            
        }];
        header.automaticallyChangeAlpha = YES;
        self.tableView.mj_header= header;
        
    }
    
    if (self.viewModel.shouldInfiniteScrolling) {
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            
            [[[self.viewModel.requestRemoteDataCommand
               execute:@(self.viewModel.page + 1)]
              deliverOnMainThread]
             subscribeNext:^(NSArray *results) {
                 @strongify(self)
                 self.viewModel.page += 1;
                 NSLog(@"---self.viewModel.page-------  %lu",self.viewModel.page);
             } error:^(NSError *error) {
                 @strongify(self)
                 [self.tableView.mj_footer endRefreshing];
             } completed:^{
                 @strongify(self)
                 [self.tableView.mj_footer endRefreshing];
             }];
        }];
        
        RAC(self.tableView.mj_footer, hidden) =  [[RACObserve(self.viewModel, dataSource)
                                                   deliverOnMainThread]
                                                  map:^(NSArray *dataSource) {
                                                      @strongify(self)
                                                      NSUInteger count = 0;
                                                      for (NSArray *array in dataSource) {
                                                          count += array.count;
                                                      }
                                                      [self.tableView reloadData];
                                                      return @(count < self.viewModel.perPage *self.viewModel.page);
                                                  }];
    }
}
- (void)dealloc {
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
}

- (void)bindViewModel {
    [super bindViewModel];
    
    @weakify(self)
    [[[RACObserve(self.viewModel, dataSource)
        distinctUntilChanged]
        deliverOnMainThread]
        subscribeNext:^(id x) {
            @strongify(self)
            [self reloadData];
        }];

    [self.viewModel.requestRemoteDataCommand.executing subscribeNext:^(NSNumber *executing) {
        @strongify(self)
        UIView *emptyDataSetView = [self.tableView.subviews.rac_sequence objectPassingTest:^(UIView *view) {
            return [NSStringFromClass(view.class) isEqualToString:@"DZNEmptyDataSetView"];
        }];
        emptyDataSetView.alpha = 1.0 - executing.floatValue;
    }];
}

- (void)reloadData {
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.dataSource ? self.viewModel.dataSource.count : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:@"MRCTableViewCellStyleValue1" forIndexPath:indexPath];
    
    id object = self.viewModel.dataSource[indexPath.section][indexPath.row];
    [self configureCell:cell atIndexPath:indexPath withObject:(id)object];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section >= self.viewModel.sectionIndexTitles.count) return nil;
    return self.viewModel.sectionIndexTitles[section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    //    if (self.searchBar != nil) {
    //        if (self.viewModel.sectionIndexTitles.count != 0) {
    //            return [self.viewModel.sectionIndexTitles.rac_sequence startWith:UITableViewIndexSearch].array;
    //        }
    //    }
    return self.viewModel.sectionIndexTitles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    //    if (self.searchBar != nil) {
    //        if (index == 0) {
    //            [tableView scrollRectToVisible:self.searchBar.frame animated:NO];
    //        }
    //        return index - 1;
    //    }
    return index;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.viewModel.didSelectCommand execute:indexPath];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //   [self.refreshControl scrollViewDidScroll];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //  [self.refreshControl scrollViewDidEndDragging];
    
    if (!decelerate) {
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    
}


#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"default_search"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"暂无相关结果";
    UIColor *color = [UIColor grayColor];
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
    return self.viewModel.dataSource == nil;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView {
    return CGPointMake(0, -(self.tableView.contentInset.top - self.tableView.contentInset.bottom) / 2);
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -100;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 20;
}

@end
