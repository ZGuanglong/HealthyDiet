//
//  DLShareViewController.h
//  DiLiRestaurant
//
//  Created by 地利 on 2017/4/19.
//  Copyright © 2017年 地利. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLShareViewController : UIViewController

+ (instancetype)shareManager;
/**
 友盟分享
 
 @param platformType 类型
 @param title        标题
 @param descr        描述
 @param thumImage    图片
 @param webUrlStr    链接
 */
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType WithTitle:(NSString *)title
                             descr:(NSString *)descr
                         thumImage:(id)thumImage andURL:(NSString *)webUrlStr andSuccess:(void(^)(UMSocialShareResponse * response))response;


@end
