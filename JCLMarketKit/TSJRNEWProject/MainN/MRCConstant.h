 
#ifndef MVVMReactiveCocoa_MRCConstant_h
#define MVVMReactiveCocoa_MRCConstant_h

///------
/// NSLog
///------

#ifdef DEBUG
    #define NSLog(...) NSLog(__VA_ARGS__)
#else
    #define NSLog(...) {}
#endif

#define MRCLogError(error) NSLog(@"Error: %@", error)

///------
/// Block
///------

typedef void (^VoidBlock)();
typedef BOOL (^BoolBlock)();
typedef int  (^IntBlock) ();
typedef id   (^IDBlock)  ();

typedef void (^VoidBlock_int)(int);
typedef BOOL (^BoolBlock_int)(int);
typedef int  (^IntBlock_int) (int);
typedef id   (^IDBlock_int)  (int);

typedef void (^VoidBlock_string)(NSString *);
typedef BOOL (^BoolBlock_string)(NSString *);
typedef int  (^IntBlock_string) (NSString *);
typedef id   (^IDBlock_string)  (NSString *);

typedef void (^VoidBlock_id)(id);
typedef BOOL (^BoolBlock_id)(id);
typedef int  (^IntBlock_id) (id);
typedef id   (^IDBlock_id)  (id);



///------
/// Color
///------

#define RGB(r, g, b) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBAlpha(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HexRGBAlpha(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]



#define MRC_PLACEHOLDER_IMAGE [HexRGB(0xEDEDED) color2Image]

#define MRC_EMPTY_PLACEHOLDER @"Not Set"

#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define MRC_ALERT_TITLE @"Tips"
#define MBPROGRESSHUD_LABEL_TEXT @"Loading..."

#define MRC_LEFT_IMAGE_SIZE CGSizeMake(25, 25)
#define MRC_1PX_WIDTH (1 / [UIScreen mainScreen].scale)

///---------
/// App Info
///---------

#define MRCApplicationVersionKey @"MRCApplicationVersionKey"

#define MRC_APP_ID               @"961330940"
 

#define MRC_APP_NAME    ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"])
#define MRC_APP_VERSION ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
#define MRC_APP_BUILD   ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])

///-----------------------------
/// MVVMReactiveCocoa Repository
///-----------------------------

#define MVVM_REACTIVECOCOA_OWNER_LOGIN @"leichunfeng"
#define MVVM_REACTIVECOCOA_NAME        @"MVVMReactiveCocoa"

#define MRC_README_CSS_STYLE @"<style type=\"text/css\">body { font-family: \"Helvetica Neue\", Helvetica, \"Segoe UI\", Arial, freesans, sans-serif; }</style>"

///------------
/// UMengSocial
///------------



///-----
/// FMDB
///-----

#define MRC_FMDB_PATH [NSString stringWithFormat:@"%@/%@.db", MRC_DOCUMENT_DIRECTORY, MRC_APP_NAME]
#define MRCLogLastError(db) NSLog(@"lastError: %@, lastErrorCode: %d, lastErrorMessage: %@", [db lastError], [db lastErrorCode], [db lastErrorMessage]);

///-------------
/// Notification
///-------------

#define MRCStarredReposDidChangeNotification   @"MRCStarredReposDidChangeNotification"
#define MRCRecentSearchesDidChangeNotification @"MRCRecentSearchesDidChangeNotification"

///--------
/// Bugtags
///--------

#define MRC_BUGTAGS_APP_KEY @"69f973866d636e2b4b3f42ef1ec2caec"

///--------
/// Device
///--------

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

///--------
/// Version
///--------

#define IOS11 @available(iOS 11.0, *)

#endif
