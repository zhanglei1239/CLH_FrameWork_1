//
//  LocationViewController.h
//  促利汇_门户
//
//  Created by zhanglei on 15/7/9.
//  Copyright (c) 2015年 lei.zhang. All rights reserved.
//

#import "BaseViewController.h"
#import <BaiduMapAPI/BMKGeocodeSearch.h>
#import <BaiduMapAPI/BMKLocationService.h>
#import <BaiduMapAPI/BMKRadarManager.h>
@interface LocationViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate,UISearchBarDelegate>
@property (nonatomic,assign) BOOL isSearch;
@end
