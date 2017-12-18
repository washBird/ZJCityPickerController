//
//  ZJCityPickerViewController.h
//  ZJCityPickerViewController
//
//  Created by zoujie on 2017/12/15.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJCityPickerAppearance.h"
#import "ZJCityPickerDataSource.h"

@interface ZJCityPickerViewController : UIViewController

+ (instancetype )pickerController;

+ (instancetype )pickerControllerWithAppearance:(ZJCityPickerAppearance *)apperance dataSource:(ZJCityPickerDataSource *)dataSource;

@end
