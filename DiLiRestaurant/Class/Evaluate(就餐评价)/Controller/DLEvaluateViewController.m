//
//  WKWebViewController.m
//  JS_OC_WebViewJavascriptBridge
//
//  Created by Harvey on 16/8/4.
//  Copyright © 2016年 Haley. All rights reserved.
//

#import "DLEvaluateViewController.h"
#import "DLEatingCalendarViewController.h"
#import "DLEatedInfo.h"
#import "DLAddFoodParentViewController.h"
#import "DLHaveMealsTableViewCell.h"
#import "WebViewController.h"
@interface DLEvaluateViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(weak,nonatomic)UITableView *tableView;

@property(strong,nonatomic)NSMutableArray <NSArray *>*dataArray;

@property(copy,nonatomic)NSString *CurrentDate;
@property(strong,nonatomic)NSDateFormatter *formatter;

@property(weak,nonatomic)UIButton *appearDateButton;

@property(weak,nonatomic)UIButton *rightButton;

@property(weak,nonatomic)UIView *NoDataView;

@property(assign,nonatomic)BOOL IsAddNewFoods;



@end

@implementation DLEvaluateViewController

- (NSDateFormatter*)formatter
{
    
    if (_formatter == nil) {
        
        _formatter =[[NSDateFormatter alloc]init];
        [_formatter setDateFormat:@"yyyy年MM月dd日"];
    }
    return _formatter;
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newFoodsAdd) name:@"addfoods" object:nil];
    self.view.backgroundColor=BackGroundColor;
    self.CurrentDate=[self.formatter stringFromDate:[NSDate date]];
    [self getData];
    [self creatHeadView];
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, kScreenW, kScreenH-64-40-49-60) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView=tableView;
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DLHaveMealsTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"meals"];
    [self createTableHead];
    [self createFootView];
}
- (void)createFootView{
    UIView *footview=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), kScreenH, 44)];
    [self.view addSubview:footview];
    UIButton *finishbutton=[[UIButton alloc]initWithFrame:CGRectMake(50, 7, kScreenW-100, 44)];
    finishbutton.layer.cornerRadius=22;
    finishbutton.layer.masksToBounds=YES;
    finishbutton.backgroundColor=THEMECOLOR;
    [finishbutton setTitle:@"完成记录,快去评价" forState:UIControlStateNormal];
    [finishbutton addTarget:self action:@selector(finishEating:) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:finishbutton];
}
- (void)createTableHead{
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 44)];
    NSArray *array=@[@"添加早餐",@"breakfase_icon_normal",@"添加午餐",@"lunch_icon_normal",@"添加晚餐",@"dinner_icon_normal"];
    CGFloat buttonW=kScreenW/array.count*2;
    for (int i=0; i<array.count/2; i++) {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(i*buttonW, 0, buttonW, CGRectGetHeight(headView.frame))];
        [button setTitle:array[i*2] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font=font14;
        [button setImage:[UIImage imageNamed:array[2*i+1]] forState:UIControlStateNormal];
        button.imageView.contentMode=UIViewContentModeScaleAspectFit;
        button.tag=i+1;
        [button addTarget:self action:@selector(addFoot:) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:button];
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(button.frame)-1, 7, 1, 30)];
        lineView.backgroundColor=[UIColor lightGrayColor];
        [headView addSubview:lineView];
        
    }
    self.tableView.tableHeaderView=headView;
    
}

