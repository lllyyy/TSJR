//
//  JCLInputList.m
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/19.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLUserInputList.h"
#import "JCLUserInputCell.h"
#import "JCLUserSubmit.h"

@interface JCLUserInputList ()
@property (nonatomic, strong) JCLUserInputCell *cell;
@end

@implementation JCLUserInputList
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navi.middle.title = self.name;
    JCLUserSubmit *footer = [[JCLUserSubmit alloc]init];
    footer.submit.title = @"确定";
    [footer.submit tapActionBlock:^{
        [self.view endEditing:YES];
        
        NSString *url;
        if ([self.name isEqualToString:@"邮箱"]) {
            url = [NSString stringWithFormat:@"%@sendEmail?phone=%@&toUser=%@", JCLWebURL,
                   [JCLUserData getUserInfo].username,
                   [self.cell.field.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                   ];
           // [self setNeedData:url];
        }
//        个人中心里的修改密码  changePwd?userId=1090895223455744001&oldPassword= &newPassword=
        if ([self.name isEqualToString:@"修改密码"]) {
            JCLUserInputCell *origin_secure = self.table.visibleCells[0];
            JCLUserInputCell *new_Secure = self.table.visibleCells[1];
            JCLUserInputCell *sure_secure = self.table.visibleCells[2];
            if (new_Secure.field.text.length<6) {
                 [JCLFramework showErrorHud:@"密码长度不能小于6位!"];
                return;
            }
            if (sure_secure.field.text.length<6) {
                 [JCLFramework showErrorHud:@"密码长度不能小于6位!"];
                return;
            }
            if (![[JCLUserData getUserInfo].password isEqualToString:origin_secure.field.text]) {
                
                [JCLFramework showErrorHud:@"原密码错误!"];
                return;
            }
            if (!new_Secure.field.text) {
                
                [JCLFramework showErrorHud:@"请输入新密码!"];
                return;
            }
            if (!sure_secure.field.text) {
                
                [JCLFramework showErrorHud:@"请再次输入新密码!"];
                return;
            }
            if (![new_Secure.field.text isEqualToString:sure_secure.field.text]) {
                
                [JCLFramework showErrorHud:@"新密码和确认密码不一致!"];
                return;
            }
          
//            NSDictionary *dic = @{ @"newPwd": new_Secure.field.text,@"oldPwd":origin_secure.field.text};
//            NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:NULL];
//            url = [NSString stringWithFormat:@"%@userUpdPwd?password=%@&phone=%@",
//                   JCLWebURL,
//                   [data base64EncodedStringWithOptions:0],[JCLUserData getUserInfo].username];
            url =@"changePwd";
            NSDictionary *dict = @{@"userId":userId(),
                                   @"oldPassword":origin_secure.field.text,
                                   @"newPassword":new_Secure.field.text};
            [self setNeedData:url params: dict];
        }
        if ([self.name isEqualToString:@"意见反馈"]) {
            if ([self.cell.text.text isEqualToString:@"意见反馈"]&& self.cell.text.text.length == 0 && [JCLKitObj stringByTrimmingCharactersInSet:self.cell.text.text].length == 0) {
                [JCLKitObj showMsg:@"请输入内容"];
                return;
            }
  
//            url = [NSString stringWithFormat:@"%@opinionFeedback?phone=%@&feedbackContent=%@", JCLWebURL,
//                             [JCLUserData getUserInfo].username,
//                             [self.cell.text.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
//                             ];
            url =@"addFeedback";
            NSDictionary *dict = @{@"userId":userId(),@"content":self.cell.text.text};
            [self setNeedData:url params: dict];
        }
        if ([self.name isEqualToString:@"昵称"]) {
            if ([self.cell.field.text isEqualToString:@"请输入昵称"] && self.cell.field.text.length == 0 && [JCLKitObj stringByTrimmingCharactersInSet:self.cell.field.text].length == 0) {
                [JCLKitObj showMsg:@"请输入内容"];
                return;
            }
//            url = [NSString stringWithFormat:@"%@opinionFeedback?phone=%@&feedbackContent=%@", JCLWebURL,
//                   [JCLUserData getUserInfo].username,
//                   [self.cell.text.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
//                   ];
        
            url =@"updateName";
            NSDictionary *dict = @{@"userId":userId(),@"name":self.cell.field.text};
            [self setNeedData:url params: dict];
        }
        if ([self.name isEqualToString:@"简介"]) {
            if (self.cell.text.text.length == 0 && [JCLKitObj stringByTrimmingCharactersInSet:self.cell.text.text].length == 0) {
                [JCLKitObj showMsg:@"请输入内容"];
                return;
            }
          
            url =@"updateIntro";
             NSDictionary *dict = @{@"userId":userId(),@"intro":self.cell.text.text};
            [self setNeedData:url params:dict];
        }
//        else {
//            NSString *val = self.isMore ? self.cell.text.text : self.cell.field.text;
//            !self.popActionBlock ? : self.popActionBlock(val);
//            [self.navigationController popViewControllerAnimated:YES];
//        }
    }];
    footer.height = 0.15*JCLHEIGHT;
    self.table.tableFooterView = footer;
}
-(void)setNeedData:(NSString *)url params:(NSDictionary *)dict{
   NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlA,url];
    [JCLHttps httpPOSTRequest:postUrl params:dict success:^(id obj) {
        MMResultV2Model *model = obj;
        if (model.code.intValue == 200) {
            NSString *val = self.isMore ? self.cell.text.text : self.cell.field.text;
            !self.popActionBlock ? : self.popActionBlock(val);
            if ([self.name isEqualToString:@"简介"]||[self.name isEqualToString:@"昵称"]) {
                
                 if ([self.name isEqualToString:@"简介"]) {
                     [JCLUserSession setintro:val];
                     [AppDelegate shareAppDelegate].userModel.intro = val;
                 }else{
                     [JCLUserSession setname:val];
                     [AppDelegate shareAppDelegate].userModel.name = val;
                 }
                
                NSLog(@"MRCViewController %@",val);
                if ([AppDelegate shareAppDelegate].userModel != nil) {
                    [AppDelegate shareAppDelegate].userModel = [AppDelegate shareAppDelegate].userModel;
                    [JCLUserSession setDoctor:[AppDelegate shareAppDelegate].userModel];
                }
              }
            [self.navigationController popViewControllerAnimated:YES];
        }
        [JCLKitObj showMsg:model.message];
        NSLog(@"objobj  %@",obj);
        
    } failure:^(NSError *error) {
        [JCLFramework showErrorHud:@"服务器异常"];
    }];
    
