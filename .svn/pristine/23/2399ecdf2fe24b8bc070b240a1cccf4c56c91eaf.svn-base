//
//  DLCustomAddFoodsViewController.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/4/5.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLCustomAddFoodsViewController.h"
#import "DLAllergyCategaryTableViewCell.h"
#import "DLFoodDetailViewController.h"
#import "DLSearchFoodsViewController.h"
@interface DLCustomAddFoodsViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *leftTableView;
@property (nonatomic, weak) TPKeyboardAvoidingTableView *rightTableView;
@property(strong,nonatomic)NSMutableArray *dataArray;

@property(assign,nonatomic)NSInteger pageIndex;

@property(assign,nonatomic)BOOL IsmoreData;


@end

@implementation DLCustomAddFoodsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
- (NSMutableArray *)DetaildataArray
{
    if (!_DetaildataArray) {
        _DetaildataArray=[NSMutableArray array];
    }
    return _DetaildataArray;
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"菜品库";
    self.pageIndex=1;
    self.view.backgroundColor=BackGroundColor;
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 50)];
    headView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:headView];
    UITextField *textfield=[[UITextField alloc]initWithFrame:CGRectMake(20, 5, kScreenW-40, 40)];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    imageView.image=[UIImage imageNamed:@"search_icon"];
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    textfield.leftView=imageView;
    
    textfield.leftViewMode=UITextFieldViewModeAlways;
    textfield.borderStyle=UITextBorderStyleRoundedRect;
    textfield.placeholder=self.eatType==StoreType?@"请输入门店食物类型":@"请输入食物类型";
    textfield.delegate=self;
    [headView addSubview:textfield];
    
