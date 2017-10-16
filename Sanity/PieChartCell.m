//
//  PieChartCell.m
//  Sanity
//
//  Created by Gu on 10/15/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "PieChartCell.h"

@implementation PieChartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //set up pie chart
    [self.pieChart setDelegate:self];
    [self.pieChart setDataSource:self];
    [self.pieChart setShowPercentage:NO];
    [self.pieChart setPieBackgroundColor:[UIColor whiteColor]];
}


//override -> load data for pie chart
- (void)layoutSubViews
{
    [super layoutSubviews];
    [self.pieChart reloadData];
}

#pragma mark - XYPieChart Data Source
- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return self.slices.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [[self.slices objectAtIndex:index] intValue];
}

- (NSString *)pieChart:(XYPieChart *)pieChart textForSliceAtIndex:(NSUInteger)index
{
    return [self.texts objectAtIndex:index];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
