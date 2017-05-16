//
//  DLLoginViewController.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/9.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLLoginViewController.h"
#import "DLBottomTitleButton.h"
#import "DLRegisterViewController.h"
#import "AppDelegate.h"
#import "DLSexChioceViewController.h"
@interface DLLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *TelephoneField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordField;
@property (weak, nonatomic) IBOutlet UIButton *RegisterButton;

@property(strong,nonatomic)UMSocialUserInfoResponse *infoResponse;

@end

@implementation DLLoginViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"登录";
    self.RegisterButton.layer.borderColor=[UIColor blackColor].CGColor;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)registerClick:(UIButton *)sender {
    [self ToRegisterFromWayType:RegisterType];
}
- (IBAction)forgetPassword:(id)sender {
    [self ToRegisterFromWayType:FGPasswordType];
}


- (void)ToRegisterFromWayType:(WayType)type{
    DLRegisterViewController *registerVC=[[DLRegisterViewController alloc]init];
    registerVC.waytype=type;
    __weak typeof(self) unself=self;
    registerVC.registerSuccess=^(NSString *telephoneStr,NSString *passwordStr){
        unself.TelephoneField.text=telephoneStr;
        unself.PasswordField.text=passwordStr;
    };
    [self.navigationController pushViewController:registerVC animated:YES];

}

- (IBAction)eyeClick:(UIButton *)sender {
    sender.selected=!sender.selected;
    self.PasswordField.secureTextEntry=sender.isSelected;
}
- (IBAction)loginClick:(UIButton *)sender {
    if (strIsEmpty(self.TelephoneField.text)) {
        [MBProgressHUD showMessage:@"手机号不能为空"];
        return;
    }
    if (![Globel valiMobile:self.TelephoneField.text]) {
        [MBProgressHUD showMessage:@"手机号格式不正确"];
        return;
    }
    if (self.PasswordField.text.length<6||self.PasswordField.text.length>26) {
        [MBProgressHUD showMessage:@"密码格式不正确"];
        return;
    }
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:self.TelephoneField.text forKey:@"mobileNum"];
    [dic setObject:[self.PasswordField.text md5String] forKey:@"password"];
    [dic setObject:@"C0100" forKey:@"transCode"];
    [dic setObject:@"app_login" forKey:@"type"];
    [[GLNetWorkManager shareManager]requestType:POST andURL:REQUESTURL andServers:LOGIN andParmas:dic andComplition:^(id response, BOOL isuccess) {
        MyLog(@"%@",response);
        if (isuccess) {
            if ([response[@"code"] isEqualToString:@"000000"]) {
                [MBProgressHUD showMessage:@"登录成功"];
                [DLUserInfo SaveUserInfoFromDic:response];
                if (strIsEmpty([DLUserInfo getUserDetail].weight)) {
                    DLSexChioceViewController *sexVC=[[DLSexChioceViewController alloc]init];
                    sexVC.type=FirstType;
                    [self.navigationController pushViewController:sexVC animated:YES];
                }
                else
                    [((AppDelegate *)[UIApplication sharedApplication].delegate) enterMainVC];
            }else
                [MBProgressHUD showMessage:response[@"message"]];
        }
    }];

}

- (IBAction)OtherLoginClick:(DLBottomTitleButton *)sender {
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:sender.tag currentViewController:self completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *resp = result;
        self.infoResponse=resp;
        if (!error) {
            NSString *key=@"";
            if (sender.tag==UMSocialPlatformType_Sina) {
                key=@"microblog";
            }
            else if (sender.tag==UMSocialPlatformType_QQ)
                key=@"qq";
            else if (sender.tag==UMSocialPlatformType_WechatSession)
                key=@"weChat";
            [self checkOtherAccoutTypeRegistfromKey:key andValue:resp.uid];
        }
        
        
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        MyLog(@" uid: %@", resp.uid);
        MyLog(@" openid: %@", resp.openid);
        MyLog(@" accessToken: %@", resp.accessToken);
        MyLog(@" refreshToken: %@", resp.refreshToken);
        MyLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        MyLog(@" name: %@", resp.name);
        MyLog(@" iconurl: %@", resp.iconurl);
        MyLog(@" gender: %@", resp.gender);
        
        // 第三方平台SDK原始数据
        MyLog(@" originalResponse: %@", resp.originalResponse);
    }];

}

- (void)checkOtherAccoutTypeRegistfromKey:(NSString *)key andValue:(NSString *)value
{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:@"C0100" forKey:@"transCode"];
    [dic setObject:@"findDetail" forKey:@"type"];
    [dic setObject:value forKey:key];
    [[GLNetWorkManager shareManager]requestType:POST andURL:REQUESTURL andServers:LOGIN andParmas:dic andComplition:^(id response, BOOL isuccess) {
        MyLog(@"%@",response);
        if (isuccess&&[response[@"code"] isEqualToString:@"000000"]) {
            [DLUserInfo SaveUserInfoFromDic:response];
            [self upLoadOtherInfo];
            if (strIsEmpty([DLUserInfo getUserDetail].weight)) {
                DLSexChioceViewController *sexVC=[[DLSexChioceViewController alloc]init];
                sexVC.type=FirstType;
                [self.navigationController pushViewController:sexVC animated:YES];
            }
            else
                [((AppDelegate *)[UIApplication sharedApplication].delegate) enterMainVC];
        }
        else if (isuccess&&[response[@"code"] isEqualToString:@"C010008"])
        {
            [self OtherTypeRegistfromKey:key andValue:value];
        }
        else
            [MBProgressHUD showMessage:response[@"message"]];
    }];

}

- (void)OtherTypeRegistfromKey:(NSString *)key andValue:(NSString *)value
{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:@"C0100" forKey:@"transCode"];
    [dic setObject:@"add" forKey:@"type"];
    [dic setObject:value forKey:key];
    [[GLNetWorkManager shareManager]requestType:POST andURL:REQUESTURL andServers:LOGIN andParmas:dic andComplition:^(id response, BOOL isuccess) {
        MyLog(@"%@",response);
        if (isuccess&&[response[@"code"] isEqualToString:@"000000"]) {
            [self checkOtherAccoutTypeRegistfromKey:key andValue:value];
        }
        else
            [MBProgressHUD showMessage:response[@"message"]];
    }];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *toBestring=textField.text;
    NSCharacterSet *cs;
    
    cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
    
    NSString *filtered =[[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    BOOL basic = [string isEqualToString:filtered];
    if (basic) {
        if (toBestring.length>=26) {
            textField.text=[toBestring substringToIndex:25];
            [MBProgressHUD showMessage:@"密码不能超出26位"];
            return NO;
        }
        else
            return YES;
    }
    return basic;
    
}
- (void)upLoadOtherInfo{
    NSMutableDictionary *updatedic=[NSMutableDictionary dictionary];
    [updatedic setObject:@"C0100" forKey:@"transCode"];
    [updatedic setObject:@"update" forKey:@"type"];
    [updatedic setObject:[DLUserInfo getUser].userId forKey:@"userId"];
    [updatedic setObject:self.infoResponse.iconurl forKey:@"headPhotoAdd"];
    [updatedic setObject:self.infoResponse.name forKey:@"userName"];
    
    [[GLNetWorkManager shareManager]requestType:POST andURL:REQUESTURL andServers:GET_WORK_TYPE andParmas:updatedic andComplition:^(id response, BOOL isuccess) {
        if (isuccess&&[response[@"code"] isEqualToString:SUCCESSCODE]) {
            [DLUserInfo SaveUserInfoFromDic:response];
        }
        MyLog(@"%@",response);
    }];

}
@end
