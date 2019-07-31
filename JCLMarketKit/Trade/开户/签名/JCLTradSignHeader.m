//
//  JCLTradSignHeader.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/12/19.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradSignHeader.h"
#import "JCLWapList.h"
#import "JCLTablePop.h"
#import "AFNetworking.h"
#import "ReaderViewController.h"

@interface JCLTradSignHeader()<ReaderViewControllerDelegate>
@property (nonatomic, weak) UILabel *key1;
@property (nonatomic, weak) UILabel *val1;
@property (nonatomic, weak) UILabel *key2;
@property (nonatomic, weak) UILabel *val21;
@property (nonatomic, weak) UILabel *val22;
@property (nonatomic, weak) UILabel *key3;
@property (nonatomic, weak) UILabel *val3;

@property (nonatomic, weak) UILabel *up1;
@property (nonatomic, weak) UILabel *path1;
@property (nonatomic, weak) UILabel *msg1;

@property (nonatomic, weak) UILabel *up2;
@property (nonatomic, weak) UILabel *path2;
@property (nonatomic, weak) UILabel *msg2;

@property (nonatomic, weak) UIView *popBg;
@property (nonatomic, weak) JCLTablePop *pop;

@property (nonatomic, weak) UILabel *key4;
@property (nonatomic, weak) UILabel *val4;
@end

@implementation JCLTradSignHeader
-(instancetype)init{
    if(self = [super init]) {
        self.backgroundColor = JCL_Bg_COL;
        self.key1 = [JCLKitObj JCLLable:self font:15 color:JCL_Text_COL alignment:0];
        self.key1.text = @"1、下载个人开户信息PDF文件";
        self.val1 = [JCLKitObj JCLLable:self font:14 color:JCLHexCol(@"#A7A8AB") alignment:0];
        self.val1.text = @"系统会根据用户开户登记的资料，自动生产2个PDF文件";
        self.key2 = [JCLKitObj JCLLable:self font:15 color:JCL_Text_COL alignment:0];
        self.key2.text = @"2、使用docusign签署开户文件";
        self.val21 = [JCLKitObj JCLLable:self font:14 color:JCLHexCol(@"#CAA868") alignment:0];
        self.val21.text = @"签名范例说明";
        [self.val21 tapActionBlock:^{
            NSString *url = [NSString stringWithFormat:@"%@pageJump?type=4", JCLWebURL];
            [JCLHttpsObj JCLGetJson:url success:^(id obj) {
                if ([obj[@"code"] isEqualToString:@"0"]) {
                    UITabBarController *tabBar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                    UINavigationController *nav = (UINavigationController *)tabBar.selectedViewController;
                    JCLWapList *list = [[JCLWapList alloc]init];
                    list.name = @"签名范例说明";
                    list.url = obj[@"httpUrl"];
                    [nav pushViewController:list animated:YES];
                } else {
                    [JCLFramework JCLProgressHUD:obj[@"message"]];
                }
            } failure:^(NSError *error) { [JCLFramework JCLProgressHUD:@"网络错误请联系管理员"]; }];
        }];
        self.val22 = [JCLKitObj JCLLable:self font:14 color:JCLHexCol(@"#CAA868") alignment:0];
        self.val22.text = @"下载docusign软件";
        [self.val22 tapActionBlock:^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id474990205?mt=8"]];
        }];
        
        self.key3 = [JCLKitObj JCLLable:self font:15 color:JCL_Text_COL alignment:0];
        self.key3.text = @"3、使用docusign签名";
        NSMutableAttributedString *key3 = [[NSMutableAttributedString alloc]initWithString:self.key3.text];
        [key3 addAttribute:NSForegroundColorAttributeName
                     value:JCLHexCol(@"#CAA868")
                     range:NSMakeRange(4, 8)];
        self.key3.attributedText = key3;
        
        self.up1 = [JCLKitObj JCLLable:self font:13 color:JCL_Text_COL alignment:1];
        self.up1.text = @"请选择 签名 文件";
        self.up1.backgroundColor = JCLHexCol(@"#CAA868");
        self.up1.layer.cornerRadius = 4;
        [self.up1 tapActionBlock:^{
            [self uploadAction:@"path1"];
        }];
        
        self.key4 = [JCLKitObj JCLLable:self font:15 color:JCL_Text_COL alignment:0];
        self.key4.text = @"4、上传已签署的开户文件";
        NSMutableAttributedString *key4 = [[NSMutableAttributedString alloc]initWithString:self.key4.text];
        [key4 addAttribute:NSForegroundColorAttributeName
                     value:JCLHexCol(@"#CAA868")
                     range:NSMakeRange(4, 3)];
        self.key4.attributedText = key4;
        self.val4 = [JCLKitObj JCLLable:self font:14 color:JCLHexCol(@"#A7A8AB") alignment:0];
        NSString *url = @"http://47.100.108.27/nljj-cms/index/show";
        self.val4.text = [NSString stringWithFormat:@"使用docusign签署的文件，下载保存至本地后，上传至天使金融服务器。此文件将提交给西苑资本进行审核。\n pc端网页上传地址: %@", url];
        NSMutableAttributedString *val4 = [[NSMutableAttributedString alloc]initWithString:self.val4.text];
        [val4 addAttribute:NSForegroundColorAttributeName
                     value:JCLHexCol(@"#CAA868")
                     range:NSMakeRange(self.val4.text.length-url.length, url.length)];
        self.val4.attributedText = val4;
        [self.val4 tapActionBlock:^{
                    UITabBarController *tabBar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                    UINavigationController *nav = (UINavigationController *)tabBar.selectedViewController;
                    JCLWapList *list = [[JCLWapList alloc]init];
                    list.name = @"上传开户文件";
                    list.url = url;
                    [nav pushViewController:list animated:YES];
        }];
        
//        self.key3 = [JCLKitObj JCLLable:self font:15 color:JCL_Text_COL alignment:0];
//        self.key3.text = @"3、上传已签署的开户文件";
//        NSMutableAttributedString *key3 = [[NSMutableAttributedString alloc]initWithString:self.key3.text];
//        [key3 addAttribute:NSForegroundColorAttributeName
//                   value:JCLHexCol(@"#CAA868")
//                   range:NSMakeRange(4, 4)];
//        self.key3.attributedText = key3;
//        self.val3 = [JCLKitObj JCLLable:self font:14 color:JCLHexCol(@"#A7A8AB") alignment:0];
//        self.val3.text = @"使用 docusign 签署的文件，下载保存至本地后，上传至天使金融服务器。此文件将提交给西苑资本进行审核。";
//        NSMutableAttributedString *val3 = [[NSMutableAttributedString alloc]initWithString:self.val3.text];
//        [val3 addAttribute:NSForegroundColorAttributeName
//                     value:JCLHexCol(@"#CAA868")
//                     range:NSMakeRange(3, 8)];
//        self.val3.attributedText = val3;
//
//        self.up1 = [JCLKitObj JCLLable:self font:12 color:JCL_Text_COL alignment:1];
//        self.up1.text = @"请选择 Account ApplicationInformation 文件";
//        self.up1.backgroundColor = JCLHexCol(@"#CAA868");
//        self.up1.layer.cornerRadius = 4;
//        [self.up1 tapActionBlock:^{
//            [self uploadAction:@"path1"];
//        }];
//        self.path1 = [JCLKitObj JCLLable:self font:12 color:nil alignment:0];
//        self.path1.backgroundColor = JCLHexCol(@"#C9CACC");
//        self.path1.layer.cornerRadius = 4;
//        self.msg1 = [JCLKitObj JCLLable:self font:12 color:JCLHexCol(@"#CAA868") alignment:0];
//        self.msg1.text = @"(大小不要超过5M)";
//
//        self.up2 = [JCLKitObj JCLLable:self font:12 color:JCL_Text_COL alignment:1];
//        self.up2.text = @"请选择 Tax withholding and reportiong 文件";
//        self.up2.backgroundColor = JCLHexCol(@"#CAA868");
//        self.up2.layer.cornerRadius = 4;
//        [self.up2 tapActionBlock:^{
//            [self uploadAction:@"path2"];
//        }];
//        self.path2 = [JCLKitObj JCLLable:self font:12 color:nil alignment:0];
//        self.path2.backgroundColor = JCLHexCol(@"#C9CACC");
//        self.path2.layer.cornerRadius = 4;
//        self.msg2 = [JCLKitObj JCLLable:self font:12 color:JCLHexCol(@"#CAA868") alignment:0];
//        self.msg2.text = @"(大小不要超过5M)";
//
        self.act1 = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:nil];
