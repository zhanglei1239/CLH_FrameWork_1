//
//  MyPersonCenterViewController.h
//  促利汇_门户
//
//  Created by zhanglei on 15/7/8.
//  Copyright (c) 2015年 lei.zhang. All rights reserved.
//

#import "BaseViewController.h"

@interface MyPersonCenterViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
-(void)setting:(id)sender;
@end
