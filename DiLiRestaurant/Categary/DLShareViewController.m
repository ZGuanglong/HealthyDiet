//
//  DLShareViewController.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/4/19.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLShareViewController.h"

@interface DLShareViewController ()

@end

@implementation DLShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
+ (instancetype)shareManager{
    static DLShareViewController *shareVC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareVC=[[DLShareViewController alloc]init];
    });
    return shareVC;
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType WithTitle:(NSString *)title
                             descr:(NSString *)descr
                         thumImage:(id)thumImage andURL:(NSString *)webUrlStr andSuccess:(void(^)(UMSocialShareResponse * response))response;
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:thumImage];
    //设置网页地址
    shareObject.webpageUrl =webUrlStr;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            MyLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                if (response) {
                    response(resp);
                }
                //分享结果消息
                MyLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                MyLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                MyLog(@"response data is %@",data);
            }
        }
    }];
}

@end