- (void)creatHeadView{
    
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 44)];
    [self.view addSubview:headView];
    
    UIButton *leftButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, headView.height)];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    leftButton.tag=0;
    [leftButton setTitle:@"前一天" forState:UIControlStateNormal];
    [headView addSubview:leftButton];
    
    UIView *leftlineView=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftButton.frame), 5, 1, headView.height-10)];
    leftlineView.backgroundColor=shouldgraycolor;
    [headView addSubview:leftlineView];
    [leftButton addTarget:self action:@selector(dateDownOrUp:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightButton=[[UIButton alloc]initWithFrame:CGRectMake(kScreenW-80, 0, 80, headView.height)];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton setTitleColor:shouldgraycolor forState:UIControlStateSelected];
    [rightButton setTitle:@"后一天" forState:UIControlStateNormal];
    [rightButton setTitle:@"后一天" forState:UIControlStateSelected];

    rightButton.tag=1;
    rightButton.selected=YES;
    rightButton.userInteractionEnabled=!rightButton.isSelected;
    [headView addSubview:rightButton];
    self.rightButton=rightButton;
    [rightButton addTarget:self action:@selector(dateDownOrUp:) forControlEvents:UIControlEventTouchUpInside];
    UIView *rightlineView=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(rightButton.frame)-1, 5, 1, headView.height-10)];
    rightlineView.backgroundColor=shouldgraycolor;
    [headView addSubview:rightlineView];

    UIButton *dateLabel=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftlineView.frame), 0, kScreenW-162, headView.height)];
    dateLabel.titleLabel.textAlignment=NSTextAlignmentCenter;
    dateLabel.titleLabel.font=font14;
    [dateLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    NSString *str=[NSString stringWithFormat:@"%@ (%@)",self.CurrentDate,[Globel weekdayStringFromDate:[self.formatter dateFromString:self.CurrentDate]]];
    [dateLabel setAttributedTitle:[Globel returnAttributedstringFromstring:str andlocation:12 andLength:str.length-12 andAttributeStringColor:THEMECOLOR andFondSize:12] forState:UIControlStateNormal];
    [dateLabel addTarget:self action:@selector(checkDate:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:dateLabel];
    self.appearDateButton=dateLabel;
    
}

- (void)dateDownOrUp:(UIButton *)sender{
    if (!sender.tag) {
        NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:[self.formatter dateFromString:self.CurrentDate]];//前一天
        self.CurrentDate=[self.formatter stringFromDate:lastDay];
        self.rightButton.selected=NO;
        self.rightButton.userInteractionEnabled=YES;
    }
    else
    {   NSDate *nextDay = [NSDate dateWithTimeInterval:24*60*60 sinceDate:[self.formatter dateFromString:self.CurrentDate]];//后一天
        if ([[self.formatter stringFromDate:nextDay] isEqualToString:[self.formatter stringFromDate:[NSDate date]]]) {
            sender.selected=YES;
            sender.userInteractionEnabled=NO;
        }
        self.CurrentDate=[self.formatter stringFromDate:nextDay];
    }
    NSString *str=[NSString stringWithFormat:@"%@ (%@)",self.CurrentDate,[Globel weekdayStringFromDate:[self.formatter dateFromString:self.CurrentDate]]];
    [self.appearDateButton setAttributedTitle:[Globel returnAttributedstringFromstring:str andlocation:12 andLength:str.length-12 andAttributeStringColor:THEMECOLOR andFondSize:12] forState:UIControlStateNormal];
    [self.NoDataView removeFromSuperview];
    [self getData];
}

- (void)checkDate:(UIButton *)sender{
    DLEatingCalendarViewController *calendarVC=[[DLEatingCalendarViewController alloc]init];
    calendarVC.currentdate=[self.formatter dateFromString:self.CurrentDate];
    __weak typeof(self) unself=self;
    calendarVC.selectDate=^(NSDate *date){
        unself.CurrentDate=[unself.formatter stringFromDate:date];
        if ([[unself.formatter stringFromDate:date] isEqualToString:[unself.formatter stringFromDate:[NSDate date]]]) {
            unself.rightButton.selected=YES;
            unself.rightButton.userInteractionEnabled=NO;
        }
        else
        {
            unself.rightButton.selected=NO;
            unself.rightButton.userInteractionEnabled=YES;
        }

        NSString *str=[NSString stringWithFormat:@"%@ (%@)",unself.CurrentDate,[Globel weekdayStringFromDate:[unself.formatter dateFromString:unself.CurrentDate]]];
        [sender setAttributedTitle:[Globel returnAttributedstringFromstring:str andlocation:12 andLength:str.length-12 andAttributeStringColor:THEMECOLOR andFondSize:12] forState:UIControlStateNormal];
        [unself.NoDataView removeFromSuperview];
        [unself getData];
    };
    [self.navigationController pushViewController:calendarVC animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array=self.dataArray[section];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *titleArray=@[@"早餐",@"午餐",@"晚餐"];
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=BackGroundColor;
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 7, 60, 30)];
    titleLabel.font=font14;
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.backgroundColor=THEMECOLOR;
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.text=titleArray[section];
    titleLabel.layer.cornerRadius=15;
    titleLabel.layer.masksToBounds=YES;
    [view addSubview:titleLabel];
    
    NSArray *array=self.dataArray[section];
    CGFloat sumcount=0;
    for (int i=0; i<array.count; i++) {
        DLHaveMealsInfo *mealsinfo=array[i];
        sumcount+=mealsinfo.energyKc;
    }
    UILabel *detaillabel=[[UILabel alloc]initWithFrame:CGRectMake(kScreenW-200, 0, 190, 44)];
    detaillabel.font=[UIFont systemFontOfSize:14];
    NSString *str=[NSString stringWithFormat:@"能量: %.02fkcal",sumcount];
    detaillabel.attributedText=[Globel returnAttributedstringFromstring:str andlocation:4 andLength:str.length-4 andAttributeStringColor:THEMECOLOR andFondSize:14];
    [view addSubview:detaillabel];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSArray *array=self.dataArray[section];
    if (!array.count) {
        return 0;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLHaveMealsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"meals" forIndexPath:indexPath];
    NSArray *array=self.dataArray[indexPath.section];
    cell.mearsInfo=array[indexPath.row];
    return cell;

}
- (void)getData{
    NSMutableDictionary *updatedic=[NSMutableDictionary dictionary];
    [updatedic setObject:@"C0116" forKey:@"transCode"];
    [updatedic setObject:@"findAll" forKey:@"type"];
    [updatedic setObject:[[Globel getDateFormatter] stringFromDate:[self.formatter dateFromString:self.CurrentDate]] forKey:@"time"];
    [updatedic setObject:[DLUserInfo getUser].userId forKey:@"userId"];
    
    [[GLNetWorkManager shareManager]requestType:POST andURL:REQUESTURL andServers:GET_WORK_TYPE andParmas:updatedic andComplition:^(id response, BOOL isuccess) {
        if (isuccess&&[response[@"code"] isEqualToString:SUCCESSCODE]) {
            [self.dataArray removeAllObjects];
            [DLEatedInfo mj_setupObjectClassInArray:^NSDictionary *{
                return @{@"morn":@"DLHaveMealsInfo",@"afternoon":@"DLHaveMealsInfo",@"even":@"DLHaveMealsInfo"};
            }];
            DLEatedInfo *eatInfo=[DLEatedInfo mj_objectWithKeyValues:response];
            [self.dataArray addObject:eatInfo.morn];
            [self.dataArray addObject:eatInfo.afternoon];
            [self.dataArray addObject:eatInfo.even];
            if (!self.dataArray[0].count&&!self.dataArray[1].count&&!self.dataArray[2].count) {
                [self NoEatedView];
            }
            else
                [self.tableView reloadData];
        }
    }];

}

