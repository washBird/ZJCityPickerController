//
//  ViewController.m
//  ZJCityPickerViewController
//
//  Created by zoujie on 2017/12/15.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import "ViewController.h"
#import "ZJCityPickerViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)pushClick:(UIButton *)sender {
    ZJCityPickerViewController *pickerController = [[ZJCityPickerViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    pickerController.selectCityBlock = ^(NSString *city) {
        weakSelf.resultLabel.text = city;
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:pickerController animated:YES];
}

- (IBAction)presentClick:(UIButton *)sender {
    ZJCityPickerAppearance *appearance = [ZJCityPickerAppearance appearance];
    //修改每一行的标签数
    appearance.itemsOfLine = 4;
    appearance.mainColor = [UIColor orangeColor];
    ZJCityPickerDataSource *dataSource = [ZJCityPickerDataSource dataSource];
    dataSource.selectCity = @"武汉";
    dataSource.headerTypesArray = @[@(ZJCityPickerGroupModelTypeHotCity),@(ZJCityPickerGroupModelTypeHistoryCity),@(ZJCityPickerGroupModelTypeNormal)];
    dataSource.hotModel.cityArray = @[@"长沙",@"武汉",@"广州",@"乌鲁木齐"];
    dataSource.maxHistoryCount = 8;
    ZJCityPickerViewController *pickerController = [ZJCityPickerViewController pickerControllerWithAppearance:appearance dataSource:dataSource];
    __weak typeof(self) weakSelf = self;
    pickerController.selectCityBlock = ^(NSString *city) {
        weakSelf.resultLabel.text = city;
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:pickerController];
    nav.navigationBar.tintColor = [UIColor blackColor];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
