
#import "FMDB.h"
@interface MMDBManager : NSObject

/**
 *  DB队列（除IM相关）
 */
@property (nonatomic, strong) FMDatabaseQueue *commonQueue;

/**
 *  与IM相关的DB队列
 */
@property (nonatomic, strong) FMDatabaseQueue *myQueue;

+ (MMDBManager *)sharedInstance;

@end
