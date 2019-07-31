//
//  LHCMenuScrollView.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/4/26.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHCMenuScrollView : UIScrollView
@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,copy  ) void (^ChangeBlock) (NSInteger idx);
@end
