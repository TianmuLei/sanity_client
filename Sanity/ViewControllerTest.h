//
//  ViewControllerTest.h
//  CS310
//
//  Created by Gu on 10/7/17.
//  Copyright © 2017 Gu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"

@interface ViewControllerTest : UIViewController

@property   NSInteger indexNum;
@property   NSString * nameSelected;
@property (weak, nonatomic) IBOutlet XYPieChart *PieChartDisplay;
@property (nonatomic, strong) NSMutableArray *texts; 
@property (nonatomic, strong) NSMutableArray *slices;

@end