//    UIView *footView=[[UIView alloc]init];
//    [self.view addSubview:footView];
//    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
//        (void)make.left;
//        (void)make.bottom;
//        (void)make.right;
//        make.height.mas_equalTo(@60);
//    }];
//    UIButton *finishButton=[[UIButton alloc]initWithFrame:CGRectMake((kScreenW-200)/2, 8, 200, 44)];
//    finishButton.layer.cornerRadius=22;
//    finishButton.layer.masksToBounds=YES;
//    finishButton.backgroundColor=THEMECOLOR;
//    [finishButton setImage:[UIImage imageNamed:@"foodsfinish"] forState:UIControlStateNormal];
//    [finishButton setTitle:@"完成添加" forState:UIControlStateNormal];
//    [footView addSubview:finishButton];

    UITableView *lefttableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    lefttableView.delegate=self;
    lefttableView.dataSource=self;
    lefttableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:lefttableView];
    self.leftTableView=lefttableView;
    [lefttableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headView.mas_bottom).mas_offset(10);
        (void)make.left;
        (void)make.bottom;
        make.width.mas_equalTo(@100);
    }];
    TPKeyboardAvoidingTableView *rightTableView=[[TPKeyboardAvoidingTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    rightTableView.delegate=self;
    rightTableView.dataSource=self;
    rightTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:rightTableView];
    __weak typeof(self) unself=self;
    rightTableView.mj_footer=[MJRefreshBackFooter footerWithRefreshingBlock:^{
        if (unself.IsmoreData) {
            unself.pageIndex++;
            [unself getDetaildata];
        }
        else
        {
            [MBProgressHUD showMessage:@"没有更多的数据了"];
            [unself.rightTableView.mj_footer endRefreshing];
        }
    }];
    self.rightTableView=rightTableView;
    [rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headView.mas_bottom).mas_offset(10);
        (void)make.right;
        (void)make.bottom;
        make.left.mas_equalTo(lefttableView.mas_right);
    }];
    
    [lefttableView registerNib:[UINib nibWithNibName:NSStringFromClass([DLAllergyCategaryTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"left"];
    [rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([DLStoreFoodsTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"foods"];
    [self getData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.leftTableView) {
        return self.dataArray.count;
    }
    return self.DetaildataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.leftTableView) {
        return 80;
    }
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.leftTableView) {
        DLAllergyCategaryTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"left" forIndexPath:indexPath];
        cell.customInfo=self.dataArray[indexPath.row];
        return cell;
    }
    else{
        DLStoreFoodsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"foods" forIndexPath:indexPath];
        DLStorefoodsInfo *info=self.DetaildataArray[indexPath.row];
        if (self.IsLookFoods) {
            cell.eatType=0;
        }
        else
            cell.eatType=CustomType;
        cell.foodsInfo=info;
        //        __weak typeof(self) unself=self;
        return cell;

    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.leftTableView) {
        self.pageIndex=1;
        [self.DetaildataArray removeAllObjects];
        [self getDetaildata];
    }
    else
    {
        DLFoodDetailViewController *detailVC=[[DLFoodDetailViewController alloc]init];
        detailVC.foodsCode=self.DetaildataArray[indexPath.row].dishesCode;
        [self.navigationController pushViewController:detailVC animated:YES];
    }

    
}
- (void)getData{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic.transCode=@"M0038";
    dic.type=@"findAll";
    [dic setObject:@"1" forKey:@"dictType"];
    [[GLNetWorkManager shareManager]requestType:POST andURL:REQUESTURL andServers:GET_WORK_TYPE andParmas:dic andComplition:^(id response, BOOL isuccess) {
        if (isuccess&&[response[@"code"] isEqualToString:SUCCESSCODE]) {
            [self.dataArray addObjectsFromArray:[DLCustomFoodsCategaryInfo mj_objectArrayWithKeyValuesArray:response[@"list"]]];
            if (self.Eatingtime==1) {
               [self.dataArray removeObjectAtIndex:0];
            }
            [self.leftTableView reloadData];
            [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
            [self getDetaildata];
        }
        MyLog(@"%@",response);
    }];
}

- (void)getDetaildata{
    NSInteger leftselectindex=[self.leftTableView indexPathForSelectedRow].row;
    DLCustomFoodsCategaryInfo *customInfo=self.dataArray[leftselectindex];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic.transCode=@"M0068";
    dic.type=@"findByCondition";
    dic.pageSize=@(PAGESIZE);
    dic.currentPage=@(self.pageIndex);
    [dic setObject:customInfo.code forKey:@"typeCode"];
    if (self.Eatingtime) {
        [dic setObject:@(self.Eatingtime+20000) forKey:@"mealType"];
    }
#warning 此数据为调试所写死的一个城市code
    [dic setObject:@"230100" forKey:@"sortCode"];
    [[GLNetWorkManager shareManager]requestType:POST andURL:REQUESTURL andServers:GET_WORK_TYPE andParmas:dic andComplition:^(id response, BOOL isuccess) {
        if (isuccess&&[response[@"code"] isEqualToString:SUCCESSCODE]) {
            [self.rightTableView.mj_footer endRefreshing];
            [DLStorefoodsInfo mj_setupObjectClassInArray:^NSDictionary *{
                return @{@"accessoriesList":@"DLStorefoodsDetailInfo",@"seasoningList":@"DLStorefoodsDetailInfo"};
            }];
            [self.DetaildataArray addObjectsFromArray:[DLStorefoodsInfo mj_objectArrayWithKeyValuesArray:response[@"dishesLibList"]]];
            [self.rightTableView reloadData];
            self.IsmoreData=[response[@"totalCount"] integerValue]>PAGESIZE*self.pageIndex;
            
        }
        MyLog(@"%@",response);
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    DLSearchFoodsViewController *searchVC=[[DLSearchFoodsViewController alloc]init];
    searchVC.eatType=CustomType;
    searchVC.IsLookFoods=self.IsLookFoods;
    searchVC.curentdate=self.currentDate;
    searchVC.timeType=self.Eatingtime;
    [self.navigationController pushViewController:searchVC animated:YES];
    return NO;
}

@end
