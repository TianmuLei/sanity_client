//
//  MapViewController.h
//  PhotosAround
//
//  Created by Ziqian Gu(ziqiangu@usc.edu) on 11/13/17.
//  Copyright © 2017 Gu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *longtitude;
@property (nonatomic, strong) NSMutableArray *latitude;
@property (nonatomic, strong) NSArray *transactionNames;
@property (nonatomic, strong) NSArray *transactionAmounts;
@property (nonatomic, strong) NSArray *transactionDates;

@end
