//
//  YSBaseList.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/24.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "YSKitList.h"

@interface YSKitList ()
@end

@implementation YSKitList
- (NSMutableArray *)arrM{
    if (_arrM)
     return _arrM;
    return _arrM = [[NSMutableArray alloc]init];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navi.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = JCLBGRGB;
}
@end
