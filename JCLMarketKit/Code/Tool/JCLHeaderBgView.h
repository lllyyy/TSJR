//
//  JCLHeaderBgView.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/28.
//  Copyright © 2017年 刘虎超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLHeaderBgView : UIView
@property (nonatomic,strong) NSArray *titleArr;
- (void)setupHeaderArray:(NSArray *)array;
@end
