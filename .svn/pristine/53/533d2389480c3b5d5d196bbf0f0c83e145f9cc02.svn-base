//
//  DLSearchFoodsViewController.m
//  DiLiRestaurant
//
//  Created by 地利 on 2017/4/7.
//  Copyright © 2017年 地利. All rights reserved.
//

#import "DLSearchFoodsViewController.h"
#import "DLStoreFoodsTableViewCell.h"
#import "DLFoodDetailViewController.h"

#define CustomTableName @"customfoods"
#define CustomMostTableName @"customfoodsmost"
#define CustomLessTableName @"customfoodsless"

#define StoreTableName @"Storefoods"
#define StoreMostTableName @"Storefoodsmost"
#define StoreLessTableName @"Storefoodsless"

#define DishBankTableName @"dishbank"
#define DishBankMostTableName @"dishbankmost"
#define DishBankLessTableName @"dishbankless"


@interface DLSearchFoodsViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate>

@property(weak,nonatomic)TPKeyboardAvoidingTableView *tableView;
@property(nonatomic,strong) UISearchController * searchController;

@property(nonatomic,strong) NSMutableArray <DLStorefoodsInfo*>* searchArray;

@property(strong,nonatomic)NSMutableArray <DLStorefoodsInfo*>*dataArray;

@property(assign,nonatomic)NSInteger pageIndex;

@property(assign,nonatomic)BOOL IsmoreData;

@property(copy,nonatomic)NSString *searchText;

@property(strong,nonatomic)JQFMDB *dataDB;

@property(strong,nonatomic)NSMutableArray <DLStorefoodsInfo*>*selectArray;
@end

@implementation DLSearchFoodsViewController
- (NSMutableArray *)selectArray
{
    if (!_selectArray) {
        _selectArray=[NSMutableArray array];
    }
    return _selectArray;
}
- (JQFMDB *)dataDB
{
    if (!_dataDB) {
        _dataDB=[JQFMDB shareDatabase:@"searchfoods.sqlite"];
    }
    return _dataDB;
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
    self.searchController.searchBar.hidden=NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.searchController.searchBar.hidden=YES;
}

- (NSMutableArray *)searchArray
{
    if (!_searchArray) {
        _searchArray=[NSMutableArray array];
    }
    return _searchArray;
}

- (UISearchController *)searchController
{
    if (!_searchController) {
        _searchController=[[UISearchController alloc]initWithSearchResultsController:nil];
        _searchController.delegate=self;
        
        _searchController.searchResultsUpdater=self;
        _searchController.searchBar.delegate=self;
        _searchController.dimsBackgroundDuringPresentation=NO;
        _searchController.hidesNavigationBarDuringPresentation=NO;
    }
    return _searchController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchText=@"";
    self.view.backgroundColor=BackGroundColor;
    self.pageIndex=1;
    
    self.title=self.eatType==StoreType?@"门店菜单搜索":@"自定义菜单搜索";
    if (self.IsLookFoods) {
        self.title=@"菜品库";
    }
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTargat:self action:@selector(back) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem rightBarButtonItemWithTitle:@"完成添加" target:self selector:@selector(addfoot)];
    if (self.IsLookFoods) {
        self.navigationItem.rightBarButtonItem=nil;
    }
    [self queryHistoryList];
    TPKeyboardAvoidingTableView *tableview=[[TPKeyboardAvoidingTableView alloc]initWithFrame:ViewRect style:UITableViewStylePlain];
    tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableview.showsVerticalScrollIndicator=NO;
    tableview.showsHorizontalScrollIndicator=NO;
    tableview.delegate=self;
    tableview.dataSource=self;
    [self.view addSubview:tableview];
    self.tableView=tableview;
    __weak typeof(self) unself=self;
