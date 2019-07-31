//
//  JCLBunsinessCellModel.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/4/14.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCLBunsinessCellModel : NSObject
@property (nonatomic,assign) BOOL isOpen;
@property (nonatomic,strong) NSString *relate_company_id;
@property (nonatomic,strong) NSString *relate_company_name;
@property (nonatomic,assign) NSInteger relate_count;
@property (nonatomic,strong) NSString *relate_symbols;
@end
