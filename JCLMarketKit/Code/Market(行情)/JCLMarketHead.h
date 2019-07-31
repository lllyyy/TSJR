//
//  QuotationTableHeader.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/9/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLMarketHead : UIView
@property (nonatomic, weak) UIButton *title;
@property (nonatomic, weak) UIButton *more;
@property (nonatomic, copy) void(^infoActionBlock)(UIButton *sender);
@end
