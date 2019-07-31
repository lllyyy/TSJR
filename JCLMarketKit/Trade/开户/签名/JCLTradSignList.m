//
//  JCLTradSignList.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/12/19.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradSignList.h"
#import "JCLTradSignHeader.h"
#import "JCLUserSubmit.h"
#import "AFNetworking.h"
#import "ReaderViewController.h"

@interface JCLTradSignList ()<ReaderViewControllerDelegate>
@end

@implementation JCLTradSignList
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navi.middle.title = @"签署文件";
    JCLTradSignHeader *header = [[JCLTradSignHeader alloc]init];
    header.height = 0.76*JCLSCROLL;

    [header.act1 tapActionBlock:^{
        NSString *url = [NSString stringWithFormat:@"%@downLoadPdfFile?phone=%@", JCLOpenURL, [JCLUserData getUserInfo].username];
        [JCLHttpsObj JCLGetJson:url success:^(id obj) {
            if([obj[@"code"] isEqualToString:@"0"]){
                [self downLoadFile:obj[@"accFile"] name:obj[@"accFileName"]];
                [self downLoadFile:obj[@"taxFile"] name:obj[@"taxFileName"]];
            } else {
                [JCLFramework JCLProgressHUD:obj[@"message"]];
            }
        } failure:^(NSError *error) { [JCLFramework JCLProgressHUD:@"请求超时请联系管理员!"]; }];
    }];
    self.table.tableHeaderView = header;
    
    JCLUserSubmit *footer = [[JCLUserSubmit alloc]init];
    footer.submit.title = @"完成签署";
    [footer.submit tapActionBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    footer.height = 0.16*JCLHEIGHT;
    self.table.tableFooterView = footer;
}

-(void)downLoadFile:(NSString *)path name:(NSString *)name{
    [JCLFramework JCLProgressHUD:@"正在下载请稍等!"];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    NSURLSessionDownloadTask *download = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
        NSOperationQueue *main = [NSOperationQueue mainQueue];
        [main addOperationWithBlock:^{ }];
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *path = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [path URLByAppendingPathComponent:name];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        [JCLFramework JCLProgressHUD:@"下载完成"];
    }];
    [download resume];
}
@end
