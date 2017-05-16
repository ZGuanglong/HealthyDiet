//
//  MypickView.h
//  DatePicker
//
//  Created by 地利 on 2017/3/16.
//  Copyright © 2017年 zws. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    DateStyleShowYearMonthDayHourMinute  = 0,
    DateStyleShowMonthDayHourMinute,
    DateStyleShowYearMonthDay,
    DateStyleShowMonthDay,
    DateStyleShowHourMinute
    
}WSDateStyle;

@interface DLDatePickView : UIView
@property (nonatomic,assign)WSDateStyle datePickerStyle;

@property (nonatomic,strong)UIColor *themeColor;

@property (nonatomic, retain) NSDate *scrollToDate;//滚到指定日期

@property (nonatomic, retain) NSDate *maxLimitDate;//限制最大时间（没有设置默认2049）
@property (nonatomic, retain) NSDate *minLimitDate;//限制最小时间（没有设置默认1970）
@end
