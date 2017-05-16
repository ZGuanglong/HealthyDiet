//
//  DLCalendarView.h
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/28.
//  Copyright © 2017年 地利. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLCalendarView : UIView

/**
 被选择的日期
 */
@property (nonatomic, strong) NSMutableArray *OutDateArray;

- (instancetype)initWithFrame:(CGRect)frame andSelectArray:(NSArray *)dateArray;

@end
