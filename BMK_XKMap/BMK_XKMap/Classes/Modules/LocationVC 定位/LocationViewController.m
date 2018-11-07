//
//  LocationViewController.m
//  BMK_XKMap
//
//  Created by  XIAOKUN on 2018/11/5.
//  Copyright © 2018 晓坤. All rights reserved.
//

#import "LocationViewController.h"


@interface LocationViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate>

@property (nonatomic, strong) BMKMapView *mapView;  //地图
@property (nonatomic, strong) BMKLocationService *locService;  //定位
@property (nonatomic, strong) BMKGeoCodeSearch   *geocodesearch; //地理反编码
@property (nonatomic, strong) BMKUserLocation    *userLocation;  //当前位置对象
@property (nonatomic, strong) BMKPointAnnotation *pointAnnotation; //定位大头针
@end

@implementation LocationViewController{
    
    NSString *latitudeStr;  //定位得到的地址
    NSString *longitudeStr; //定位得到的地址
    NSString *addrStr;      //定位得到的地址
    
}


- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:NO];
    [_mapView viewWillAppear];
    _mapView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:NO];

    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"定位";
    
    [self startLocation];
  
    [self.view addSubview:self.mapView];

}

//地图
- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        _mapView.mapType = BMKMapTypeStandard;
        _mapView.zoomLevel = 18;
        _mapView.showsUserLocation = YES;
        
        
        _geocodesearch = [[BMKGeoCodeSearch alloc] init];
        _geocodesearch.delegate = self;
        
    }
    return _mapView;
}

//当前位置
- (BMKUserLocation *)userLocation {
    if (!_userLocation) {
        _userLocation = [[BMKUserLocation alloc] init];
    }
    return _userLocation;
}


#pragma mark ----- 开始定位
- (void)startLocation{
    
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    _locService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [_locService startUserLocationService];
}


#pragma mark ---  BMKLocationServiceDelegate
#pragma mark -方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    
    _userLocation.title = userLocation.title;
    [_mapView updateLocationData:_userLocation];
}


#pragma mark -当前定位位置
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    
    _userLocation = userLocation;
    [_mapView updateLocationData:_userLocation];
    _mapView.centerCoordinate = _userLocation.location.coordinate;

    //地理反编码
    BMKReverseGeoCodeSearchOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeSearchOption alloc] init];
    reverseGeocodeSearchOption.location = userLocation.location.coordinate;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag){
        [_locService stopUserLocationService];
    }

    //获取经纬度
    latitudeStr = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    longitudeStr = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];

    
    //定位的大头针
    _pointAnnotation = [[BMKPointAnnotation alloc] init];
    [_mapView addAnnotation:_pointAnnotation];
    CLLocationCoordinate2D coor;
    coor.latitude  = [latitudeStr doubleValue];
    coor.longitude = [longitudeStr doubleValue];
    _pointAnnotation.coordinate = coor;
    [self.mapView setCenterCoordinate:coor animated:YES];
    
}

#pragma mark -定位失败
- (void)didFailToLocateUserWithError:(NSError *)error{
    
    NSLog(@"error:%@",error);
}



#pragma mark -----BMKGeoCodeSearchDelegate
#pragma mark -地理反编码
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeSearchResult *)result errorCode:(BMKSearchErrorCode)error{
    
    addrStr = result.address;
    _pointAnnotation.title =  addrStr;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
