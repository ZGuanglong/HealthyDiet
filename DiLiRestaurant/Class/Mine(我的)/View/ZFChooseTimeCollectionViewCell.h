//
//  ZFChooseTimeCollectionViewCell.h
//  slyjg
//
//  Created by 王小腊 on 16/3/9.
//  Copyright © 2016年 王小腊. All rights reserved.
//


#define CYBColorGreen [UIColor colorWithRed:78/255.0 green:147/255.0 blue:232/255.0 alpha:1]
#define YJCorl(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1]
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height

#import <UIKit/UIKit.h>

@interface ZFChooseTimeCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *number;

@property (nonatomic ,strong) NSArray *currentArray;


/**
 生理期选中更新cell

 @param number      当前时间拆分数组
 @param selectArray 选中的时间
 */
- (void)updateDay:(NSArray*)number withSelectArray:(NSArray *)selectArray;


/**
 餐后评价选择时间

 @param number     当前时间拆分数组
 @param selectDate 选中的时间
 */
- (void)updateDay:(NSArray*)number andSelectDate:(NSDate *)selectDate;

/**
 首页门店选择时间

 @param number         当前时间拆分数组
 @param selectDate     选中的时间
 @param canselectArray 可以被选中的时间数组
 */
- (void)updateDay:(NSArray*)number andSelectDate:(NSDate *)selectDate andCanselectArray:(NSArray *)canselectArray;
@end
