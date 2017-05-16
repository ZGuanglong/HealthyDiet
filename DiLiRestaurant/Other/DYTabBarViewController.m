//
//  MainViewController.m
//  SinaWeibo
//
//  Created by user on 15/10/13.
//  Copyright © 2015年 ZT. All rights reserved.
//

#import "DYTabBarViewController.h"
#import "DYNavigationController.h"
#import "ZTTabBar.h"
@interface DYTabBarViewController () <ZTTabBarDelegate>

@end

@implementation DYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加子控制器
//    [self addChildVc:[[FullfunctionViewController alloc] init] title:@"全部功能" image:@"function_press_bg" selectedImage:@"function_normal_bg"];
//
//    [self addChildVc:[[MainViewController alloc] init] title:@"我的桌面" image:@"table_normal_bg" selectedImage:@"table_press_bg"];
//    [self addChildVc:[[WorkViewController alloc] init] title:@"公司头条" image:@"msg_normal_bg" selectedImage:@"msg_press_bg"];
//    [self addChildVc:[[MessageViewController alloc] init] title:@"公司文档" image:@"company_normal_bg" selectedImage:@"company_press_bg"];

    ZTTabBar *tabBar = [[ZTTabBar alloc] init];
    tabBar.ztdelegate = self;
    // KVC：如果要修系统的某些属性，但被设为readOnly，就是用KVC，即setValue：forKey：。
    [self setValue:tabBar forKey:@"tabBar"];
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
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGBColor(123, 123, 123)} forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGBColor(252, 13, 27)} forState:UIControlStateSelected];
    //    childVc.view.backgroundColor = RandomColor; // 这句代码会自动加载主页，消息，发现，我四个控制器的view，但是view要在我们用的时候去提前加载
    
    // 为子控制器包装导航控制器
    DYNavigationController *navigationVc = [[DYNavigationController alloc] initWithRootViewController:childVc];
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
    
}

@end
