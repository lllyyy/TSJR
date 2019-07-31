//
//  JCLStockIdxList.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/11/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "JCLStockIdxList.h"
#import "JCLStockIdxCell.h"

@interface JCLStockIdxList ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collec;
@property (nonatomic, weak) UIPageControl *page;
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation JCLStockIdxList
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
        layout.minimumLineSpacing = 0;
        //  layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collec = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        collec.delegate = self; collec.dataSource = self; [self addSubview:collec];
        collec.pagingEnabled = true; collec.showsHorizontalScrollIndicator = false;
        collec.backgroundColor = [UIColor clearColor];
        [collec registerClass:[JCLStockIdxCell class] forCellWithReuseIdentifier:@"cell"];
        self.collec = collec;
        
//        UIPageControl *page = [[UIPageControl alloc]init]; [self addSubview:page];
//        self.page.frame = CGRectMake(0, self.bounds.size.height - 40, self.bounds.size.width, 40);
//        page.pageIndicatorTintColor = [UIColor lightGrayColor];
//        page.currentPageIndicatorTintColor = [UIColor blackColor];
//        self.page = page;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(showNext) userInfo:nil repeats:true];
    }
    return self;
}

#pragma mark -
#pragma mark CollectionViewDelegate&DataSource
- (void)setVals:(NSArray *)vals{
    _vals = vals;
//    [self.titles addObjectsFromArray:vals];
//    [self.titles addObject:vals.firstObject];
//    [self.titles insertObject:vals.lastObject atIndex:0];
    [self.collec setContentOffset:CGPointMake(0, self.collec.bounds.size.height)];
    //self.page.numberOfPages = vals.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section { return self.vals.count; }
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    JCLStockIdxCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    NSDictionary *obj = self.vals[indexPath.row];
    cell.code = obj[@"obj"];
    cell.price = obj[@"obj"];
    cell.range = obj[@"obj"];
    cell.scale = obj[@"obj"];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:2]]; [self cycleScroll];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView { [self cycleScroll]; }
- (void)cycleScroll{
    NSInteger page = self.collec.contentOffset.y/self.collec.bounds.size.height;
    if (page == 0) {
        self.collec.contentOffset = CGPointMake(0, self.collec.bounds.size.height * (self.vals.count - 2));
        self.page.currentPage = self.vals.count - 2;
    }else if (page == self.vals.count - 1){
        self.collec.contentOffset = CGPointMake(0, self.collec.bounds.size.height);
        self.page.currentPage = 0;
    }else{
        self.page.currentPage = page - 1;
    }
}
- (void)showNext{
    if (self.collec.isDragging) { return; }
    [self.collec setContentOffset:CGPointMake(0, self.collec.contentOffset.y + self.collec.bounds.size.height) animated:YES];
}
- (void)dealloc { [self.timer invalidate]; }
@end
