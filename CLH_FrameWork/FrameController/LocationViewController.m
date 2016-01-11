//
//  LocationViewController.m
//  促利汇_门户
//
//  Created by zhanglei on 15/7/9.
//  Copyright (c) 2015年 lei.zhang. All rights reserved.
//

#import "LocationViewController.h"
#import <BaiduMapAPI/BMapKit.h>
#import <BaiduMapAPI/BMKLocationService.h>
#import <BaiduMapAPI/BMKSearchComponent.h>
#import "MJRefresh.h"
#import "AppDelegate.h"
#import "Toast+UIView.h"
#import "FMDatabase.h"
#import "ChineseString.h"
#import "CityCell.h"
@interface LocationViewController ()
{
    NSMutableArray * locationArray;
    NSMutableArray * lastSelectArray;
    NSMutableArray * hotSelectArray;
    NSMutableArray * citiesArray;
    
    NSMutableArray * sortedCityArrays;
    
    NSMutableArray * sectionHeadsKeys;
    
    UISearchBar * searchbar;
    NSMutableArray * searchArray;
    
    UITableView * locateTableView;
    
    BMKGeoCodeSearch* _geocodesearch;
    BMKLocationService * _locService;
    UIButton * btnLocate;
    UILabel * lblLocateTip;
    
    CLLocationDegrees lat;
    CLLocationDegrees lng;
    NSString * locateCity;
}
@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    locationArray = [NSMutableArray array];
    lastSelectArray = [NSMutableArray array];
    hotSelectArray = [NSMutableArray array];
    citiesArray = [NSMutableArray array];
    sortedCityArrays = [NSMutableArray array];
    sectionHeadsKeys = [NSMutableArray array];
    searchArray = [NSMutableArray array];
    locateCity = @"";
    [sectionHeadsKeys addObject:@"定"];
    [sectionHeadsKeys addObject:@"近"];
    [sectionHeadsKeys addObject:@"热"];
    
    [self.lblTitle setText:@"定位功能"];
    [self.btnBack removeFromSuperview];
    self.btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 40, 40)];
    [self.btnBack setImage:[UIImage imageNamed:@"top_back_02"] forState:UIControlStateNormal];
    [self.btnBack addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.btnBack];
    
    searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 40)];
    //            [searchBar setBackgroundColor:[UIColor clearColor]];
    [searchbar setDelegate:self];
    [searchbar setPlaceholder:@"城市/行政区/拼音"];
    searchbar.translucent = YES;
    [self.view addSubview:searchbar];
    
    [self initCityArray];
    
    locateTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-60)];
    locateTableView.dataSource = self;
    locateTableView.delegate = self;
    locateTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [locateTableView setTableHeaderView:searchbar];
    [self.view addSubview:locateTableView];
    
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    _locService = [[BMKLocationService alloc]init];
}

-(void)initCityArray{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"db"];
    
    FMDatabase* database = [FMDatabase databaseWithPath:path];
    if ( ![database open] )
    {
        return;
    }
    
    // 查找表 AllTheQustions
    FMResultSet* resultSet = [database executeQuery: @"select * from city"];
    
    // 逐行读取数据
    while ( [resultSet next] )
    {
        // 对应字段来取数据
        NSString* name = [resultSet stringForColumn: @"name"];
        NSString* cityId = [resultSet stringForColumn: @"id"];
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        [dic setObject:name forKey:@"cityName"];
        [dic setObject:cityId forKey:@"cityId"];
        [citiesArray addObject:dic];
    }
    sortedCityArrays = [self getChineseStringArr:citiesArray];
    
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    if (![ud objectForKey:LastSelectCities]) {
        [ud setObject:[NSMutableArray array] forKey:LastSelectCities];
        [ud synchronize];
    }
    lastSelectArray = [ud objectForKey:LastSelectCities];
    if (![ud objectForKey:HotCities]) {
        [ud setObject:[NSMutableArray array] forKey:HotCities];
        [ud synchronize];
    }
    hotSelectArray = [NSMutableArray arrayWithArray:[ud objectForKey:HotCities]];
    [hotSelectArray addObject:@"上海"];
    [hotSelectArray addObject:@"北京"];
    [hotSelectArray addObject:@"广州"];
    [hotSelectArray addObject:@"深圳"];
    [hotSelectArray addObject:@"武汉"];
    [hotSelectArray addObject:@"天津"];
    [hotSelectArray addObject:@"西安"];
    [hotSelectArray addObject:@"南京"];
    [hotSelectArray addObject:@"杭州"];
    [hotSelectArray addObject:@"成都"];
    [hotSelectArray addObject:@"重庆"];
    [database close];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    _geocodesearch.delegate = self;
    _locService.delegate = self;
    [_locService startUserLocationService];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _geocodesearch.delegate = nil;
    _locService.delegate = nil;
}

