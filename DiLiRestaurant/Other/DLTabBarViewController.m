//
//  MainViewController.m
//  SinaWeibo
//
//  Created by user on 15/10/13.
//  Copyright © 2015年 ZT. All rights reserved.
//

#import "DLTabBarViewController.h"
#import "DLNavigationController.h"
#import "DLHomeViewController.h"
#import "DLStoreViewController.h"
#import "DLMineViewController.h"
#import "DLGuidanceViewController.h"
#import "DLEvaluateViewController.h"
#import "DLWalkingViewController.h"
#import "ZTTabBar.h"
#import "DLLoginViewController.h"
#import "WebViewController.h"
@interface DLTabBarViewController () <ZTTabBarDelegate>

@end

@implementation DLTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([DLUserInfo GetVersionType]==PersonalType) {
        [self addpersonalVC];
    }
    else
        [self addTeamVC];

    ZTTabBar *tabBar = [[ZTTabBar alloc] init];
    tabBar.ztdelegate = self;
    // KVC：如果要修系统的某些属性，但被设为readOnly，就是用KVC，即setValue：forKey：。
    [self setValue:tabBar forKey:@"tabBar"];
}

- (void)addpersonalVC{
    // 添加子控制器
    [self addChildVc:[[DLHomeViewController alloc] init] title:@"首页" image:@"导航—首页" selectedImage:@"导航—首页01"];
    [self addChildVc:[[[DLUserInfo getUser]==nil?[DLLoginViewController class]:[DLGuidanceViewController class] alloc] init] title:@"餐前指导" image:@"导航—餐前指导" selectedImage:@"导航—餐前指导01"];
    [self addChildVc:[[[DLUserInfo getUser]==nil?[DLLoginViewController class]:[DLEvaluateViewController class] alloc] init] title:@"就餐评价" image:@"导航—餐后评价01" selectedImage:@"导航—餐后评价"];
    [self addChildVc:[[[DLUserInfo getUser]==nil?[DLLoginViewController class]:[DLWalkingViewController class] alloc] init] title:@"健步走" image:@"walking_normal" selectedImage:@"walking_select"];
    [self addChildVc:[[[DLUserInfo getUser]==nil?[DLLoginViewController class]:[DLMineViewController class]  alloc] init] title:@"我的" image:@"导航—我的" selectedImage:@"导航—我的01"];
}

- (void)addTeamVC{
    [self addChildVc:[[DLStoreViewController alloc] init] title:@"门店" image:@"tab_store" selectedImage:@"tab_store_pressed"];
    [self addChildVc:[[[DLUserInfo getUser]==nil?[DLLoginViewController class]:[DLGuidanceViewController class] alloc] init] title:@"餐前指导" image:@"导航—餐前指导" selectedImage:@"导航—餐前指导01"];
    [self addChildVc:[[[DLUserInfo getUser]==nil?[DLLoginViewController class]:[DLEvaluateViewController class] alloc] init] title:@"就餐评价" image:@"导航—餐后评价01" selectedImage:@"导航—餐后评价"];
    [self addChildVc:[[[DLUserInfo getUser]==nil?[DLLoginViewController class]:[DLWalkingViewController class] alloc] init] title:@"健步走" image:@"walking_normal" selectedImage:@"walking_select"];
    [self addChildVc:[[[DLUserInfo getUser]==nil?[DLLoginViewController class]:[DLMineViewController class]  alloc] init] title:@"我的" image:@"导航—我的" selectedImage:@"导航—我的01"];
}
/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字(可以设置tabBar和navigationBar的文字)
    childVc.title = title;
    
    // 设置子控制器的tabBarItem图片
//    childVc.tabBarItem.imageInsets=UIEdgeInsetsMake(1.2, 1.2, 1.2, 1.2);
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    // 禁用图片渲染
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGBColor(101, 102, 103)} forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : THEMECOLOR} forState:UIControlStateSelected];
    //    childVc.view.backgroundColor = RandomColor; // 这句代码会自动加载主页，消息，发现，我四个控制器的view，但是view要在我们用的时候去提前加载
    
    // 为子控制器包装导航控制器
    DLNavigationController *navigationVc = [[DLNavigationController alloc] initWithRootViewController:childVc];
    // 添加子控制器
    [self addChildViewController:navigationVc];
}

#pragma ZTTabBarDelegate
/**
 *  加号按钮点击
 */
- (void)tabBarDidClickPlusButton:(ZTTabBar *)tabBar
{
    UIViewController *vc = [[UIViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    MyLog(@"%lu",[self.tabBar.items indexOfObject:item]);
//    NSInteger index=[self.tabBar.items indexOfObject:item];
//    if (index) {
//        if (![DLUserInfo getUser]) {
//            DLNavigationController *nav=self.childViewControllers[index];
//            DLLoginViewController *loginVC=[[DLLoginViewController alloc]init];
//            [nav pushViewController:loginVC animated:YES];
//        }
//    }
}
@end
