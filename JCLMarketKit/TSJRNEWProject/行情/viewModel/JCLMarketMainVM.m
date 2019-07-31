//
//  JCLMarketMainVM.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/21.
//  Copyright © 2019 邢昭俊. All rights reserved.
//

#import "JCLMarketMainVM.h"

@implementation JCLMarketMainVM
- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(NSDictionary *)params {
    self = [super initWithServices:services params:params];
    if (self) {
        
    }
    return self;
}

- (void)initialize {
    [super initialize];
    self.title = @"行情";
    
}
@end