-(void)back:(id)sender{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark table view data source and delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isSearch) {
        return 1;
    }else{
        return 3+sortedCityArrays.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.isSearch) {
        return [searchArray count];
    }
    if(section == 0){
        return 1;
    }else if(section == 1){
        return 1;
    }else if(section == 2){
        return 1;
    }else {
        return [[sortedCityArrays objectAtIndex:section-3] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (self.isSearch) {
        CityCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"searchCell%ld%ld",(long)indexPath.section,(long)indexPath.row]];
        if (nil == cell) {
            cell = [[CityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"searchCell%ld%ld",(long)indexPath.section,(long)indexPath.row]];
        }else {
            if (cell.lblTip) {
                [cell.lblTip removeFromSuperview];
            }
            if (cell.bottomLine) {
                [cell.bottomLine removeFromSuperview];
            }
            if (cell.cntView) {
                [cell.cntView removeFromSuperview];
            }
        }
        ChineseString * string =  [searchArray objectAtIndex:indexPath.row];
        cell.lblTip = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width-20, 30)];
        [cell.lblTip setText:string.string];
        [cell addSubview:cell.lblTip];
        
        cell.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 39, tableView.frame.size.width, 1)];
        [cell.bottomLine setBackgroundColor:RGBACOLOR(240, 245, 248, 1)];
        [cell addSubview:cell.bottomLine];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    CityCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"locateCell%ld%ld",(long)indexPath.section,(long)indexPath.row]];
    if (nil == cell) {
        cell = [[CityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"locateCell%ld%ld",(long)indexPath.section,(long)indexPath.row]];
    }else{
        if (cell.lblTip) {
            [cell.lblTip removeFromSuperview];
        }
        if (cell.cntView) {
            [cell.cntView removeFromSuperview];
        }
        if (cell.bottomLine) {
            [cell.bottomLine removeFromSuperview];
        }
    }
    switch (indexPath.section) {
        case 0:
        {
            if (btnLocate) {
                [btnLocate removeFromSuperview];
            }
            float w = (UI_SCREEN_WIDTH-20*4-15)/3;
            
            btnLocate = [[UIButton alloc] initWithFrame:CGRectMake(20, 5, w, 30)];
            [btnLocate setTitle:@"" forState:UIControlStateNormal];
            [btnLocate setBackgroundColor:[UIColor lightGrayColor]];
            [btnLocate addTarget:self action:@selector(selectCity:) forControlEvents:UIControlEventTouchUpInside];
            [btnLocate setHidden:YES];
            [cell addSubview:btnLocate];
            
            cell.lblTip = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width-20, 30)];
            [cell.lblTip setText:@"定位城市中..."];
            [cell.lblTip setFont:[UIFont fontWithName:TEXT_FONT_NAME size:14]];
            [cell.lblTip setHidden:NO];
            [cell addSubview:cell.lblTip];
            
            if ([locateCity isEqualToString:@""]) {
                [btnLocate setHidden:YES];
                [cell.lblTip setHidden:NO];
            }else{
                [btnLocate setTitle:locateCity forState:UIControlStateNormal];
                [btnLocate setHidden:NO];
                [cell.lblTip setHidden:YES];
            }
            
            cell.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 39, tableView.frame.size.width, 1)];
            [cell.bottomLine setBackgroundColor:RGBACOLOR(240, 245, 248, 1)];
            [cell addSubview:cell.bottomLine];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 1:
        {
            float h = (lastSelectArray.count%3==0?lastSelectArray.count/3:lastSelectArray.count/3+1)*40-5;
            cell.lblTip = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width-20, 30)];
            [cell.lblTip setText:@"暂无最近选择城市"];
            [cell addSubview:cell.lblTip];
            
            if ([lastSelectArray count] == 0) {
                [cell.lblTip setHidden:NO];
            }else{
                [cell.lblTip setHidden:YES];
                cell.cntView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, h)];
                [cell addSubview:cell.cntView];
                int idx = 0;
                for (NSString * cityName in lastSelectArray) {
                    float w = (UI_SCREEN_WIDTH-20*4-15)/3;
                    float h = 40;
                    int row = idx/3;
                    int col = idx%3;
                    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake((col+1)*20+col*w, (5*(row+1))+row*(h-5*2), w, h-5*2)];
                    [btn setTitle:cityName forState:UIControlStateNormal];
                    [btn setTag:indexPath.section*100+idx];
                    [btn setBackgroundColor:[UIColor lightGrayColor]];
                    [btn addTarget:self action:@selector(selectCity:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.cntView addSubview:btn];
                    idx ++;
                }
            }
            
            cell.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, h-1, tableView.frame.size.width, 1)];
            [cell.bottomLine setBackgroundColor:RGBACOLOR(240, 245, 248, 1)];
            [cell addSubview:cell.bottomLine];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 2:
        {
            float h = (hotSelectArray.count%3==0?hotSelectArray.count/3:hotSelectArray.count/3+1)*40;
            
            cell.lblTip = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width-20, 30)];
            [cell.lblTip setText:@"暂无热门城市"];
            [cell addSubview:cell.lblTip];
            
            if ([hotSelectArray count]==0) {
                [cell.lblTip setHidden:NO];
            }else{
                [cell.lblTip setHidden:YES];
                cell.cntView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, h)];
                [cell addSubview:cell.cntView];
                int idx = 0;
                for (NSString * cityName in hotSelectArray) {
                    float w = (UI_SCREEN_WIDTH-20*4-15)/3;
                    float h = 40;
                    int row = idx/3;
                    int col = idx%3;
                    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake((col+1)*20+col*w, (5*(row+1))+row*(h-5*2), w, h-5*2)];
                    [btn setTitle:cityName forState:UIControlStateNormal];
                    [btn setTag:indexPath.section*100+idx];
                    [btn setBackgroundColor:[UIColor lightGrayColor]];
                    [btn addTarget:self action:@selector(selectCity:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.cntView addSubview:btn];
                    idx ++;
                }
            }
            cell.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, h-1, tableView.frame.size.width, 1)];
            [cell.bottomLine setBackgroundColor:RGBACOLOR(240, 245, 248, 1)];
            [cell addSubview:cell.bottomLine];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        default:
        {
            NSMutableArray * arr = [sortedCityArrays objectAtIndex:indexPath.section-3];
            ChineseString * string = [arr objectAtIndex:indexPath.row];
            
            cell.lblTip = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width-20, 30)];
            [cell.lblTip setText:string.string];
            [cell addSubview:cell.lblTip];
            
            cell.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 39, tableView.frame.size.width, 1)];
            [cell.bottomLine setBackgroundColor:RGBACOLOR(240, 245, 248, 1)];
            [cell addSubview:cell.bottomLine];
            
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            return cell;
        }
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    if (self.isSearch) {
        return nil;
    }
    if (sectionIndex == 0) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 30)];
        [view setBackgroundColor:RGBACOLOR(201, 201, 206, 1)];
        UILabel * lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, UI_SCREEN_WIDTH-20, 30)];
        [lblHeader setText:@"定位城市"];
        [lblHeader setFont:[UIFont fontWithName:TEXT_FONT_NAME size:14]];
        [view addSubview:lblHeader];
        return view;
    }else if(sectionIndex == 1){
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 30)];
        [view setBackgroundColor:RGBACOLOR(201, 201, 206, 1)];
        UILabel * lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, UI_SCREEN_WIDTH-20, 30)];
        [lblHeader setText:@"最近访问城市"];
        [lblHeader setFont:[UIFont fontWithName:TEXT_FONT_NAME size:14]];
        [view addSubview:lblHeader];
        return view;
    }else if(sectionIndex == 2){
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 30)];
        [view setBackgroundColor:RGBACOLOR(201, 201, 206, 1)];
        UILabel * lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, UI_SCREEN_WIDTH-20, 30)];
        [lblHeader setText:@"热门城市"];
        [lblHeader setFont:[UIFont fontWithName:TEXT_FONT_NAME size:14]];
        [view addSubview:lblHeader];
        return view;
    }else {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 30)];
        [view setBackgroundColor:RGBACOLOR(201, 201, 206, 1)];
        UILabel * lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, UI_SCREEN_WIDTH-20, 30)];
        [lblHeader setText:[sectionHeadsKeys objectAtIndex:sectionIndex]];
        [lblHeader setFont:[UIFont fontWithName:TEXT_FONT_NAME size:14]];
        [view addSubview:lblHeader];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (self.isSearch) {
        return 0;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 40;
    }else if(indexPath.section == 1){
        if ([lastSelectArray count] == 0) {
            return 40;
        }
        int col = (lastSelectArray.count%3==0?lastSelectArray.count/3:lastSelectArray.count/3+1);
        return col*40-5*(col-1);
    }else if(indexPath.section == 2){
        if ([hotSelectArray count] == 0) {
            return 40;
        }
        int col = (hotSelectArray.count%3==0?hotSelectArray.count%3:hotSelectArray.count/3+1);
        return col*40-5*(col-1);
    }else{
        return 40;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isSearch) {
        NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
        ChineseString * s=  [searchArray objectAtIndex:indexPath.row];
        NSString * cityName = s.string;
        [ud setObject:cityName forKey:CurrentSelectCity];
        [ud synchronize];
        
        [self fileterAndAddToLastSelect];
        [self back:nil];
        return;
    }
    if (indexPath.section != 0&&indexPath.section != 1&&indexPath.section != 2) {
        NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
        NSArray * array = [sortedCityArrays objectAtIndex:indexPath.section-3];
        ChineseString * s=  [array objectAtIndex:indexPath.row];
        NSString * cityName = s.string;
        [ud setObject:cityName forKey:CurrentSelectCity];
        [ud synchronize];
        [self fileterAndAddToLastSelect];
        [self back:nil];
    }
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (self.isSearch) {
        return nil;
    }
    return sectionHeadsKeys;
}
#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

