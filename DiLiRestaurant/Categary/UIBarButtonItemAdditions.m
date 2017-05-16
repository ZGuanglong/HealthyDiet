//
//  UIBarButtonItemAdditions.m
//  CityGuide
//
//  Created by COLD FRONT on 12-6-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIBarButtonItemAdditions.h"

@implementation UIBarButtonItem(Additions)

+ (UIBarButtonItem *)leftBarButtonItemWithImage:(UIImage *)image
                                    highlighted:(UIImage *)highlightedImage
                                         target:(id)target
                                       selector:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 40, 40);
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.imageView.contentMode=UIViewContentModeScaleAspectFit;
    button.adjustsImageWhenHighlighted = NO;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)rightBarButtonItemWithImage:(UIImage *)image
                                     highlighted:(UIImage *)highlightedImage
                                          target:(id)target
                                        selector:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 30, 40);
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.adjustsImageWhenHighlighted = NO;
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    button.imageView.contentMode=UIViewContentModeScaleAspectFit;
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *) leftBarButtonItemWithTitle:(NSString *)title
                                          target:(id)target
                                        selector:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 40, 40);
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    button.titleLabel.textColor = [UIColor whiteColor];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)rightBarButtonItemWithTitle:(NSString *)title
                                          target:(id)target
                                        selector:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 80, 40);
    button.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.9215 green:0.9215 blue:0.9215 alpha:0.86] forState:UIControlStateHighlighted];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
+(UIBarButtonItem *)rightsBarButtonItemWithtarget:(id)target andleftTitle:(NSString *)lefttitle selector:(SEL)leftselector andrightTitle:(NSString *)righttitle selector:(SEL)rightselector
{
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 130, 40)];
    bgView.backgroundColor=[UIColor clearColor];
    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbutton.frame=CGRectMake(0, 0, 80, 40);
    leftbutton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [leftbutton setTitle:lefttitle forState:UIControlStateNormal];
    [leftbutton setTitleColor:[UIColor colorWithRed:0.9215 green:0.9215 blue:0.9215 alpha:0.86] forState:UIControlStateHighlighted];
    [leftbutton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [leftbutton addTarget:target action:leftselector forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:leftbutton];
    
    UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbutton.frame=CGRectMake(CGRectGetMaxX(leftbutton.frame)+10, 0, CGRectGetWidth(bgView.frame)-CGRectGetMaxX(leftbutton.frame)-10, 40);
    rightbutton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [rightbutton setTitle:righttitle forState:UIControlStateNormal];
    [rightbutton setTitleColor:[UIColor colorWithRed:0.9215 green:0.9215 blue:0.9215 alpha:0.86] forState:UIControlStateHighlighted];
    [rightbutton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [rightbutton addTarget:target action:rightselector forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:rightbutton];
    
    return [[UIBarButtonItem alloc]initWithCustomView:bgView];
    
}
+(UIBarButtonItem *)rightsBarButtonItemWithtarget:(id)target andleftImage:(UIImage *)leftImage selector:(SEL)leftselector andrightImage:(UIImage *)rightImage selector:(SEL)rightselector
{
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 130, 40)];
    bgView.backgroundColor=[UIColor clearColor];
    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbutton.frame=CGRectMake(0, 0, 100, 40);
    leftbutton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [leftbutton setImage:leftImage forState:UIControlStateNormal];
    [leftbutton setTitleColor:[UIColor colorWithRed:0.9215 green:0.9215 blue:0.9215 alpha:0.86] forState:UIControlStateHighlighted];
    [leftbutton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    leftbutton.imageEdgeInsets = UIEdgeInsetsMake(12, 77, 12, 2);
    [leftbutton addTarget:target action:leftselector forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:leftbutton];
    
    UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbutton.frame=CGRectMake(CGRectGetMaxX(leftbutton.frame)+10, 0, CGRectGetWidth(bgView.frame)-CGRectGetMaxX(leftbutton.frame)-10, 40);
    rightbutton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [rightbutton setImage:rightImage forState:UIControlStateNormal];
    [rightbutton setTitleColor:[UIColor colorWithRed:0.9215 green:0.9215 blue:0.9215 alpha:0.86] forState:UIControlStateHighlighted];
    [rightbutton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [rightbutton addTarget:target action:rightselector forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:rightbutton];
    
    return [[UIBarButtonItem alloc]initWithCustomView:bgView];
    
}

@end
