//
//  DLSettingViewController.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/4/14.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLSettingViewController.h"
#import "SDImageCache.h"
@interface DLSettingViewController ()

@end

@implementation DLSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设置";
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell0";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        UIView *lineview=[[UIView alloc]initWithFrame:CGRectMake(10, [self tableView:tableView heightForRowAtIndexPath:indexPath]-0.5, kScreenW-20, 0.5)];
        lineview.backgroundColor=shouldgraycolor;
        [cell.contentView addSubview:lineview];
    }
    cell.imageView.image=[UIImage imageNamed:@"iv_clean"];
    cell.textLabel.text=@"清理缓存";
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;

}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]init];
    
    DLRoundEdgeButton *button=[[DLRoundEdgeButton alloc]initWithFrame:CGRectMake(50, 20, kScreenW-100, 44)];
    button.backgroundColor=THEMECOLOR;
    [button setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    float tmpSize = [[SDImageCache sharedImageCache] getSize];
//
//    MyLog(@"%f",tmpSize);
//    NSString *size = [self fileSizeWithInterge:tmpSize];
    
    TYAlertView *alertView=[TYAlertView alertViewWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"确定要清理缓存吗?"]];
    TYAlertAction *cancle=[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:nil];
    TYAlertAction *sure=[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDefault handler:^(TYAlertAction *action) {
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
           dispatch_async(dispatch_get_main_queue(), ^{
               [MBProgressHUD showMessage:@"清理完成"];
           });
        }];
    }];
    [alertView addAction:cancle];
    [alertView addAction:sure];
    TYAlertController *alertVC=[TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert transitionAnimation:TYAlertTransitionAnimationScaleFade];
    [self presentViewController:alertVC animated:YES completion:nil];

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 80;
}

- (void)loginOut{
    TYAlertView *alertView=[TYAlertView alertViewWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"确定要退出登录吗?"]];
    TYAlertAction *cancle=[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:nil];
    TYAlertAction *sure=[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDefault handler:^(TYAlertAction *action) {
        [self outDate];
    }];
    [alertView addAction:cancle];
    [alertView addAction:sure];
    TYAlertController *alertVC=[TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert transitionAnimation:TYAlertTransitionAnimationScaleFade];
    [self presentViewController:alertVC animated:YES completion:nil];

}

- (void)outDate{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic.transCode=@"C0100";
    dic.type=@"app_logOut";
    [dic setObject:[DLUserInfo getUser].mobileNum forKey:@"mobileNum"];
    [[GLNetWorkManager shareManager]requestType:POST andURL:REQUESTURL andServers:GET_WORK_TYPE andParmas:dic andComplition:^(id response, BOOL isuccess) {
        if (isuccess&&[response[@"code"] isEqualToString:SUCCESSCODE]) {
            [DLUserInfo removeUserInfo];
            [((AppDelegate *)[UIApplication sharedApplication].delegate)enterMainVC];
        }
    }];
}
//计算出大小
- (NSString *)fileSizeWithInterge:(NSInteger)size{
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}
@end