//    [JCLHttpsObj JCLGetJson:url success:^(id obj) {
//        if([obj[@"code"] isEqualToString:@"0"]){
//            [self.navigationController popViewControllerAnimated:YES];
//            [JCLFramework showSuccess:obj[@"message"]];
//        }else{
//            [JCLFramework showErrorHud:obj[@"message"]];
//        }
//
//    } failure:^(NSError *error) { [JCLFramework JCLProgressHUD:@"网络超时"]; }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.name isEqualToString:@"修改密码"]) {
        return 3;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isMore){
        return 0.4*JCLWIDTH;
    } else {
        return 0.12*JCLWIDTH;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JCLUserInputCell *cell = [JCLUserInputCell cellWithTable:tableView];
    cell.isMore = self.isMore;
    cell.field.placeholder = [NSString stringWithFormat:@"请输入%@", self.name];
    cell.text.myPlaceholder = [NSString stringWithFormat:@"请输入%@", self.name];;
     if ([self.name isEqualToString:@"修改密码"]) {
         cell.field.secureTextEntry = YES;
         if (indexPath.row==0) {
              cell.field.placeholder = @"请输入原密码";
         }else if (indexPath.row==1){
              cell.field.placeholder = @"请输入新密码";
             
         }else{
              cell.field.placeholder = @"请再次输入新密码";
         }
     }
    cell.field.text = self.text;
    cell.text.text = self.text;
    if ([self.name isEqualToString:@"意见反馈"]) {
       cell.text.text = @"";
    }
    self.cell = cell;
    return cell;
}
@end
