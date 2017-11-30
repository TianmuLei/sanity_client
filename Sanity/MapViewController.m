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

@property (strong, nonatomic) NSMutableArray * markerArray;
@property (strong, nonatomic) NSMutableArray * dataArray;
@property int markerCount;
@property int markerIndexSelected;


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //alloc and init variables
    self.markerArray = [[NSMutableArray alloc] init];
    self.dataArray = [[NSMutableArray alloc] init];
    self.markerCount = 0;
    
    //update current location on map
    [self loadView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma Google Maps Delegate Methods
- (void)loadView
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: -100.529555
                                                            longitude: 38.623369
                                                                 zoom:1];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    //mapView.settings.myLocationButton = YES;
    //mapView.myLocationEnabled = YES;
    mapView.delegate = self;
    self.view = mapView;
    
    for(int i=0; self.transactionAmounts.count; i++)
    {
        NSString *titleTemp = [[NSString alloc] initWithFormat:@"%@  %@",self.transactionAmounts[i],self.transactionDates[i]];
        float longTemp = [self.longtitude[i] floatValue];
        float latTemp = [self.latitude[i] floatValue];
        [self createMarkerWithLongitude:longTemp Latitude:latTemp Title:titleTemp Snippet:self.transactionNames[i]];
    }
}

/*
- (nullable UIView *) mapView:(GMSMapView *)mapView markerInfoContents:(GMSMarker *)marker
{
    int index = [self findMark:marker InArray:self.markerArray];
    if(index >= 0)
    {
        
    }
    return nil;
}
*/

- (void)createMarkerWithLongitude:(float) longitude Latitude:(float)latitude Title:(NSString*)title
                          Snippet:(NSString*)snippet
{
    //google maps API requires drawing to be done in main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(latitude,longitude);
        marker.title = title;
        marker.snippet = snippet;
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
