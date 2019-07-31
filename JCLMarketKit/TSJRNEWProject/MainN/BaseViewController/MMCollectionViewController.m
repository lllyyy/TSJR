
#import "MMCollectionViewController.h"
#import "MJRefresh.h"

@interface MMCollectionViewController ()
//@property (nonatomic, weak, readwrite) UICollectionView *collectionViews;
@property (nonatomic, strong, readonly) MRCTableViewModel *viewModel;

@end

@implementation MMCollectionViewController

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
    if ([view isKindOfClass:UICollectionView.class]) self.collectionViews = (UICollectionView *)view;
}

- (UIEdgeInsets)contentInset {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.collectionViews.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    [self.collectionViews registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    [self.collectionViews registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
   
    
    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionViews = [[UICollectionView alloc] initWithFrame: CGRectMake(0, JCLNAVI, kScreenWidth, kScreenHeight - JCLNAVI) collectionViewLayout:layout];
    self.collectionViews.backgroundColor = [UIColor clearColor];
    self.collectionViews.delegate = self;
    self.collectionViews.dataSource = self;
    self.collectionViews.showsVerticalScrollIndicator = NO;
  
    [self.view addSubview:self.collectionViews];
//    [self.view insertSubview:self.customNavBar aboveSubview:self.collectionViews];
    [self setupRefresh];
    self.collectionViews.emptyDataSetSource = self;
    self.collectionViews.emptyDataSetDelegate = self;
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
                 [self.collectionViews.mj_header endRefreshing];
             } completed:^{
                 @strongify(self)
                 [self.collectionViews.mj_header endRefreshing];
             }];
            
        }];
        header.automaticallyChangeAlpha = YES;
        self.collectionViews.mj_header= header;
        
    }
    
    if (self.viewModel.shouldInfiniteScrolling) {
        self.collectionViews.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [[[self.viewModel.requestRemoteDataCommand
               execute:@(self.viewModel.page + 1)]
              deliverOnMainThread]
             subscribeNext:^(NSArray *results) {
                 @strongify(self)
                 self.viewModel.page += 1;
             } error:^(NSError *error) {
                 @strongify(self)
                 [self.collectionViews.mj_footer endRefreshing];
             } completed:^{
                 @strongify(self)
                 [self.collectionViews.mj_footer endRefreshing];
             }];
        }];
        
        RAC(self.collectionViews.mj_footer, hidden) =  [[RACObserve(self.viewModel, dataSource)
                                                   deliverOnMainThread]
                                                  map:^(NSArray *dataSource) {
                                                      @strongify(self)
                                                      NSUInteger count = 0;
                                                      for (NSArray *array in dataSource) {
                                                          count += array.count;
                                                      }
                                                      [self.collectionViews reloadData];
                                                      return @(count < self.viewModel.perPage *self.viewModel.page);
                                                  }];
    }
}


- (void)dealloc {
    _collectionViews.dataSource = nil;
    _collectionViews.delegate = nil;
}
 
- (void)bindViewModel {
    [super bindViewModel];
    
    @weakify(self)
    [RACObserve(self.viewModel, dataSource).distinctUntilChanged.deliverOnMainThread subscribeNext:^(id x) {
        @strongify(self)
        [self.collectionViews reloadData];
    }];
    
    [self.viewModel.requestRemoteDataCommand.executing subscribeNext:^(NSNumber *executing) {
        @strongify(self)
        UIView *emptyDataSetView = [self.collectionViews.subviews.rac_sequence objectPassingTest:^(UIView *view) {
            return [NSStringFromClass(view.class) isEqualToString:@"DZNEmptyDataSetView"];
        }];
        emptyDataSetView.alpha = 1.0 - executing.floatValue;
    }];
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    return  [collectionView  dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
}

- (void)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [self.collectionViews  dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    id object = self.viewModel.dataSource[indexPath.section][indexPath.row];
    [self configureCell:cell atIndexPath:indexPath withObject:(id)object];
    
    return cell;
}

//头部显示的内容
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//
//    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
//                                            UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
//    headerView.backgroundColor = [UIColor clearColor];
//
//
//
//    UILabel *headerTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 100, 20) ] ;
//    headerTitleLabel.textColor = TitleAColor;
//    headerTitleLabel.font = [UIFont systemFontOfSize:12];
//    [headerView addSubview: headerTitleLabel];
//
//    NSString *title = @"";
//    if (indexPath.section >= self.viewModel.sectionIndexTitles.count) title = @"";
//        headerTitleLabel. text = self.viewModel.sectionIndexTitles[indexPath.section];
//
//
//    return headerView;
//}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

 
//
////定义展示的Section的个数
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return self.viewModel.dataSource ? self.viewModel.dataSource.count : 1;
//}
//
////定义展示的UICollectionViewCell的个数
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return [self.viewModel.dataSource[section] count];
//}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel.didSelectCommand execute:indexPath];
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
     return CGPointMake(0, -(self.collectionViews.contentInset.top - self.collectionViews.contentInset.bottom) / 2);
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -100;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 20;
}



 

@end
