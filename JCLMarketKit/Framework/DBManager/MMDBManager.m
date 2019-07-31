 
#import "MMDBManager.h"

#import "NSFileManager+MMChat.h"

static MMDBManager *manager;

@implementation MMDBManager

+ (MMDBManager *)sharedInstance
{
    static dispatch_once_t once;
   
    dispatch_once(&once, ^{
        manager = [[MMDBManager alloc] initWithUserID:userId()];
    });
    return manager;
}

- (id)initWithUserID:(NSString *)userID
{
    if (self = [super init]) {
        NSString *commonQueuePath = [NSFileManager pathDBCommonDB];
        self.commonQueue = [FMDatabaseQueue databaseQueueWithPath:commonQueuePath];
     
        NSString *messageQueuePath = [NSFileManager pathDBMyself];
        self.myQueue = [FMDatabaseQueue databaseQueueWithPath:messageQueuePath];
        
    }
    return self;
}

- (id)init
{
    NSLog(@"MMDBManager：请使用 initWithUserID: 方法初始化");
    return nil;
}

@end
