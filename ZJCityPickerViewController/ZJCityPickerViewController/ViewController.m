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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)pushClick:(UIButton *)sender {
    ZJCityPickerViewController *pickerController = [[ZJCityPickerViewController alloc] init];
    [self.navigationController pushViewController:pickerController animated:YES];
}

- (IBAction)presentClick:(UIButton *)sender {
    ZJCityPickerViewController *pickerController = [[ZJCityPickerViewController alloc] init];
    [self presentViewController:pickerController animated:YES completion:nil];
}

@end
