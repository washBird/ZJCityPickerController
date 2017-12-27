//
//  ZJCityPickerLocation.m
//  ZJCityPickerViewController
//
//  Created by zoujie on 2017/12/18.
//  Copyright © 2017年 zoujie. All rights reserved.
//

#import "ZJCityPickerLocation.h"
#import <CoreLocation/CoreLocation.h>

@interface ZJCityPickerLocation()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end
@implementation ZJCityPickerLocation

+ (instancetype)locationWithDelegate:(id<ZJCityPickerLocationDelegate>)delegate {
    ZJCityPickerLocation *location = [[ZJCityPickerLocation alloc] init];
    location.delegate = delegate;
    return location;
}

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager requestWhenInUseAuthorization];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (void)startLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
    }
    else {
        if ([self.delegate respondsToSelector:@selector(zj_CityPickerLocationNotOpenService)]) {
            [self.delegate zj_CityPickerLocationNotOpenService];
        }
        if ([self.delegate respondsToSelector:@selector(zj_CityPickerLocationFailureLocation)]) {
            [self.delegate zj_CityPickerLocationFailureLocation];
        }
    }
}

#pragma mark -  CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (error.code == kCLErrorDenied) {
        if ([self.delegate respondsToSelector:@selector(zj_CityPickerLocationDidDeny)]) {
            [self.delegate zj_CityPickerLocationDidDeny];
        }
        [_locationManager stopUpdatingLocation];
    }
    if ([self.delegate respondsToSelector:@selector(zj_CityPickerLocationFailureLocation)]) {
        [self.delegate zj_CityPickerLocationFailureLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [self.locationManager stopUpdatingLocation];
    CLLocation *newLocation = locations[0];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            NSString *city = placemark.locality;
            if (!city) {
                city = placemark.administrativeArea;
            }
            if ([self.delegate respondsToSelector:@selector(zj_CityPickerLocationSuccessWithCity:)]) {
                [self.delegate zj_CityPickerLocationSuccessWithCity:city];
            }
        }
        else {
            if ([self.delegate respondsToSelector:@selector(zj_CityPickerLocationFailureLocation)]) {
                [self.delegate zj_CityPickerLocationFailureLocation];
            }
        }
    }];
}

@end
