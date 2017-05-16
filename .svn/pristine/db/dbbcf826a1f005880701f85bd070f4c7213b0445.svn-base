//
//  DLWalkingViewController.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/31.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLWalkingViewController.h"
#import <HealthKit/HealthKit.h>
#import "UICountingLabel.h"
#import "DLEatedInfo.h"
#define CustomStep @"customstepcount"
@interface DLWalkingViewController ()

@property(nonatomic ,strong)HKHealthStore *healthStore;

@property(assign,nonatomic)NSInteger stepCount;

@property(strong,nonatomic)DLEatedInfo *eatInfo;

@property(assign,nonatomic)NSInteger targetStep;

@property(weak,nonatomic)UICountingLabel *targetLabel;

@property(weak,nonatomic)UICountingLabel *unfinishLabel;

@end

@implementation DLWalkingViewController

- (HKHealthStore *)healthStore
{
    if (!_healthStore) {
        _healthStore=[[HKHealthStore alloc]init];
    }
    return _healthStore;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.stepCount=0;
    if ([HKHealthStore isHealthDataAvailable]) {
        NSSet *readset=[NSSet setWithObject:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount]];
        [self.healthStore requestAuthorizationToShareTypes:nil readTypes:readset completion:^(BOOL success, NSError * _Nullable error) {
            [self JudgmentAuthority];
            [self getStepCount];
        }];
    }
}

- (void)JudgmentAuthority{
    HKQuantityType *quantityType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = 7;
    HKStatisticsCollectionQuery *collectionQuery = [[HKStatisticsCollectionQuery alloc] initWithQuantityType:quantityType quantitySamplePredicate:nil options: HKStatisticsOptionCumulativeSum | HKStatisticsOptionSeparateBySource anchorDate:[NSDate dateWithTimeIntervalSince1970:0] intervalComponents:dateComponents];
    collectionQuery.initialResultsHandler = ^(HKStatisticsCollectionQuery *query, HKStatisticsCollection * __nullable result, NSError * __nullable error) {
        if (!result.statistics.count) {
            UIAlertController *alertVC=[UIAlertController alertControllerWithTitle:@"提示" message:@"为了获取您的运动情况请前往健康APP进行授权" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancle=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alertVC addAction:cancle];
            [self presentViewController:alertVC animated:YES completion:nil];
            //
        }

//        for (HKStatistics *statistic in result.statistics) {
//            NSLog(@"\n%@ 至 %@", statistic.startDate, statistic.endDate);
//            for (HKSource *source in statistic.sources) {
//                if ([source.name isEqualToString:[UIDevice currentDevice].name]) {
//                    NSLog(@"%@ -- %f",source, [[statistic sumQuantityForSource:source] doubleValueForUnit:[HKUnit countUnit]]);
//                }
//            }
//        }
    };
    [self.healthStore executeQuery:collectionQuery];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, (kScreenH-49)/2.0)];
    headImageView.image=[UIImage imageNamed:@"stepHead"];
    [self.view addSubview:headImageView];
    headImageView.userInteractionEnabled=YES;
    UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 65, kScreenW, 40)];
    nameLabel.textAlignment=NSTextAlignmentCenter;
    nameLabel.text=@"需要完成健步走的步数";
    nameLabel.textColor=[UIColor whiteColor];
    nameLabel.font=font20;
    [headImageView addSubview:nameLabel];
    
    UICountingLabel *targetlabel=[[UICountingLabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLabel.frame)+20, kScreenW, 50)];
    targetlabel.textAlignment=NSTextAlignmentCenter;
    targetlabel.textColor=[UIColor whiteColor];
    targetlabel.font=[UIFont systemFontOfSize:60 weight:3];
    targetlabel.format=@"%d";
    [headImageView addSubview:targetlabel];
    self.targetLabel=targetlabel;
    
    DLRoundEdgeButton *setbutton=[[DLRoundEdgeButton alloc]initWithFrame:CGRectMake((kScreenW-100)/2.0, CGRectGetMaxY(targetlabel.frame)+30, 100, 40)];
    setbutton.layer.borderColor=[UIColor whiteColor].CGColor;
    setbutton.layer.borderWidth=1.0;
    [setbutton addTarget:self action:@selector(setTargetStepCount:) forControlEvents:UIControlEventTouchUpInside];
    [setbutton setTitle:@"设置" forState:UIControlStateNormal];
    [setbutton setImage:[UIImage imageNamed:@"stepset"] forState:UIControlStateNormal];
    [headImageView addSubview:setbutton];
    
    
    
    UIImageView *footImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headImageView.frame), kScreenW, (kScreenH-49)/2.0)];
    footImageView.image=[UIImage imageNamed:@"stepFoot"];
    [self.view addSubview:footImageView];

    
    UICountingLabel *unfinishlabel=[[UICountingLabel alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 50)];
    unfinishlabel.center=CGPointMake(footImageView.width/2, footImageView.height/2);
    unfinishlabel.textAlignment=NSTextAlignmentCenter;
    unfinishlabel.font=[UIFont systemFontOfSize:60 weight:3];
    unfinishlabel.format=@"%d";
    [footImageView addSubview:unfinishlabel];
    self.unfinishLabel=unfinishlabel;
    
    UILabel *unfinishnameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(unfinishlabel.frame)-70, kScreenW, 40)];
    unfinishnameLabel.textAlignment=NSTextAlignmentCenter;
    unfinishnameLabel.text=@"未完成步数";
    unfinishnameLabel.font=font20;
    [footImageView addSubview:unfinishnameLabel];

    // Do any additional setup after loading the view.
}

