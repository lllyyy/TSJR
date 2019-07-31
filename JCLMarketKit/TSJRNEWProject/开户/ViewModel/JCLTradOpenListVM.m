//
//  JCLTradOpenListVM.m
//  
//
//  Created by 卢杨 on 2019/2/21.
//

#import "JCLTradOpenListVM.h"

@implementation JCLTradOpenListVM
- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(NSDictionary *)params {
    self = [super initWithServices:services params:params];
    if (self) {
        
    }
    return self;
}

- (void)initialize {
    [super initialize];
    self.title = @"开户";
    
}
@end
