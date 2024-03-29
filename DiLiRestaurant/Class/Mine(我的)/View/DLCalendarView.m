//
//  DLCalendarView.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/28.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLCalendarView.h"
#import "ZFChooseTimeCollectionViewCell.h"
#import "ZFTimerCollectionReusableView.h"
static NSString * const reuseIdentifier = @"ChooseTimeCell";
static NSString * const headerIdentifier = @"headerIdentifier";

@interface DLCalendarView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSDateFormatter *formatter;
@property (nonatomic, strong) NSDateComponents *comps;
@property (nonatomic, strong) NSCalendar *calender;
@property (nonatomic, strong) NSArray * weekdays;
@property (nonatomic, strong) NSTimeZone *timeZone;
@property (nonatomic, strong) NSArray *selectedData;
@property(assign,nonatomic)NSInteger pageIndex;

@end

@implementation DLCalendarView
@synthesize date = newDate;
@synthesize collectionView = datecollectionView;

#pragma mark --- 初始化

- (NSMutableArray *)OutDateArray
{
    if (!_OutDateArray) {
        _OutDateArray=[NSMutableArray array];
    }
    return _OutDateArray;
}

- (NSTimeZone*)timeZone
{
    
    if (_timeZone == nil) {
        [UIColor blueColor];
        _timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    }
    return _timeZone;
}


- (NSArray*)weekdays
{
    
    if (_weekdays == nil) {
        
        _weekdays = [NSArray arrayWithObjects: [NSNull null], @"0", @"1", @"2", @"3", @"4", @"5", @"6", nil];
        
    }
    return _weekdays;
}

- (NSCalendar*)calender
{
    
    if (_calender == nil) {
        
        _calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    
    return _calender;
}
- (NSDateComponents*)comps
{
    
    if (_comps == nil) {
        
        _comps = [[NSDateComponents alloc] init];
        
    }
    
    return _comps;
}
- (NSDateFormatter*)formatter
{
    
    if (_formatter == nil) {
        
        _formatter =[[NSDateFormatter alloc]init];
        [_formatter setDateFormat:@"yyyy-MM-dd"];
    }
    return _formatter;
}


- (instancetype)init
{
    if (self=[super init] ) {
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.pageIndex=0;
        self.date=[NSDate date];
        [self creatUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame andSelectArray:(NSArray *)dateArray
{
    if (self=[self initWithFrame:frame]) {
        if (dateArray) {
            [self.OutDateArray addObjectsFromArray:dateArray];
            [self.collectionView reloadData];
        }
    }
    return self;
}
- (void)creatUI{
    
    float cellw =kScreenW/7-1;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setItemSize:CGSizeMake(cellw, cellw)];//设置cell的尺寸
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置其布局方向
    [flowLayout setHeaderReferenceSize:CGSizeMake(kScreenW, 50)];
    [flowLayout setMinimumInteritemSpacing:0]; //设置 y 间距
    [flowLayout setMinimumLineSpacing:0]; //设置 x 间距
//    flowLayout.sectionInset = UIEdgeInsetsMake(5, 0, 10, 0);//设置其边界
    //UIEdgeInsetsMake(设置上下cell的上间距,设置cell左距离,设置上下cell的下间距,设置cell右距离);
    
    //其布局很有意思，当你的cell设置大小后，一行多少个cell，由cell的宽度决定
    
    datecollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, CGRectGetHeight(self.frame)) collectionViewLayout:flowLayout];
    datecollectionView.dataSource = self;
    datecollectionView.delegate = self;
    datecollectionView.backgroundColor = [UIColor whiteColor];
    datecollectionView.scrollEnabled=NO;
    //    注册cell
    [datecollectionView registerNib:[UINib nibWithNibName:@"ZFTimerCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    [datecollectionView registerNib:[UINib nibWithNibName:@"ZFChooseTimeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self addSubview:datecollectionView];
}
#pragma mark --- <UICollectionViewDataSource>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    CGSize size={kDeviceWidth,70};
    return size;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 42;
    
//    NSDate *dateList = [self getPriousorLaterDateFromDate:newDate withMonth:section+self.pageIndex];
//    
//    NSString *timerNsstring = [self getMonthBeginAndEndWith:dateList];
//    NSInteger p_0 = [timerNsstring integerValue];
//    NSInteger p_1 = [self getNumberOfDays:dateList] + p_0;
//    
//    return p_1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZFChooseTimeCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    NSDate*dateList = [self getPriousorLaterDateFromDate:newDate withMonth:indexPath.section+self.pageIndex];
    
    NSArray*array = [self timeString:newDate many:indexPath.section+self.pageIndex];
    
    NSInteger p = indexPath.row -[self getMonthBeginAndEndWith:dateList].intValue+1;
    
    NSString *str;
    
    if (p<10)
    {
        
        str = p > 0 ? [NSString stringWithFormat:@"0%ld",(long)p]:[NSString stringWithFormat:@"-0%ld",(long)-p];
        
    }
    else
    {
        
        str = [NSString stringWithFormat:@"%ld",(long)p];
    }
    
    
    NSArray *list = @[array[0], array[1], str];
    
    [cell updateDay:list withSelectArray:self.OutDateArray];
    
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        ZFTimerCollectionReusableView * headerCell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        
        [headerCell updateTimer:[self timeString:newDate many:indexPath.section+self.pageIndex]];
        __weak typeof(self) unself=self;
        headerCell.NextClick=^(ClickType type){
            if (type==LeftType) {
                unself.pageIndex--;
            }
            else
                unself.pageIndex++;
            [unself.collectionView reloadData];
        };
        return headerCell;
    }
    return nil;
}

