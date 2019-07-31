//
//  JCLStockNoticeModel.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/1.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCLStockMsgModel : NSObject
// 公告
@property (nonatomic, copy) NSString *noticeId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *ggtime;

// 研报
@property (nonatomic, copy) NSString *reporttime;
@property (nonatomic, copy) NSString *jgjc;
@property (nonatomic, copy) NSString *ybType;
@end