-(void)reLocation:(id)sender{
    [_locService startUserLocationService];
}

#pragma mark BaiduMapDelegate

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{

}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{

}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_locService stopUserLocationService];

    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        lat =userLocation.location.coordinate.latitude;
        lng = userLocation.location.coordinate.longitude;
        NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
        [ud synchronize];
    }
    else
    {
        locateCity = @"重新定位";
        [locateTableView reloadData];
    }
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    if (error.code == 1) {
        locateCity = @"重新定位";
        [locateTableView reloadData];
    }
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    BMKAddressComponent * address = result.addressDetail;
    NSString * city = address.city;
    if ([city isEqualToString:@""]) {
        locateCity = @"重新定位";
    }else{
        locateCity = city;
        locateCity = [locateCity substringToIndex:locateCity.length-1];
    }
    
    [locateTableView reloadData];
}

-(void)fileterAndAddToLastSelect{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSString * nCity = [ud objectForKey:CurrentSelectCity];
    if (![ud objectForKey:LastSelectCities]) {
        [ud setObject:[NSMutableArray array] forKey:LastSelectCities];
        [ud synchronize];
    }
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:[ud objectForKey:LastSelectCities]];
    if ([tempArr count] == 0) {
        [tempArr addObject:nCity];
        [ud setObject:tempArr forKey:LastSelectCities];
        [ud synchronize];
        return;
    }
    
    if (![tempArr containsObject:nCity]) {
        if ([tempArr count]>=9) {
            [tempArr removeLastObject];
        }
        [tempArr insertObject:nCity atIndex:0];
        [ud setObject:tempArr forKey:LastSelectCities];
        [ud synchronize];
    }
}

