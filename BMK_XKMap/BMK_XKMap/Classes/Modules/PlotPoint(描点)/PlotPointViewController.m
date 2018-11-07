//
//  PlotPointViewController.m
//  BMK_XKMap
//
//  Created by 董向坤 on 2018/11/6.
//  Copyright © 2018 晓坤. All rights reserved.
//

#import "PlotPointViewController.h"

#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>



@interface PlotPointViewController ()<BMKMapViewDelegate>

@property (nonatomic, strong) BMKMapView *mapView;  //地图
@property (nonatomic, strong) BMKPointAnnotation *pointAnnotation; //定位大头针
@end

@implementation PlotPointViewController


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
    
    self.title = @"描点";
    
    [self.view addSubview:self.mapView];
    [self plotPoint];
}

//地图
- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        _mapView.mapType = BMKMapTypeStandard;
        _mapView.zoomLevel = 18;
        _mapView.showsUserLocation = YES;
    }
    return _mapView;
}


//描点
- (void)plotPoint{
    
    //初始化数据源
    NSArray *pointArray = @[
                            @[@"36.060961", @"103.890357", @"addr1"],
                            @[@"36.061869", @"103.906412", @"addr2"],
                            @[@"36.069396", @"103.877977", @"addr3"],
                            @[@"36.061382", @"103.891639", @"addr4"],
                            @[@"36.060926", @"103.89065",  @"addr5"]
                            ];
    for (NSInteger i = 0; i < [pointArray count]; i++) {
      
        //初始化大头针
        _pointAnnotation = [[BMKPointAnnotation alloc] init];
        //将大头针添加到地图上
        [_mapView addAnnotation:_pointAnnotation];
        //给大头针赋值
        NSString *latitudeStr  = pointArray[i][0];
        NSString *longitudeStr = pointArray[i][1];
        NSString *addrStr      = pointArray[i][2];
        CLLocationCoordinate2D coor;
        coor.latitude  = [latitudeStr doubleValue];
        coor.longitude = [longitudeStr doubleValue];
        _pointAnnotation.title = addrStr;
        _pointAnnotation.coordinate = coor;
        //描点
        [self.mapView setCenterCoordinate:coor animated:YES];
        
    }
}


@end