- (void)NoEatedView{
    UIView *bgview=[[UIView alloc]initWithFrame:CGRectMake(0, 44, kScreenW, kScreenH-64-49-44)];
    bgview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bgview];
    self.NoDataView=bgview;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW*2/5)];
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    imageView.image=[UIImage imageNamed:@"warning"];
    [bgview addSubview:imageView];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), kScreenW, 30)];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor redColor];
    label.text=@"很抱歉!";
    label.font=[UIFont systemFontOfSize:22];
    [bgview addSubview:label];
    
    UILabel *detaillabel=[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(label.frame), kScreenW-40, 80)];
    detaillabel.numberOfLines=0;
    detaillabel.textColor=shouldgraycolor;
    detaillabel.textAlignment=NSTextAlignmentCenter;
    detaillabel.font=font16;
    detaillabel.text=@"小二不知道您今天吃了啥哦?无法为您进行餐后评价:(请添加三餐,以便小二更好的为您服务.)";
    [bgview addSubview:detaillabel];
    
    NSArray *array=@[@"添加早餐",@"breakfase_icon_pressed",@"添加午餐",@"lunch_icon_pressed",@"添加晚餐",@"dinner_icon_pressed"];
    CGFloat viewY=CGRectGetMaxY(detaillabel.frame)+20;
    for (int i=0; i<array.count/2; i++) {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(kScreenW/2.0-80, i*(44+20)+viewY, 160, 44)];
        [button setImage:[UIImage imageNamed:array[i*2+1]] forState:UIControlStateNormal];
        button.tag=i+1;
        [button addTarget:self action:@selector(addFoot:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:array[i*2] forState:UIControlStateNormal];
        [button setTitleColor:THEMECOLOR forState:UIControlStateNormal];
        [bgview addSubview:button];
        button.layer.borderColor=THEMECOLOR.CGColor;
        button.layer.borderWidth=1.0;
    }
    
}

- (void)addFoot:(UIButton *)sender{
    DLAddFoodParentViewController *addfoot=[[DLAddFoodParentViewController alloc]init];
    addfoot.timeType=sender.tag;
    addfoot.curentdate=[[Globel getDateFormatter] stringFromDate:[self.formatter dateFromString:self.CurrentDate]];
    __weak typeof(self) unself=self;
    addfoot.finishAdd=^{
        [unself newFoodsAdd];
    };
    [self.navigationController pushViewController:addfoot animated:YES];
    
}
- (void)newFoodsAdd{
    self.IsAddNewFoods=YES;
    [self.NoDataView removeFromSuperview];
    [self getData];
 
}
- (void)finishEating:(UIButton *)sender{
    WebViewController *webview=[[WebViewController alloc]init];
    NSString *str=[NSString stringWithFormat:@"%@%@userId=%@&time=%@&random=%lu",REQUEHTML5STURL,AfterUrl,[DLUserInfo getUser].userId,[[Globel getDateFormatter] stringFromDate:[self.formatter dateFromString:self.CurrentDate]],random()/10000];
    if (self.IsAddNewFoods) {
        str=[str stringByAppendingString:@"&flag=1"];
        self.IsAddNewFoods=NO;
    }
    webview.urlSring=str;
    [self.navigationController pushViewController:webview animated:YES];
}
@end
