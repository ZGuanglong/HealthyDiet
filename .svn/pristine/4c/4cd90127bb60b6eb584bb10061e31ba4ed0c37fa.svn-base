//
//  DLMineBaseViewController.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/3/15.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLMineBaseViewController.h"
#import "AppDelegate.h"
@interface DLMineBaseViewController ()

@end

@implementation DLMineBaseViewController
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type==FirstType) {
        self.navigationItem.leftBarButtonItem=nil;
        self.navigationItem.hidesBackButton=YES;
        self.navigationController.navigationItem.leftBarButtonItem=nil;
        id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
        [self.view addGestureRecognizer:pan];
    }
    self.view.backgroundColor=BackGroundColor;
    self.title=@"基本信息";
    TPKeyboardAvoidingScrollView *contentView=[[TPKeyboardAvoidingScrollView alloc]initWithFrame:self.view.frame];
    contentView.showsVerticalScrollIndicator=NO;
    contentView.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:contentView];
    self.ContentView=contentView;
    UILabel *label=[[UILabel alloc]init];
    [self.ContentView addSubview:label];
    self.titleLabel=label;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        (void)make.centerX;
    }];
    UIImageView *leftimageView=[[UIImageView alloc]init];
    leftimageView.contentMode=UIViewContentModeScaleAspectFit;
    leftimageView.image=[UIImage imageNamed:@"left_line"];
    [self.ContentView addSubview:leftimageView];
    [leftimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label.mas_centerY);
        make.right.mas_equalTo(label.mas_left).mas_offset(-10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    UIImageView *rightimageView=[[UIImageView alloc]init];
    rightimageView.contentMode=UIViewContentModeScaleAspectFit;
    rightimageView.image=[UIImage imageNamed:@"right_line"];
    [self.ContentView addSubview:rightimageView];
    [rightimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label.mas_centerY);
        make.left.mas_equalTo(label.mas_right).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    UIButton *doneButton=[[UIButton alloc]init];
    doneButton.backgroundColor=THEMECOLOR;
    if (self.type==FirstType) {
        [doneButton setTitle:@"下一步" forState:UIControlStateNormal];
    }
    else
        [doneButton setTitle:@"确定" forState:UIControlStateNormal];
//    [self.view addSubview:doneButton];
    [doneButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    doneButton.layer.masksToBounds=YES;
    doneButton.layer.cornerRadius=22;
    self.doneButton=doneButton;
    if (self.type==FirstType) {
        UIButton *skipButton=[[UIButton alloc]init];
        skipButton.backgroundColor=shouldgraycolor;
        [skipButton setTitle:@"跳过此步" forState:UIControlStateNormal];
        [skipButton addTarget:self action:@selector(skipMain) forControlEvents:UIControlEventTouchUpInside];
        skipButton.layer.masksToBounds=YES;
        skipButton.layer.cornerRadius=22;
        self.skipButton=skipButton;

    }
}
- (void)skipMain{
    NSMutableDictionary *updatedic=[NSMutableDictionary dictionary];
    [updatedic setObject:@"C0100" forKey:@"transCode"];
    [updatedic setObject:@"update" forKey:@"type"];
    [updatedic setObject:[DLUserInfo getUser].userId forKey:@"userId"];
    [updatedic setObject:[DLUser share].birthday forKey:@"birthday"];
    [updatedic setObject:[DLUser share].sex forKey:@"sex"];
    [updatedic setObject:[DLUser share].height forKey:@"height"];
    [updatedic setObject:[DLUser share].weight forKey:@"weight"];
    [updatedic setObject:[DLUser share].job forKey:@"job"];
    [updatedic setObject:[DLUser share].tabooCode forKey:@"tabooCode"];
    [updatedic setObject:[DLUser share].allergyName forKey:@"allergyName"];
    if (!strIsEmpty([DLUser share].homeProvinceCode)) {
        [updatedic setObject:[DLUser share].homeProvinceCode forKey:@"homeProvinceCode"];
        [updatedic setObject:[DLUser share].homeCityCode  forKey:@"homeCityCode"];
        [updatedic setObject:[DLUser share].homeDistrictId forKey:@"homeDistrictId"];
    }
    if (!strIsEmpty([DLUser share].currentProvinceCode)) {
        [updatedic setObject:[DLUser share].currentProvinceCode forKey:@"currentProvinceCode"];
        [updatedic setObject:[DLUser share].currentCityCode  forKey:@"currentCityCode"];
        [updatedic setObject:[DLUser share].currentDistrictId forKey:@"currentDistrictId"];
    }
    if (!strIsEmpty([DLUser share].chronicDiseaseCode)) {
        [updatedic setObject:[DLUser share].chronicDiseaseCode forKey:@"chronicDiseaseCode"];
    }
    if (!strIsEmpty([DLUser share].tasteCode)) {
        [updatedic setObject:[DLUser share].tasteCode forKey:@"tasteCode"];
    }
    if (!strIsEmpty([DLUser share].specialCrowdCode)) {
        [updatedic setObject:[DLUser share].specialCrowdCode forKey:@"specialCrowdCode"];
    }
    if (!strIsEmpty([DLUser share].periodStartTime)) {
        [updatedic setObject:[DLUser share].periodStartTime forKey:@"periodStartTime"];
        [updatedic setObject:[DLUser share].periodEndTime forKey:@"periodEndTime"];
        [updatedic setObject:[DLUser share].periodNum forKey:@"periodNum"];
    }
    if (!strIsEmpty([DLUser share].otherReq)) {
        [updatedic setObject:[DLUser share].otherReq forKey:@"otherReq"];
        [updatedic setObject:[DLUser share].targetWeight forKey:@"targetWeight"];
        [updatedic setObject:[DLUser share].reqType forKey:@"reqType"];
        
    }
    [[GLNetWorkManager shareManager]requestType:POST andURL:REQUESTURL andServers:GET_WORK_TYPE andParmas:updatedic andComplition:^(id response, BOOL isuccess) {
        if (isuccess&&[response[@"code"] isEqualToString:SUCCESSCODE]) {
            [self getuserinfo];
            [((AppDelegate *)[UIApplication sharedApplication].delegate) enterMainVC];
        }
    }];

    
}
-(void)done{
    
}
- (void)updateInfofromKey:(NSString *)key andValue:(NSString *)value
{
    self.returnValue=value;
    NSMutableDictionary *updatedic=[NSMutableDictionary dictionary];
    [updatedic setObject:@"C0100" forKey:@"transCode"];
    [updatedic setObject:@"update" forKey:@"type"];
    [updatedic setObject:[DLUserInfo getUser].userId forKey:@"userId"];
    [updatedic setObject:value forKey:key];
    [[GLNetWorkManager shareManager]requestType:POST andURL:REQUESTURL andServers:GET_WORK_TYPE andParmas:updatedic andComplition:^(id response, BOOL isuccess) {
        if (isuccess&&[response[@"code"] isEqualToString:SUCCESSCODE]) {
            [self getuserinfo];
        }
    }];

}

- (void)getuserinfo{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:[DLUserInfo getUser].userId forKey:@"userId"];
    [dic setObject:@"C0100" forKey:@"transCode"];
    [dic setObject:@"findDetail" forKey:@"type"];
    [[GLNetWorkManager shareManager]requestType:POST andURL:REQUESTURL andServers:GET_WORK_TYPE andParmas:dic andComplition:^(id response, BOOL isuccess) {
        if ([response[@"code"] isEqualToString:@"000000"]) {
            [DLUserInfo SaveUserInfoFromDic:response];
            if (self.selectFinish) {
                self.selectFinish(self.returnValue);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        
        MyLog(@"%@",response);
    }];
}

@end
