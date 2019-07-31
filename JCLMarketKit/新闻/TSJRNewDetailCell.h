//
//  TSJRNewDetailCell.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/21.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "DTAttributedTextCell.h"
typedef void(^GetCellHeight)(CGFloat inputMode);
NS_ASSUME_NONNULL_BEGIN

@interface TSJRNewDetailCell : DTAttributedTextCell
<DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate>
 
@property (nonatomic, strong) DTAttributedTextView *attributedTextView;
@property (nonatomic,copy) GetCellHeight getCellHeight;


@end

NS_ASSUME_NONNULL_END
