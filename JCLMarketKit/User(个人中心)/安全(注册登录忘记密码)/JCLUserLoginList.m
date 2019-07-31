//
//  JCLLoginList.m
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/19.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLUserLoginList.h"
#import "JCLTableInfoCell.h"
#import "JCLWapList.h"
#import "JCLUserSubmit.h"
#import "JCLUserRegisterList.h"
#import "JCLUserForgetList.h"

#import "RXMLElement.h"
#import "NSData+CRC32.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import "JCLUserLoginHeader.h"
//登录
@interface JCLUserLoginList ()
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *lineA;
@property (nonatomic,strong) UILabel *titleLB;
@property (nonatomic,strong) UILabel *lineB;
@property (nonatomic,strong) UIButton *imgBtn;
@end

@implementation JCLUserLoginList
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navi.backgroundColor = JCLHexCol(@"#FEFFFE");
    self.navi.bg.backgroundColor = JCLHexCol(@"#FEFFFE");

    self.navi.left.img = @"关闭";
    if (self.isMain) {
        self.navi.left.img = @"";
        self.navi.left.enabled = NO;
    }
    
    [self.navi.right setTitle:@"华盛通开户" forState:0];
    [self.navi.right setTitleColor:[UIColor blackColor] forState:0];
    [self.navi.right1 setTitle:@"老虎开户" forState:0];
    [self.navi.right1 setTitleColor:[UIColor blackColor] forState:0];
    CGFloat y = New_Device?25:20;
 
    self.navi.right.frame = CGRectMake(self.navi.width - 80 -10, y, 80, 40);
    self.navi.right1.frame = CGRectMake(self.navi.width - 80-80, y, 80, 40);
//    self.navi.right.frame = CGRectMake(self.navi.width - 80-10-30, y, 80, h);
//    self.navi.right1.frame = CGRectMake(self.navi.right.left - 100, y, w+20, h);
    
    self.titles = @[@"手机号", @"密   码"];
    self.texts = @[@"请输入手机号", @"请输入密码"];
    
    [self.texts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.vals addObject:@""];
        if ([JCLUserSession getPhoneNum]&&[JCLUserSession getPassWord]) {
            [self.vals removeAllObjects];
            [self.vals insertObject:[JCLUserSession getPhoneNum] atIndex:0];
            [self.vals insertObject:[JCLUserSession getPassWord]atIndex:1];
         }
    }];
    
//    [self.view addSubview:self.bgView];
//    [self.bgView addSubview:self.lineA];
//    [self.bgView addSubview:self.lineB];
//    [self.bgView addSubview:self.titleLB];
//    [self.bgView addSubview:self.imgBtn];
//    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(15);
//        make.right.mas_equalTo(-15);
//        make.height.mas_equalTo(110);
//        make.bottom.mas_equalTo(-30);
//    }];
//    
//    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(15);
//        make.centerX.mas_equalTo(self.bgView.mas_centerX);
//        make.height.mas_equalTo(15);
//    }];
//    
//    [self.lineA mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(23);
//        make.height.mas_equalTo(0.5);
//        make.width.mas_equalTo(100);
//        make.right.mas_equalTo(self.titleLB.mas_left).offset(-5);;
//     }];
//    
//    [self.lineB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(23);
//        make.height.mas_equalTo(0.5);
//        make.width.mas_equalTo(100);
//        make.left.mas_equalTo(self.titleLB.mas_right).offset(5);;
//    }];
//    [self.imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(-10);
//        make.height.mas_equalTo(55);
//        make.width.mas_equalTo(55);
//         make.centerX.mas_equalTo(self.bgView.mas_centerX);
//    }];
//    
    
    JCLUserLoginHeader *header = [[JCLUserLoginHeader alloc]init];
    header.backgroundColor = JCLHexCol(@"#FEFFFE");
    header.height = 0.2*JCLHEIGHT;
    self.table.tableHeaderView = header;
    
    JCLUserSubmit *footer = [[JCLUserSubmit alloc]init];
    footer.submit.title = @"登录";
    [footer.submit tapActionBlock:^{
        
        [self.view endEditing:YES];
        if (![self.vals[0] length]) {
            [JCLKitObj showMsg:@"请输入用户名"];
            return;
            
        }
        if (![self.vals[1] length]) {
            [JCLKitObj showMsg:@"请输入密码"];
            return;
            
        }
 
             [MBProgressHUD showHUDAddedTo:self.view animated:YES];
              NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlA,@"login"];
                [JCLHttps httpPOSTRequest:postUrl params:@{@"phone":self.vals[0],@"password":self.vals[1]} success:^(id obj) {
                    MMResultV2Model *model = obj;
                    if(model.code.intValue == 200){
 
                        [JCLUserSession setPassWord:self.vals[1]];
                        [JCLUserSession setPhoneNum:self.vals[0]];
                        JCLUserModel *userModel =  [JCLUserModel modelWithDictionary:model.data];
                     
                        [AppDelegate shareAppDelegate].userModel = userModel;
                   
                        [JCLUserSession setCurrentAccount:userModel.currentAccount];
                        [JCLUserSession setDoctor:userModel];
                        [self queryAccount];
                        
                        [JCLFramework showSuccess:@"登录成功"];
                        !self.popActionBlock ? : self.popActionBlock();
                        [self.navigationController popViewControllerAnimated:YES];
                    }else{
                        [JCLKitObj showMsg:model.message];
                    }
                     
                    
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                } failure:^(NSError *error) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                     [JCLFramework showErrorHud:@"服务器异常"];
                }];

    }];
    footer.isLogin = YES;
    footer.regist.title = @"注册账号";
    [footer.regist tapActionBlock:^{
        JCLUserRegisterList *list = [[JCLUserRegisterList alloc]init];
        if (self.isMain) {
            [self presentViewController:list animated:YES completion:nil];
        } else {
            [self.navigationController pushViewController:list animated:YES];
        }
    }];
    footer.forget.title = @"忘记密码";
    [footer.forget tapActionBlock:^{
        JCLUserForgetList *list = [[JCLUserForgetList alloc]init];
        if (self.isMain) {
            [self presentViewController:list animated:YES completion:nil];
        } else {
            [self.navigationController pushViewController:list animated:YES];
        }
    }];
    footer.height = 0.166*JCLHEIGHT;
    footer.backgroundColor = JCLHexCol(@"#FEFFFE");
    footer.regist.color = [UIColor blackColor];
    footer.forget.color = [UIColor blackColor];
    self.table.tableFooterView = footer;
    
    self.table.backgroundColor = JCLHexCol(@"#FEFFFE");
}
//开户
-(void)rightAction{
   
    JCLWapList *list = [[JCLWapList alloc]init];
    list.name = @"立即开户";
    list.url = [NSString stringWithFormat:@"https://passport.hstong.com/register/marketing?_scnl=MmQ0MnZhbDg"];
    [self.navigationController pushViewController:list animated:YES];
}