//    __weak typeof(tableview) weaktableview=tableview;
    tableview.mj_footer=[MJRefreshBackFooter footerWithRefreshingBlock:^{
        if (unself.searchController.isActive) {
            if (unself.IsmoreData) {
                unself.pageIndex++;
                [unself getDataFromName:unself.searchText];
            }
            else
            {
                [MBProgressHUD showMessage:@"没有更多的数据了"];
                [unself.tableView.mj_footer endRefreshing];
            }
 
        }
        else
        {
            [unself.tableView.mj_footer endRefreshing];
        }
    }];
    self.tableView.tableHeaderView=self.searchController.searchBar;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DLStoreFoodsTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"foods"];
    
}
- (void)queryHistoryList{
    NSArray <DLStorefoodsInfo*>*foodsArr;
    if (self.IsLookFoods) {
        foodsArr = [self.dataDB jq_lookupTable:DishBankTableName dicOrModel:[DLStorefoodsInfo class] whereFormat:@""];
        [foodsArr enumerateObjectsUsingBlock:^(DLStorefoodsInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray <DLStorefoodsDetailInfo*>*foodsmostArr = [self.dataDB jq_lookupTable:DishBankMostTableName dicOrModel:[DLStorefoodsDetailInfo class] whereFormat:[NSString stringWithFormat:@"where dishesCode = '%@'",obj.dishesCode]];
            obj.ingredients=foodsmostArr.firstObject;
            NSArray <DLStorefoodsDetailInfo*>*foodslessArr = [self.dataDB jq_lookupTable:DishBankLessTableName dicOrModel:[DLStorefoodsDetailInfo class] whereFormat:[NSString stringWithFormat:@"where dishesCode = '%@'",obj.dishesCode]];
            obj.accessoriesList=foodslessArr;
            obj.selectNum=0;
            obj.weight=0;
        }];

    }
    else
    {
    //查找表中所有数据
        foodsArr = [self.dataDB jq_lookupTable:self.eatType==StoreType?StoreTableName:CustomTableName dicOrModel:[DLStorefoodsInfo class] whereFormat:@""];
        [foodsArr enumerateObjectsUsingBlock:^(DLStorefoodsInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray <DLStorefoodsDetailInfo*>*foodsmostArr = [self.dataDB jq_lookupTable:self.eatType==StoreType?StoreMostTableName:CustomMostTableName dicOrModel:[DLStorefoodsDetailInfo class] whereFormat:[NSString stringWithFormat:@"where dishesCode = '%@'",obj.dishesCode]];
            obj.ingredients=foodsmostArr.firstObject;
            NSArray <DLStorefoodsDetailInfo*>*foodslessArr = [self.dataDB jq_lookupTable:self.eatType==StoreType?StoreLessTableName:CustomLessTableName dicOrModel:[DLStorefoodsDetailInfo class] whereFormat:[NSString stringWithFormat:@"where dishesCode = '%@'",obj.dishesCode]];
            obj.accessoriesList=foodslessArr;
            obj.selectNum=0;
            obj.weight=0;
        }];
    }
    [self.dataArray addObjectsFromArray:[[foodsArr reverseObjectEnumerator] allObjects]];
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchController.isActive?self.searchArray.count:self.dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLStorefoodsInfo *info=self.searchController.isActive?self.searchArray[indexPath.row]:self.dataArray[indexPath.row];
    DLFoodDetailViewController *detail=[[DLFoodDetailViewController alloc]init];
    detail.foodsCode=info.dishesCode;
    [self.navigationController pushViewController:detail animated:YES];
    if (self.IsLookFoods) {
        [self.dataDB jq_createTable:DishBankTableName dicOrModel:[DLStorefoodsInfo class]];
        [self.dataDB jq_createTable:DishBankMostTableName dicOrModel:[DLStorefoodsDetailInfo class]];
        [self.dataDB jq_insertTable:DishBankMostTableName dicOrModel:info.ingredients];
        if (info.accessoriesList) {
            [self.dataDB jq_createTable:DishBankLessTableName dicOrModel:[DLStorefoodsDetailInfo class]];
            [self.dataDB jq_insertTable:DishBankLessTableName dicOrModel:info.accessoriesList.firstObject];
        }
        [self.dataDB jq_insertTable:DishBankTableName dicOrModelArray:@[info]];


    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.searchController.isActive) {
        return 0;
    }
    else
        return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.searchController.isActive||!self.dataArray.count) {
        return 0;
    }
    else
        return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]init];
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 30)];
    [button setImage:[UIImage imageNamed:@"delete_hository"] forState:UIControlStateNormal];
    [button setTitle:@"清空历史记录" forState:UIControlStateNormal];
    button.titleLabel.font=font14;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clearHistory) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]init];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 30)];
    label.text=@"最近搜索";
    label.font=font14;
    [view addSubview:label];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLStoreFoodsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"foods" forIndexPath:indexPath];
    DLStorefoodsInfo *info=self.searchController.isActive?self.searchArray[indexPath.row]:self.dataArray[indexPath.row];
    if (self.IsLookFoods) {
        cell.eatType=0;
    }
    else
        cell.eatType=self.eatType;
    cell.foodsInfo=info;
    //        __weak typeof(self) unself=self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
}
- (void)didDismissSearchController:(UISearchController *)searchController
{
    [self.tableView reloadData];
}
- (void)didPresentSearchController:(UISearchController *)searchControlle
{
    [self.tableView reloadData];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.pageIndex=1;
    [self.searchArray removeAllObjects];
    if (self.eatType==CustomType) {
       [self getDataFromName:searchBar.text];
    }
    else
    {
        [self getStoreDataFromName:searchBar.text];
    }
    
}