#pragma mark -- UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [searchArray removeAllObjects];
    if (searchText.length == 0) {
        self.isSearch = NO;
    }else{
        self.isSearch = YES;
        for (NSMutableArray * arr in sortedCityArrays){
            for (ChineseString * s in arr) {
                NSRange chinese = [s.string rangeOfString:searchText options:NSCaseInsensitiveSearch];
                NSRange letter = [s.pinYin rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (chinese.location!=NSNotFound || letter.location!=NSNotFound) {
                    [searchArray addObject:s];
                }
            }
        }
    }
    [locateTableView reloadData];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}
-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

#pragma mark -- KeyBoardNotify
-(void)tapHide{
    if (self.hidden == NO) {
        [self keyboardWillHide:nil];
    }
}

- (void)keyboardWillShow:(NSNotification *)notif {
    [super keyboardWillShow:notif];
}

- (void)keyboardShow:(NSNotification *)notif {
    [super keyboardShow:notif];
}

- (void)keyboardWillHide:(NSNotification *)notif {
    [super keyboardWillHide:notif];
    [searchbar resignFirstResponder];
}

- (void)keyboardHide:(NSNotification *)notif {
    [super keyboardHide:notif];
}

- (NSMutableArray *)getChineseStringArr:(NSMutableArray *)arrToSort
{
    // 创建一个临时的变动数组
    NSMutableArray *chineseStringsArray = [NSMutableArray array];
    for ( int i = 0 ; i < [arrToSort count]; i++)
    {
        // 创建一个临时的数据模型对象
        ChineseString *chineseString=[[ChineseString alloc] init];
        // 给模型赋值
        chineseString.string =[NSString stringWithString :[[arrToSort objectAtIndex :i] objectForKey:@"cityName"]];
        if (chineseString.string == nil)
        {
            chineseString.string = @"" ;
        }
        if (![chineseString.string isEqualToString : @""])
        {
            //join( 链接 ) the pinYin (letter 字母 )  链接到首字母
            NSString *pinYinResult = [NSString string];
            // 按照数据模型中 row 的个数循环
            for ( int j = 0 ;j < chineseString. string . length ; j++)
            {
                NSString *singlePinyinLetter = [[NSString stringWithFormat : @"%c" ,
                                                 pinyinFirstLetter ([chineseString. string characterAtIndex :j])] uppercaseString];
                pinYinResult = [pinYinResult stringByAppendingString :singlePinyinLetter];
            }
            chineseString. pinYin = pinYinResult;
        } else {
            chineseString. pinYin = @"" ;
        }
        [chineseStringsArray addObject :chineseString];
    }
    
    //sort( 排序 ) the ChineseStringArr by pinYin( 首字母 )
    NSArray *sortDescriptors = [NSArray arrayWithObject :[NSSortDescriptor sortDescriptorWithKey : @"pinYin" ascending : YES]];
    
    [chineseStringsArray sortUsingDescriptors :sortDescriptors];
    NSMutableArray *arrayForArrays = [NSMutableArray array];
    BOOL checkValueAtIndex= NO ;  //flag to check
    NSMutableArray *TempArrForGrouping = nil ;
    for ( int index = 0 ; index < [chineseStringsArray count]; index++)
    {
        ChineseString *chineseStr = ( ChineseString *)[chineseStringsArray objectAtIndex :index];
        NSMutableString *strchar= [NSMutableString stringWithString :chineseStr. pinYin];
        NSString *sr= [strchar substringToIndex : 1];
        //sr containing here the first character of each string  ( 这里包含的每个字符串的第一个字符 )
//        NSLog ( @"%@" ,sr);
        //here I'm checking whether the character already in the selection header keys or not  ( 检查字符是否已经选择头键 )
        if (![sectionHeadsKeys containsObject :[sr uppercaseString]])
        {
            [sectionHeadsKeys addObject :[sr uppercaseString]];
            TempArrForGrouping = [NSMutableArray array];
            checkValueAtIndex = NO ;
        }
        if ([sectionHeadsKeys containsObject :[sr uppercaseString]])
        {
            [TempArrForGrouping addObject :[chineseStringsArray objectAtIndex :index]];
            if (checkValueAtIndex == NO )
            {
                [arrayForArrays addObject :TempArrForGrouping];
                checkValueAtIndex = YES ;
            }
        }
    }
    return arrayForArrays;
}

-(void)selectCity:(id)sender{
    UIButton * btn = (UIButton *)sender;
    NSInteger t = btn.tag;
    int row  = t%100;
    int section = t/100;
    switch (section) {
        case 0:
        {
            NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:locateCity forKey:CurrentSelectCity];
            [ud synchronize];
            [self fileterAndAddToLastSelect];
            [self back:nil];
        }
            break;
        case 1:
        {
            NSString * cityName = [lastSelectArray objectAtIndex:row];
            NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:cityName forKey:CurrentSelectCity];
            [ud synchronize];
            [self fileterAndAddToLastSelect];
            [self back:nil];
        }
            break;
        case 2:
        {
            NSString * cityName = [hotSelectArray objectAtIndex:row];
            NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:cityName forKey:CurrentSelectCity];
            [ud synchronize];
            [self fileterAndAddToLastSelect];
            [self back:nil];
        }
            break;
        default:
            break;
    }
}

@end
