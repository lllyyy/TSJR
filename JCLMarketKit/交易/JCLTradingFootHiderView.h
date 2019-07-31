//
//  JCLTradingFootHiderView.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/12.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCLTradingFootHiderView : UIView

@property (nonatomic,strong) UIButton *stocksBtn;
@property (nonatomic,strong) UIImageView *stocksimg;
@property (nonatomic,strong) UILabel *stocksLB;

@property (nonatomic,strong) UIButton *detailBtn;
@property (nonatomic,strong) UIImageView *detailimg;
@property (nonatomic,strong) UILabel *detailLB;

@property (nonatomic,strong) UIButton *updateBtn;
@property (nonatomic,strong) UIImageView *updateimg;
@property (nonatomic,strong) UILabel *updateLB;

@property (nonatomic,strong) UIButton *undolBtn;
@property (nonatomic,strong) UIImageView *undoimg;
@property (nonatomic,strong) UILabel *undoLB;

@end

NS_ASSUME_NONNULL_END
