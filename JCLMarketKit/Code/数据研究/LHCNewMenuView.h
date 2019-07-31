//
//  LHCNewMenuView.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/6/20.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHCNewMenuView : UIScrollView
@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,copy  ) void (^ChangeBlock) (NSInteger idx);
@end
