//
//  JCLTableInfo.m
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/19.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTableInfo.h"

@interface JCLTableInfo ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,TZImagePickerControllerDelegate>
@end

@implementation JCLTableInfo


-(void)showPhoneAction{
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    imagePickerVc.allowTakeVideo = NO;   // 在内部显示拍视频按
 
    [imagePickerVc setUiImagePickerControllerSettingBlock:^(UIImagePickerController *imagePickerController) {
        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    }];
    
    // imagePickerVc.photoWidth = 800;
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    // imagePickerVc.navigationBar.translucent = NO;
    imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }];
    
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO ;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingGif = NO;
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    /// 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = YES;
    imagePickerVc.needCircleCrop = YES;
    // 设置竖屏下的裁剪尺寸
    NSInteger left = 30;
    NSInteger widthHeight = JCLWIDTH - 2 * left;
    NSInteger top = (JCLHEIGHT - widthHeight) / 2;
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    
    // 设置是否显示图片序号
    
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
//    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择文件来源"
//                                                       delegate:self
//                                              cancelButtonTitle:@"取消"
//                                         destructiveButtonTitle:nil
//                                              otherButtonTitles:@"照相机",@"本地相簿",nil];
//    [sheet showInView:self.view];
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    
//    if (photos.count> 0) {
//        UIImage *image = [se imageByScalingAndCroppingForSize:CGSizeMake(100, 100) sourceImage:photos[0]];
//        self.viewModel.avatarImage = image;
//        [self.viewModel.submitCommand execute:@"avatar"];
//    }
    [JCLHttps httpImageUpload:@"imageUpload" params:@{@"userId":userId()} headImage:[self handleImage:photos[0] withSize:CGSizeMake(100, 100)] success:^(id obj) {
        MMResultV2Model *model = obj;
        if (model.code.intValue == 200) {
            self.img = model.data[@"filename"];
            self.phone = photos[0];
            [JCLKitObj showMsg:model.message];
            [self.table reloadData];
        
            JCLUserModel *model =  [AppDelegate shareAppDelegate].userModel;
            model.avatar = self.img;
            [JCLUserSession setAvatar:self.img];
            [AppDelegate shareAppDelegate].userModel = model;
            [JCLUserSession setDoctor:[AppDelegate shareAppDelegate].userModel];
            
        }else{
            [JCLKitObj showMsg:model.message];
        }
        
    } failure:^(NSError *error) {
        [JCLFramework JCLProgressHUD:@"网络超时"];
    }];
}
#pragma UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
        case 1:{
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

            [self presentViewController:imagePicker animated:YES completion:nil];
            
            
        }
            break;
        default: break;
    }
}
// 取消图片选择调用此方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    // dismiss UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    
//    FileWrite(TmpFile(@"pic.jpg"), UIImagePNGRepresentation([self handleImage:image withSize:CGSizeMake(300, 300)]));
//    NSData *imageData = UIImagePNGRepresentation([self handleImage:image withSize:CGSizeMake(300, 300)]);
//    NSDictionary *dic = @{ @"image":[self hexStringFromData:imageData] };
//    NSString *url = [NSString stringWithFormat:@"%@uploadImage?phone=%@", JCLWebURL, [JCLUserData getUserInfo].username];
   
    
//    [JCLHttpsObj JCLPostJson:url parame:dic success:^(id obj) {
//        if([obj[@"code"] isEqualToString:@"0"]){
//            self.img = obj[@"imagePath"];
//            self.phone = image; [self.table reloadData];
////            NSString *url = [NSString stringWithFormat:@"%@PageAvatarServlet?subzh=%@&avatar=%@", JCLWebURL, [JCLUserData getUserInfo].username, obj[@"message"]];
////            [JCLHttpsObj JCLGetJson:url success:^(id obj) {
////                if([obj[@"code"] isEqualToNumber:@0]){
////                    self.phone = image; [self.table reloadData];
////                    NSDictionary *dic = @{ @"password":[JCLUserData getUserInfo].password };
////                    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:NULL];
////                    NSString *url = [NSString stringWithFormat:@"%@PageLoginServlet?phone=%@&type=2&password=%@&channelId=%@&userId=%@",
////                                     JCLWebURL, [self.vals[0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
////                                     [data base64EncodedStringWithOptions:0], @"44", @"44"];
////                    [JCLHttpsObj JCLGetJson:url success:^(id obj) {
////                        if([obj[@"code"] isEqualToNumber:@(0)]){
////                            NSString *name = [JCLUserData getUserInfo].username, *word = [JCLUserData getUserInfo].password;
////                            JCLUserData *data = [JCLUserData mj_objectWithKeyValues:obj[@"userInfo"]];
////                            data.username = name; data.password = word;
////                            [JCLUserData saveUserInfo:data];
////                        }
////                    } failure:^(NSError *error) { [JCLFramework JCLProgressHUD:@"网络超时，请您检查网络"]; }];
////                }
////                [JCLFramework JCLProgressHUD:obj[@"message"]];
////            } failure:^(NSError *error) { [JCLFramework JCLProgressHUD:@"网络超时"]; }];
//        } else {
//            [JCLSVProgressHUD showErrorHud:@"修改头像失败!"];
//        }
//    } failure:^(NSError *error) { [JCLFramework JCLProgressHUD:@"网络超时"]; }];
}

- (NSString *)hexStringFromData:(NSData*)data{
    return [[[[NSString stringWithFormat:@"%@",data]
              stringByReplacingOccurrencesOfString: @"<" withString: @""]
             stringByReplacingOccurrencesOfString: @">" withString: @""]
            stringByReplacingOccurrencesOfString: @" " withString: @""];
}

- (UIImage *)handleImage:(UIImage *)originalImage withSize:(CGSize)size{
    //创建图形图像上下文
    UIGraphicsBeginImageContext(size);
    //告诉旧图像，在这个新的上下文中绘制所需的图像
    //新的大小
    [originalImage drawInRect:CGRectMake(0,0,size.width,size.height)];
    //从上下文获取新图像
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //结束上下文
    UIGraphicsEndImageContext();
    //返回新图像。
    return  newImage;
}
@end
