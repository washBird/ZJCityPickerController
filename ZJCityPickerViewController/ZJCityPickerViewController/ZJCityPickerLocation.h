//
//  ZJCityPickerLocation.h
//  ZJCityPickerViewController
//
//  Created by zoujie on 2017/12/18.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZJCityPickerLocationDelegate<NSObject>
@optional
- (void)zj_CityPickerLocationDidDeny;
- (void)zj_CityPickerLocationNotOpenService;
- (void)zj_CityPickerLocationFailureLocation;
- (void)zj_CityPickerLocationSuccessWithCity:(NSString *)city;
@end

@interface ZJCityPickerLocation : NSObject

@property (nonatomic, weak) id<ZJCityPickerLocationDelegate> delegate;

+ (instancetype )locationWithDelegate:(id<ZJCityPickerLocationDelegate>)delegate;

- (void)startLocation;
@end
