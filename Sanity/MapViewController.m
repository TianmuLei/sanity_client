//
//  MapViewController.m
//  PhotosAround
//
//  Created by Ziqian Gu(ziqiangu@usc.edu) on 11/13/17.
//  Copyright © 2017 Gu. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController ()<GMSMapViewDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSMutableArray * markerArray;
@property (strong, nonatomic) NSMutableArray * dataArray;
@property int markerCount;
@property int markerIndexSelected;
@property float latitude;
@property float longitude;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //alloc and init variables
    self.markerArray = [[NSMutableArray alloc] init];
    self.dataArray = [[NSMutableArray alloc] init];
    self.markerCount = 0;
    
    //set up locationManager and get current location
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 100.0f;
    [self.locationManager requestWhenInUseAuthorization];
    [self updateLocation];
    
    //update current location on map
    [self loadView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Google Maps Delegate Methods
- (void)loadView
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.latitude
                                                            longitude:self.longitude
                                                                 zoom:14];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.settings.myLocationButton = YES;
    mapView.myLocationEnabled = YES;
    mapView.delegate = self;
    self.view = mapView;
}

- (void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)
    coordinate
{
    [mapView setCamera:[GMSCameraPosition cameraWithLatitude:coordinate.latitude
                                                   longitude:coordinate.longitude
                                                        zoom:14]];
    //[self.model getDataWithLongitude:coordinate.longitude Latitude:coordinate.latitude];
}

- (nullable UIView *) mapView:(GMSMapView *)mapView markerInfoContents:(GMSMarker *)marker
{
    int index = [self findMark:marker InArray:self.markerArray];
    if(index >= 0)
    {

    }
    return nil;
}

#pragma Model Delegate Methods
-(void) setData:(NSMutableArray*)data
{
    self.dataArray = data;
    //clear previous markers
    self.markerArray = [[NSMutableArray alloc] init];
    for(int i=0; i<self.dataArray.count; i++)
    {
        NSDictionary * currDict = self.dataArray[i];
      //  float longitude = [[currDict objectForKey:self.model.kLongitude] floatValue];
      //  float latitude = [[currDict objectForKey:self.model.kLatitude] floatValue];
      //  [self createMarkerWithLongitude:longitude Latitude:latitude];
    }
}

#pragma Helper Methods
- (void) updateLocation
{
    [self.locationManager startUpdatingLocation];
    self.latitude = self.locationManager.location.coordinate.latitude;
    self.longitude = self.locationManager.location.coordinate.longitude;
    [self.locationManager stopUpdatingLocation];
}

- (void)createMarkerWithLongitude:(float) longitude Latitude:(float)latitude
{
    //google maps API requires drawing to be done in main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(latitude,longitude);
        marker.map = (GMSMapView*)self.view;
        [self.markerArray addObject:marker];
    });
}

- (int)findMark:(GMSMarker*)marker InArray:(NSMutableArray*)array
{
    for(int i=0; i<array.count; i++)
    {
        if(array[i]==marker)
            return i;
    }
    return -1;
}



@end