- (void)getStepCount{
    HKQuantityType *stepCountType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    //NSSortDescriptors用来告诉healthStore怎么样将结果排序。
    NSSortDescriptor *start = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
    NSSortDescriptor *end = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    // 当天时间段
    NSPredicate *todayPredicate = [self predicateForSamplesToday];
    HKSampleQuery *sampleQuery = [[HKSampleQuery alloc] initWithSampleType:stepCountType predicate:todayPredicate limit:HKObjectQueryNoLimit sortDescriptors:@[start, end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
//        if (!results.count) {
//            UIAlertController *alertVC=[UIAlertController alertControllerWithTitle:@"提示" message:@"为了获取您的运动情况请前往健康APP进行授权" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *cancle=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
//            [alertVC addAction:cancle];
//            [self presentViewController:alertVC animated:YES completion:nil];
//            //
//        }
//        else
            [results enumerateObjectsUsingBlock:^(__kindof HKQuantitySample * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HKQuantity *quantity = obj.quantity;
            HKUnit *stepCount = [HKUnit countUnit];
            double count = [quantity doubleValueForUnit:stepCount];
            self.stepCount+=count;
            MyLog(@"%f",count);
        }];
        NSString *customStep=[[NSUserDefaults standardUserDefaults]objectForKey:CustomStep];
        if (strIsEmpty(customStep)) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getData];
            });
        }
        else{
            self.targetStep=customStep.integerValue;
            [self.targetLabel countFrom:0 to:self.targetStep];
            if (self.targetStep>self.stepCount) {
                [self.unfinishLabel countFrom:0 to:self.targetStep-self.stepCount];
            }
            else
            {
                self.unfinishLabel.text=@"0";
            }
        }

    }];
    [self.healthStore executeQuery:sampleQuery];
}
// 当天时间段
- (NSPredicate *)predicateForSamplesToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *now = [NSDate date];
    
    NSDate *startDate = [calendar startOfDayForDate:now];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    
    return [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
}