//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    MyLog(@"Des%lu",indexPath.row);
//    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
//}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDate*dateList = [self getPriousorLaterDateFromDate:newDate withMonth:indexPath.section+self.pageIndex];
    NSInteger p = indexPath.row -[self getMonthBeginAndEndWith:dateList].intValue+1;
    NSInteger currentnum=[self getNumberOfDays:[self getPriousorLaterDateFromDate:dateList withMonth:0]];
    if (p>0&&p-currentnum<=0)
    {
        NSArray *array = [self timeString:newDate many:indexPath.section+self.pageIndex];
        
        NSString *str = p < 10 ? [NSString stringWithFormat:@"0%ld",(long)p]:[NSString stringWithFormat:@"%ld",(long)p];
        NSString *selectDate=[@[array[0],array[1],str] componentsJoinedByString:@"-"];
        // 需要对比的时间数据
        if (!self.OutDateArray.count) {
            [self.OutDateArray addObject:selectDate];
        }
        else if (self.OutDateArray.count==1){
            NSString *dateStr=self.OutDateArray.firstObject;
            NSTimeInterval timenum=[[self.formatter dateFromString:dateStr] timeIntervalSinceDate:[self.formatter dateFromString:selectDate]];
            if (timenum>0) {
                [self.OutDateArray insertObject:selectDate atIndex:0];
            }
            else
                [self.OutDateArray addObject:selectDate];

        }
        else
        {
            NSString *firstdateStr=self.OutDateArray.firstObject;
            NSString *seconddateStr=self.OutDateArray.lastObject;
            
            NSTimeInterval firsttimenum=[[self.formatter dateFromString:firstdateStr] timeIntervalSinceDate:[self.formatter dateFromString:selectDate]];
            NSTimeInterval secondtimenum=[[self.formatter dateFromString:seconddateStr] timeIntervalSinceDate:[self.formatter dateFromString:selectDate]];
            if (firsttimenum>0) {
                [self.OutDateArray replaceObjectAtIndex:0 withObject:selectDate];
            }
            else if (secondtimenum<0)
                [self.OutDateArray replaceObjectAtIndex:1 withObject:selectDate];
            else
            {
                if (fabs(firsttimenum)<=fabs(secondtimenum)) {
                    [self.OutDateArray replaceObjectAtIndex:0 withObject:selectDate];
                }
                else
                    [self.OutDateArray replaceObjectAtIndex:1 withObject:selectDate];
            }
        }
        MyLog(@"did%lu",indexPath.row);
        [self.collectionView reloadData];
    }
    
    
}
#pragma mark ---
#pragma mark --- 各种方法
/**
 *  根据当前月获取有多少天
 *
 *  @param dayDate 但前时间
 *
 *  @return 天数
 */
- (NSInteger)getNumberOfDays:(NSDate *)dayDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:dayDate];
    
    return range.length;
    
}
/**
 *  根据前几月获取时间
 *
 *  @param date  当前时间
 *  @param month 第几个月 正数为前  负数为后
 *
 *  @return 获得时间
 */
- (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(NSInteger)month

{
    [self.comps setMonth:month];
    
    NSDate *mDate = [self.calender dateByAddingComponents:self.comps toDate:date options:0];
    return mDate;
    
}



/**
 *  根据时间获取周几
 *
 *  @param inputDate 输入参数是NSDate，
 *
 *  @return 输出结果是星期几的字符串。
 */
- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    
    
    
    [self.calender setTimeZone: self.timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [self.calender components:calendarUnit fromDate:inputDate];
    
    return [self.weekdays objectAtIndex:theComponents.weekday];
    
}
/**
 *  获取第N个月的时间
 *
 *  @param currentDate 当前时间
 *  @param index 第几个月 正数为前  负数为后
 *
 *  @return @“2016年3月”
 */
- (NSArray*)timeString:(NSDate*)currentDate many:(NSInteger)index;
{
    
    NSDate *getDate =[self getPriousorLaterDateFromDate:currentDate withMonth:index];
    
    NSString  *str =  [self.formatter stringFromDate:getDate];
    
    return [str componentsSeparatedByString:@"-"];
}

/**
 *  根据时间获取第一天周几
 *
 *  @param dateStr 时间
 *
 *  @return 周几
 */
- (NSString*)getMonthBeginAndEndWith:(NSDate *)dateStr{
    
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:dateStr];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return @"";
    }
    
    return   [self weekdayStringFromDate:beginDate];
}


@end
