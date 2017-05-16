//
//  ChoiceView.h
//  EveryDay
//
//  Created by tidoo on 16/4/23.
//  Copyright © 2016年 Tidoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoiceView : UIView
/**
 *  点击按钮
 */
@property(nonatomic,copy)void (^clickbuttonblock)(NSInteger index);

@property(nonatomic,strong)UIColor  *backgroundcolor;//背景色

@property(nonatomic,strong)UIColor *selectbackgroundcolor;//选中颜色

@property(nonatomic,strong)UIColor *titlecolor;//字体颜色

@property(nonatomic,strong)UIColor *selecttitlecolor;//选中颜色

@property(nonatomic,assign)CGFloat FontSize;

- (instancetype)initWithFrame:(CGRect)frame andtitleArray:(NSArray *)titlearray;
/**
 *  外部触发按钮
 *
 *  @param index 位置
 */
- (void)clickbuttonAtIndex:(NSInteger)index;


@end
