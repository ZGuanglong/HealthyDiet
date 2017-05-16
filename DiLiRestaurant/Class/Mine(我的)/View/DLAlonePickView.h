//
//  DLAlonePickView.h
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/17.
//  Copyright © 2017年 地利. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLAlonePickView : UIView

@property(strong,nonatomic)NSArray *dataArray;

@property(copy,nonatomic)NSString *lastString;

@property(copy,nonatomic)NSString *defaultValue;

@property(strong,nonatomic)UIColor *themeColor;

@property(copy,nonatomic)NSString *resultValue;
@end