//        self.act2 = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:nil];
//        self.act3 = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:nil];
        self.act1.title = @"下载"; self.act2.title = @"上传"; self.act3.title = @"上传";
    }
    return self;
}

-(void)uploadAction:(NSString *)style{
    NSArray *vals = [self JCLFileStyle:@"pdf"];
    self.popBg = [JCLKitObj JCLView:[AppDelegate shareAppDelegate].window color:JCLRGBA(0, 0, 0, 0.1)];
    self.popBg.frame = CGRectMake(0, 0, JCLWIDTH, JCLHEIGHT);
    [self.popBg tapActionBlock:^{
        [self.popBg removeFromSuperview]; [self.pop removeFromSuperview];
    }];
    
    JCLTablePop *pop = [[JCLTablePop alloc]init]; [[AppDelegate shareAppDelegate].window addSubview:pop];
    CGFloat h = vals.count*[JCLKitObj JCLHeight:44];
    pop.frame = CGRectMake(0, 0.5*(JCLHEIGHT-h), JCLWIDTH, h);
    pop.arr = vals;
    pop.cellActionBlock = ^(NSInteger idx){
        NSString *path = CachesFile(vals[idx]);
        NSFileManager *file = [NSFileManager defaultManager];
        if ([file fileExistsAtPath:path]) {
            [file removeItemAtPath:path error:nil];
            pop.arr = [self JCLFileStyle:@"pdf"];
            [pop.table reloadData];
        }
    };
    pop.actionBlock = ^(NSInteger idx){
        ReaderDocument *doc = [[ReaderDocument alloc] initWithFilePath:CachesFile(vals[idx]) password:nil];
        ReaderViewController *rederVC = [[ReaderViewController alloc] initWithReaderDocument:doc];
        rederVC.delegate = self;
        rederVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        rederVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:rederVC animated:YES completion:nil];
        
        [self.popBg removeFromSuperview]; [self.pop removeFromSuperview];
//        NSString *val = CachesFile(vals[idx]), *type = @"";
//        if ([style isEqualToString:@"path1"]) {
//            self.path1.text = CachesFile(vals[idx]);
//            type = @"1";
//        } else {
//            self.path2.text = CachesFile(vals[idx]);
//            type = @"2";
//        }
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        NSString *url = [NSString stringWithFormat:@"%@upLoadPdfFile?phone=%@&type=%@", JCLOpenURL, [JCLUserData getUserInfo].username, type];
//        [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//            [formData appendPartWithFileData:[NSData dataWithContentsOfFile:val] name:@"file" fileName:vals[idx] mimeType:@"application/pdf"];
//        } progress:^(NSProgress * _Nonnull uploadProgress) {
//            NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            [JCLFramework JCLProgressHUD:@"上传成功"];
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            [JCLFramework JCLProgressHUD:@"上传失败"];
//        }];
    };
    self.pop = pop;
}
- (void)dismissReaderViewController:(ReaderViewController *)viewController{
    [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

-(NSArray *)JCLFileStyle:(NSString *)style{
    NSFileManager *file = [NSFileManager defaultManager];
    NSString *path = CachesFile(@"");
    NSDirectoryEnumerator *direnum = [file enumeratorAtPath:path];
    NSMutableArray *files = [[NSMutableArray alloc]init];
    NSString *obj;
    while(obj = [direnum nextObject]){
        if ([[obj pathExtension] isEqualToString:style]){
            [files addObject:obj];
        }
    }
    return files;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat x = 14, y = 10;
    CGSize size = [JCLKitObj JCLTextSize:self.key1.text font:self.key1.font];
    self.key1.frame = CGRectMake(x, 20, size.width, size.height);
    CGSize size1 = [JCLKitObj JCLTextSize:self.val1.text font:self.val1.font width:0.7*self.width];
    self.val1.frame = CGRectMake(3*x-3, self.key1.maxY, size1.width, size1.height);
    
    self.key2.frame = CGRectMake(x, self.val1.maxY+y, size.width, size.height);
    CGSize size2 = [JCLKitObj JCLTextSize:self.val21.text font:self.val21.font width:0.7*self.width];
    self.val21.frame = CGRectMake(3*x-2, self.key2.maxY, self.width, size2.height);
    self.val22.frame = CGRectMake(3*x-2, self.val21.maxY-14, self.width, size2.height);
    
    self.key3.frame = CGRectMake(x, self.val22.maxY+y, size.width, size.height);
    self.up1.frame = CGRectMake(self.val1.x, self.key3.maxY+y, self.val1.width,  1.6*size.height);
    
    self.key4.frame = CGRectMake(x, self.up1.maxY+2*y, size.width, size.height);
    CGSize size4 = [JCLKitObj JCLTextSize:self.val4.text font:self.val4.font width:0.7*self.width];
    self.val4.frame = CGRectMake(self.val1.x, self.key4.maxY+y-8, size4.width, size4.height);

//    self.key3.frame = CGRectMake(x, self.val22.maxY+y, size.width, size.height);
//    CGSize size3 = [JCLKitObj JCLTextSize:self.val3.text font:self.val3.font width:0.7*self.width];
//    self.val3.frame = CGRectMake(3*x-3, self.key3.maxY, size3.width, size3.height);
//
//    self.up1.frame = CGRectMake(self.val3.x, self.val3.maxY+y, self.val3.width,  1.4*size.height);
//    self.path1.frame = CGRectMake(self.val3.x, self.up1.maxY+y, self.val3.width, 1.4*size.height);
//    self.msg1.frame = CGRectMake(self.val3.x, self.path1.maxY+4, self.val3.width, size.height);
//
//    self.up2.frame = CGRectMake(self.val3.x, self.msg1.maxY+y, self.val3.width, 1.4*size.height);
//    self.path2.frame = CGRectMake(self.val3.x, self.up2.maxY+y, self.val3.width, 1.4*size.height);
//    self.msg2.frame = CGRectMake(self.val3.x, self.path2.maxY+4, self.val3.width, size.height);
//
    CGFloat actW = 0.18*self.width;
    self.act1.frame = CGRectMake(self.width-actW, self.key1.y+8, actW, size.height);
//    self.act2.frame = CGRectMake(self.width-actW, self.up1.y+8, actW, size.height);
//    self.act3.frame = CGRectMake(self.width-actW, self.up2.y+8, actW, size.height);
}
@end
