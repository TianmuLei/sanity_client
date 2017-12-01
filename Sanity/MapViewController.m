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
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //update current location on map
    [self loadView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma Google Maps Delegate Methods
- (void)loadView
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: 38.623369
                                                            longitude: -100.529555
                                                                 zoom:1];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    //mapView.settings.myLocationButton = YES;
    //mapView.myLocationEnabled = YES;
    mapView.delegate = self;
    self.view = mapView;
    
    for(int i=0; i<self.transactionAmounts.count; i++)
    {
        if([self.longtitude[i] floatValue]!=0 && [self.latitude[i] floatValue]!=0)
        {
            NSString *titleTemp = [[NSString alloc] initWithFormat:@"$%@  %@",self.transactionAmounts[i],self.transactionDates[i]];
            float longTemp = [self.longtitude[i] floatValue];
            float latTemp = [self.latitude[i] floatValue];
            [self createMarkerWithLongitude:longTemp Latitude:latTemp Title:titleTemp Snippet:self.transactionNames[i]];
        }
    }
}

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
    });
}

- (IBAction)backButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
