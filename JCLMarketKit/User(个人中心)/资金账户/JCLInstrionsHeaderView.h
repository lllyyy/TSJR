//
//  JCLInstrionsHeaderView.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/21.
//  Copyright © 2019 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCLInstrionsHeaderView : UIView
@property (nonatomic, strong) UIButton *title;
@property (nonatomic, strong) UIImageView *more;
@property (nonatomic, copy) void(^infoActionBlock)(UIButton *sender);
@end

NS_ASSUME_NONNULL_END
