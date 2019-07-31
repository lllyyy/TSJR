//
//  JCLUserRegisterList.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/15.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLUserRegisterList.h"
#import "JCLUserLoginHeader.h"
#import "JCLTableInfoCell.h"
#import "JCLUserSubmit.h"

@interface JCLUserRegisterList ()
@property (nonatomic, strong) NSString *code;
@end

@implementation JCLUserRegisterList
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navi.middle.title = @"注册";
    self.navi.backgroundColor = JCLHexCol(@"#FEFFFE");
    self.navi.bg.backgroundColor = JCLHexCol(@"#FEFFFE");
    self.navi.left.img = @"关闭";
    
    JCLUserLoginHeader *header = [[JCLUserLoginHeader alloc]init];
    header.backgroundColor = JCLHexCol(@"#FEFFFE");
    header.icon.title = @"  HI, 欢迎注册";
    header.icon.titleLabel.font = [JCLKitObj JCLFont:24];
    header.icon.contentHorizontalAlignment = 1;
    header.height = 0.14*JCLHEIGHT;
    self.table.tableHeaderView = header;
    
    self.titles = @[@"手机号", @"验证码", @"设置密码", @"确认密码"];
    self.texts = @[@"请输入手机号", @"请输入验证码", @"请输入密码", @"请重复输入密码"];
    [self.texts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.vals addObject:@""];
    }];
    JCLUserSubmit *footer = [[JCLUserSubmit alloc]init];
    footer.submit.title = @"立即注册";
    [footer.submit tapActionBlock:^{
        [self.view endEditing:YES];
        if (![self.vals[0] length]) { [JCLFramework showErrorHud:@"请输入手机号"]; return; }
        if (![self.vals[1] length]) { [JCLFramework showErrorHud:@"请输入验证码"]; return; }
        if (![self.vals[2] length]) { [JCLFramework showErrorHud:@"请输入密码"]; return; }
        if (![self.vals[3] length]) { [JCLFramework showErrorHud:@"请重复输入密码"]; return; }
        if (![self.vals[1] isEqualToString:self.code]) { [JCLFramework showErrorHud:@"请输入正确的验证码"]; return; }
        if (![self.vals[2] isEqualToString:self.vals[3]]) { [JCLFramework showErrorHud:@"密码输入错误"]; return; }
        NSString *secure = self.vals[2];
        if (secure.length<6) { [JCLFramework showErrorHud:@"密码长度错误"]; return; }
//        NSDictionary *dic = @{ @"password": self.vals[2] };
//        NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:NULL];
//        NSString *url = [NSString stringWithFormat:@"%@userRegister?phone=%@&password=%@&location=ios",
//                         JCLWebURL,
//                         [self.vals[0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
//                         [data base64EncodedStringWithOptions:0]];
//        [JCLHttps getJson:url success:^(id obj) {
//            if ([obj[@"code"] isEqualToString:@"0"]) {
//                [self.navigationController popViewControllerAnimated:YES];
//                [self dismissViewControllerAnimated:YES completion:^{ }];
//            }
//            [JCLFramework showSuccess:obj[@"message"]];
//        } failure:^(NSError *error) { [JCLFramework showErrorHud:@"网络超时，请您检查网络"];
//
//        }];
//
         NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlA,@"register"];
        [JCLHttps httpPOSTRequest:postUrl params:@{@"phone":self.vals[0],@"password":self.vals[2]} success:^(id obj) {
            MMResultV2Model *model = obj;
            if (model.code.intValue == 200) {
                [self.navigationController popViewControllerAnimated:YES];
                [self dismissViewControllerAnimated:YES completion:^{ }];
            }
            [JCLKitObj showMsg:model.message];
            NSLog(@"objobj  %@",obj);
            
        } failure:^(NSError *error) {
            [JCLFramework showErrorHud:@"服务器异常"];
        }];
        
    }];

    footer.height = 0.166*JCLHEIGHT;
    footer.backgroundColor = JCLHexCol(@"#FEFFFE");
    self.table.tableFooterView = footer;
    
    self.table.backgroundColor = JCLHexCol(@"#FEFFFE");
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.texts.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.07*JCLHEIGHT;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JCLTableInfoCell *cell = [JCLTableInfoCell cellWithTable:tableView];
    NSString *val = self.titles[indexPath.row];
    cell.text.placeholder = self.texts[indexPath.row];
    cell.text.text = self.vals[indexPath.row];
    [cell.text setClearButtonMode:UITextFieldViewModeWhileEditing];
    cell.valActionBlock = ^(NSString *val){
        [self.vals replaceObjectAtIndex:indexPath.row withObject:val];
    };
    cell.title.text = val;
    cell.text.placeholder = self.texts[indexPath.row];
    cell.valActionBlock = ^(NSString *val){
        [self.vals replaceObjectAtIndex:indexPath.row withObject:val];
    };
    if (indexPath.row == 1) {
        cell.text.secureTextEntry = YES;
        cell.text.keyboardType = UIKeyboardTypeDefault;
    } else {
        cell.text.keyboardType = UIKeyboardTypeNumberPad;
    }

    if (indexPath.row == 1) {
        cell.code.title = @"获取验证码";
        cell.code.color = [UIColor blackColor];
        cell.code.contentHorizontalAlignment = 2;
        cell.code.frame = CGRectMake(JCLWIDTH-0.22*JCLWIDTH-14, 0, 0.22*JCLWIDTH, 0.074*JCLHEIGHT-1);
        [cell.code tapActionBlock:^{
            [self.view endEditing:YES];
            NSString *phone = self.vals[0];
            
            if (phone.length!=11) {
                 [JCLKitObj showMsg:@"手机号格式错误"];
                return;
           }
            NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlA,@"validatePhone"];
            [JCLHttps httpPOSTRequest:postUrl params:@{@"phone":self.vals[0],@"type":@"a"} success:^(id obj) {
                MMResultV2Model *model = obj;
                if (model.code.intValue == 200) {
                     self.code = model.data[@"code"];
                     [cell codeAction];
                }
             [JCLKitObj showMsg:model.message];
                NSLog(@"objobj  %@",obj);
                
            } failure:^(NSError *error) {
                [JCLFramework showErrorHud:@"网络超时，请您检查网络"];
            }];
            
           // NSString *url=[NSString stringWithFormat:@"%@getMsg?phone=%@",JCLWebURL, self.vals[0]];
         //   NSLog(@"---------- %@",url);
//            [JCLHttps getJson:url success:^(id obj) {
//                 NSLog(@"---obj------- %@",obj);
//                if([obj[@"code"] isEqualToString:@"0"]){
//                    self.code = obj[@"messagecode"];
//                    NSLog(@"---code------- %@",obj[@"messagecode"]);
//                    [cell codeAction];
//                } else {
//                    [JCLFramework showErrorHud:obj[@"messagecode"]];
//                }
//            } failure:^(NSError *error) { [JCLFramework showErrorHud:@"网络超时，请您检查网络"]; }];
        }];
    }
    
    if (indexPath.row >= 2) {
        cell.text.secureTextEntry = YES;
        cell.text.keyboardType = UIKeyboardTypeDefault;
    } else {
        cell.text.secureTextEntry = NO;
        cell.text.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    cell.backgroundColor = JCLHexCol(@"#F1F2F1");
    cell.bg.backgroundColor = JCLHexCol(@"#FEFFFE");
    cell.text.textColor = nil;
    cell.title.textColor = nil;
    return cell;
}
@end
