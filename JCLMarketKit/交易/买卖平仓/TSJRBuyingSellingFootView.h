//
//  TSJRBuyingSellingFootView.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/17.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSJRBuyingSellingFootView : UIView
@property (nonatomic,strong) UILabel *descLB;
@property (nonatomic,strong) UILabel *priceLB;
@property (nonatomic,strong) UILabel *amountLB;
@property (nonatomic,strong) UILabel *lineA;

@property (nonatomic,strong) UILabel *amountDescLB;
@property (nonatomic,strong) UILabel *limitLB;
@property (nonatomic,strong) UIButton *effectiveBtn;
@property (nonatomic,strong) UILabel *plateLB;


@property (nonatomic,strong) UIButton *noAllowbtn;
@property (nonatomic,strong) UIButton *allowbtn;
@property (nonatomic,strong) UILabel *linbg;
@end

NS_ASSUME_NONNULL_END