- (void)getStoreDataFromName:(NSString *)name{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic.transCode=@"C0112";
    dic.type=@"findAll";
    [dic setObject:[DLUserInfo getUserStore].storeId forKey:@"storeId"];
    [dic setObject:@(self.timeType+20000) forKey:@"mealTypeCode"];
    [dic setObject:self.curentdate forKey:@"templateDate"];
    [dic setObject:@1 forKey:@"status"];
    [dic setObject:name forKey:@"dishesName"];
    [[GLNetWorkManager shareManager]requestType:POST andURL:REQUESTURL andServers:GET_WORK_TYPE andParmas:dic andComplition:^(id response, BOOL isuccess) {
        if (isuccess&&[response[@"code"] isEqualToString:SUCCESSCODE]) {
            [DLStorefoodsInfo mj_setupObjectClassInArray:^NSDictionary *{
                return @{@"accessoriesList":@"DLStorefoodsDetailInfo"};
            }];
            [self.searchArray addObjectsFromArray:[DLStorefoodsInfo mj_objectArrayWithKeyValuesArray:response[@"json"][@"dishesSupplyList"][0][@"dishesSupplyDtlList"]]];
            [self.tableView reloadData];
            self.IsmoreData=[response[@"totalCount"] integerValue]>PAGESIZE*self.pageIndex;
        }
    }];
}

