//
//  NSData+CRC32.h
//  CRC32_iOS
//
//  Created by 宣佚 on 15/7/14.
//  Copyright (c) 2015年 宣佚. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <zlib.h>

@interface NSData (CRC32)

-(uint32_t)getCRC32Value;
- (uLong)CRC32Value ;

@end