- (void)getData{
    NSMutableDictionary *updatedic=[NSMutableDictionary dictionary];
    [updatedic setObject:@"C0116" forKey:@"transCode"];
    [updatedic setObject:@"findAll" forKey:@"type"];
    [updatedic setObject:[[Globel getDateFormatter] stringFromDate:[NSDate date]] forKey:@"time"];
    [updatedic setObject:[DLUserInfo getUser].userId forKey:@"userId"];
    
    [[GLNetWorkManager shareManager]requestType:POST andURL:REQUESTURL andServers:GET_WORK_TYPE andParmas:updatedic andComplition:^(id response, BOOL isuccess) {
        if (isuccess&&[response[@"code"] isEqualToString:SUCCESSCODE]) {
            [self.dataArray removeAllObjects];
            [DLEatedInfo mj_setupObjectClassInArray:^NSDictionary *{
                return @{@"morn":@"DLHaveMealsInfo",@"afternoon":@"DLHaveMealsInfo",@"even":@"DLHaveMealsInfo"};
            }];
            self.eatInfo=[DLEatedInfo mj_objectWithKeyValues:response];
            [self countEnergy];
            [self.targetLabel countFrom:0 to:self.targetStep];
            if (self.targetStep>self.stepCount) {
                [self.unfinishLabel countFrom:0 to:self.targetStep-self.stepCount];
            }
            else
            {
                self.unfinishLabel.text=@"0";
            }

        }
    }];
    
}
- (void)countEnergy{
    switch ([Globel getStepTimeStageFromCurrentDate]) {
        case 0 : case 1:
            {
                if (self.eatInfo.morn.count) {
                    __block CGFloat count=0;
                    [self.eatInfo.morn enumerateObjectsUsingBlock:^(DLHaveMealsInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        count+=obj.energyKc;
                    }];
                    if (count>[DLUserInfo getUserDetail].energyKC*0.2*1.2) {
                        self.targetStep=(count -[DLUserInfo getUserDetail].energyKC*0.2)*33+4000;;
                    }
                    else
                        self.targetStep=4000;
                }
                else
                    self.targetStep=4000;
            }
            break;
        case 2: case 3:
            {
                if (self.eatInfo.afternoon.count) {
                    __block CGFloat count=0;
                    [self.eatInfo.afternoon enumerateObjectsUsingBlock:^(DLHaveMealsInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        count+=obj.energyKc;
                    }];
                    [self.eatInfo.morn enumerateObjectsUsingBlock:^(DLHaveMealsInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        count+=obj.energyKc;
                    }];

                    if (count>[DLUserInfo getUserDetail].energyKC*0.6*1.2) {
                        self.targetStep=(count -[DLUserInfo getUserDetail].energyKC*0.6)*33+4000;;
                    }
                    else
                        self.targetStep=4000;
                }
                else
                {
                    if (self.eatInfo.morn.count) {
                        __block CGFloat count=0;
                        [self.eatInfo.morn enumerateObjectsUsingBlock:^(DLHaveMealsInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            count+=obj.energyKc;
                        }];
                        if (count>[DLUserInfo getUserDetail].energyKC*0.2*1.2) {
                            self.targetStep=(count -[DLUserInfo getUserDetail].energyKC*0.2)*33+4000;;
                        }
                        else
                            self.targetStep=4000;
                    }
                    else
                        self.targetStep=4000;

                }
            }
            break;
        case 4: case 5:
            {
                if (self.eatInfo.even.count) {
                    __block CGFloat count=0;
                    [self.eatInfo.even enumerateObjectsUsingBlock:^(DLHaveMealsInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        count+=obj.energyKc;
                    }];
                    [self.eatInfo.afternoon enumerateObjectsUsingBlock:^(DLHaveMealsInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        count+=obj.energyKc;
                    }];
                    [self.eatInfo.morn enumerateObjectsUsingBlock:^(DLHaveMealsInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        count+=obj.energyKc;
                    }];
                    
                    if (count>[DLUserInfo getUserDetail].energyKC*1.2) {
                        self.targetStep=(count -[DLUserInfo getUserDetail].energyKC)*33+4000;;
                    }
                    else
                        self.targetStep=4000;
                }
                else
                {
                    if (self.eatInfo.afternoon.count) {
                        __block CGFloat count=0;
                        [self.eatInfo.afternoon enumerateObjectsUsingBlock:^(DLHaveMealsInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            count+=obj.energyKc;
                        }];
                        [self.eatInfo.morn enumerateObjectsUsingBlock:^(DLHaveMealsInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            count+=obj.energyKc;
                        }];
                        
                        if (count>[DLUserInfo getUserDetail].energyKC*0.6*1.2) {
                            self.targetStep=(count -[DLUserInfo getUserDetail].energyKC*0.6)*33+4000;;
                        }
                        else
                            self.targetStep=4000;
                    }
                    else
                    {
                        if (self.eatInfo.morn.count) {
                            __block CGFloat count=0;
                            [self.eatInfo.morn enumerateObjectsUsingBlock:^(DLHaveMealsInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                count+=obj.energyKc;
                            }];
                            if (count>[DLUserInfo getUserDetail].energyKC*0.2*1.2) {
                                self.targetStep=(count -[DLUserInfo getUserDetail].energyKC*0.2)*33+4000;;
                            }
                            else
                                self.targetStep=4000;
                        }
                        else
                            self.targetStep=4000;
                        
                    }
                }

            }
            break;
        default:
            break;
    }
}

- (void)setTargetStepCount:(UIButton *)sender{
    TYAlertView *alertView=[TYAlertView alertViewWithTitle:@"设置" message:@"目标步数"];
    TYAlertAction *cancle=[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:nil];
    __weak typeof(alertView) weakalertView=alertView;
    __weak typeof(self) unself=self;
    TYAlertAction *sure=[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDefault handler:^(TYAlertAction *action) {
        [weakalertView.textFieldArray enumerateObjectsUsingBlock:^(UITextField   *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.text.boolValue) {
                unself.targetStep=[obj.text integerValue];
                [unself.targetLabel countFrom:0 to:unself.targetStep];
                if (unself.targetStep>unself.stepCount) {
                    [unself.unfinishLabel countFrom:0 to:unself.targetStep-unself.stepCount];
                }
                else
                {
                    unself.unfinishLabel.text=@"0";
                }

                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%lu",self.targetStep] forKey:CustomStep];
            }
        }];
    }];
    [alertView addAction:cancle];
    [alertView addAction:sure];
    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入自定义步数";
        textField.keyboardType=UIKeyboardTypePhonePad;
    }];

    TYAlertController *alertVC=[TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert transitionAnimation:TYAlertTransitionAnimationScaleFade];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