- (void)getDataFromName:(NSString *)name{
    self.searchText=name;
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic.transCode=@"M0021";
    dic.type=@"findAll";
    [dic setObject:@1 forKey:@"status"];
#warning 为了测试写个死数据  城市code
    [dic setObject:@"230100" forKey:@"sortCode"];
    [dic setObject:name forKey:@"dishesName"];
    dic.currentPage=@(self.pageIndex);
    dic.pageSize=@(PAGESIZE);
    [[GLNetWorkManager shareManager]requestType:POST andURL:REQUESTURL andServers:GET_WORK_TYPE andParmas:dic andComplition:^(id response, BOOL isuccess) {
        [self.tableView.mj_footer endRefreshing];
        if (isuccess&&[response[@"code"] isEqualToString:SUCCESSCODE]) {
            [DLStorefoodsInfo mj_setupObjectClassInArray:^NSDictionary *{
                return @{@"accessoriesList":@"DLStorefoodsDetailInfo"};
            }];
            [self.searchArray addObjectsFromArray:[DLStorefoodsInfo mj_objectArrayWithKeyValuesArray:response[@"dishesLibList"]]];
            [self.tableView reloadData];
            self.IsmoreData=[response[@"totalCount"] integerValue]>PAGESIZE*self.pageIndex;
        }
        
    }];
 
}
- (void)addfoot{
    NSMutableArray *finisharray=[NSMutableArray array];
    [self.dataArray enumerateObjectsUsingBlock:^(DLStorefoodsInfo * _Nonnull foodsobj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (foodsobj.selectNum) {
            NSMutableDictionary *infoDic=[NSMutableDictionary dictionary];
            [infoDic setObject:@(foodsobj.selectNum*foodsobj.customWeight) forKey:@"weight"];
            [infoDic setObject:@1 forKey:@"wayType"];
            [infoDic setObject:foodsobj.imagesURL forKey:@"imageUrl"];
            [infoDic setObject:foodsobj.imagesURL1 forKey:@"imageUrl1"];
            [infoDic setObject:foodsobj.dishesCode forKey:@"dishesCode"];
            [infoDic setObject:foodsobj.dishesName forKey:@"dishesName"];
            [finisharray addObject:infoDic];
            [self.selectArray addObject:foodsobj];
        }
    }];
    [self.searchArray enumerateObjectsUsingBlock:^(DLStorefoodsInfo * _Nonnull foodsobj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (foodsobj.selectNum) {
            NSMutableDictionary *infoDic=[NSMutableDictionary dictionary];
            [infoDic setObject:@(foodsobj.selectNum*(self.eatType==StoreType?foodsobj.weight:foodsobj.customWeight)) forKey:@"weight"];
            [infoDic setObject:@1 forKey:@"wayType"];
            [infoDic setObject:foodsobj.imagesURL forKey:@"imageUrl"];
            [infoDic setObject:foodsobj.imagesURL1 forKey:@"imageUrl1"];
            [infoDic setObject:foodsobj.dishesCode forKey:@"dishesCode"];
            [infoDic setObject:foodsobj.dishesName forKey:@"dishesName"];
            [finisharray addObject:infoDic];
            [self.selectArray addObject:foodsobj];
        }
    }];
    
    if (!finisharray.count) {
        [MBProgressHUD showMessage:@"您还没有选择菜"];
        return;
    }
    //    NSString *str=[[self arrayToJsonString:listArray] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic.transCode=@"C0116";
    dic.type=@"add";
    [dic setObject:[DLUserInfo getUser].userId forKey:@"userId"];
    [dic setObject:@(self.timeType) forKey:@"mealType"];
    [dic setObject:self.curentdate forKey:@"time"];
    [dic setObject:[self arrayToJsonString:finisharray]  forKey:@"list"];
    [[GLNetWorkManager shareManager]requestType:POST andURL:REQUESTURL andServers:GET_WORK_TYPE andParmas:dic andComplition:^(id response, BOOL isuccess) {
        if (isuccess&&[response[@"code"] isEqualToString:SUCCESSCODE]) {
            [self saveSearchHistory];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"addfoods" object:nil];
            [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count-3] animated:YES];
        }
    }];
}

- (void)saveSearchHistory{
    
    [self.dataDB jq_createTable:self.eatType==StoreType?StoreTableName:CustomTableName dicOrModel:[DLStorefoodsInfo class]];
    [self.selectArray enumerateObjectsUsingBlock:^(DLStorefoodsInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.dataDB jq_createTable:self.eatType==StoreType?StoreMostTableName:CustomMostTableName dicOrModel:[DLStorefoodsDetailInfo class]];
        [self.dataDB jq_insertTable:self.eatType==StoreType?StoreMostTableName:CustomMostTableName dicOrModel:obj.ingredients];
        if (obj.accessoriesList) {
            [self.dataDB jq_createTable:self.eatType==StoreType?StoreLessTableName:CustomLessTableName dicOrModel:[DLStorefoodsDetailInfo class]];
            [self.dataDB jq_insertTable:self.eatType==StoreType?StoreLessTableName:CustomLessTableName dicOrModel:obj.accessoriesList.firstObject];
        }
    }];
    NSArray *unsuccessArray = [self.dataDB jq_insertTable:self.eatType==StoreType?StoreTableName:CustomTableName dicOrModelArray:self.selectArray];
    MyLog(@"%@",unsuccessArray);
}
- (NSString *)arrayToJsonString:(NSArray *)arr{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
-(void)back{
    self.searchController.active=NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clearHistory{
    [self.dataDB jq_deleteAllDataFromTable:CustomTableName];
    [self.dataDB jq_deleteAllDataFromTable:CustomMostTableName];
    [self.dataDB jq_deleteAllDataFromTable:CustomLessTableName];
    [self.dataArray removeAllObjects];
    [self.tableView reloadData];
}
@end