-(void)right1Action{

    
    JCLWapList *list = [[JCLWapList alloc]init];
    list.name = @"立即开户";
    list.url = [NSString stringWithFormat:@"https://itiger.com/accounts?invite=ZHANGJIAN"];
    [self.navigationController pushViewController:list animated:YES];
}
//是否开户状态
-(void)queryAccount{
    
    //   OST
    //  /accountapi/queryAccount
    //   获取帐户
    NSString *postUrl = [NSString stringWithFormat:@"%@/%@",baseApiURlB,@"queryAccount"];
    [JCLHttps httpPOSTRequest:postUrl params:@{@"userId":userId()} success:^(id obj) {
        MMResultV2Model *model = obj;
        NSLog(@"modelmodel %@",model.data);
    } failure:^(NSError *error) {
        
    }];
   
}


-(NSString *)MD5:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X", digest[i]];
    return output;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.texts.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ return 0.07*JCLHEIGHT;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JCLTableInfoCell *cell = [JCLTableInfoCell cellWithTable:tableView];
    NSString *val = self.titles[indexPath.row];
    cell.text.placeholder = self.texts[indexPath.row];
    cell.text.text = self.vals[indexPath.row];
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
//        if ( [JCLUserSession getPassWord]) {
//            cell.text.text= [JCLUserSession getPhoneNum];
//
//        }
        
    } else {
        cell.text.keyboardType = UIKeyboardTypeNumberPad;
        cell.text.clearButtonMode = UITextFieldViewModeWhileEditing;
 
    }
    
    cell.backgroundColor = JCLHexCol(@"#F1F2F1");
    cell.bg.backgroundColor = JCLHexCol(@"#FEFFFE");
    cell.text.textColor = nil;
    cell.title.textColor = nil;
    return cell;
}



-(UIView *)bgView{
    if (!_bgView) {
       _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

-(UILabel *)lineA{
    if (!_lineA) {
        _lineA = [[UILabel alloc]init];
        _lineA.backgroundColor = SeparatorLineBColor;
    }
    return _lineA;
}
-(UILabel *)titleLB{
    if (!_titleLB) {
        _titleLB = [[UILabel alloc]init];
        _titleLB.textColor = TitleCColor;
        _titleLB.text = @"快捷登录";
        _titleLB.font = [UIFont systemFontOfSize:14];
    }
    return _titleLB;
}
-(UILabel *)lineB{
    if (!_lineB) {
        _lineB = [[UILabel alloc]init];
        _lineB.backgroundColor = SeparatorLineBColor;
    }
    return _lineB;
}

-(UIButton *)imgBtn{
    if (!_imgBtn) {
        _imgBtn = [[UIButton alloc]init];
 
        [_imgBtn setImage:[UIImage imageNamed:@"wetshareimage"] forState:0];
        [_imgBtn setTitle:@"微信"];
        _imgBtn.imageEdgeInsets = UIEdgeInsetsMake(-20, 15, 0, 15);
        _imgBtn.titleEdgeInsets = UIEdgeInsetsMake(25, -23, 0, 0);
        _imgBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_imgBtn addTarget:self action:@selector(longBtn)];
    }
    return _imgBtn;
}

-(void)longBtn{
     [self getAuthWithUserInfoFromWechat];
}

- (void)getAuthWithUserInfoFromWechat
{
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
        NSLog(@"errorerrorerrorerror %@", result);
        if (error) {
            NSLog(@"errorerrorerrorerror %@", error);
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat unionid: %@", resp.unionId);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
        }
    }];
}


@end
