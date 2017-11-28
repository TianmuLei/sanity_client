//
//  ShowMapsCell.m
//  Sanity
//
//  Created by Gu on 11/27/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "ShowMapsCell.h"
@implementation ShowMapsCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (IBAction)showMapPressed:(id)sender {
    [self.delegate redirectToMaps];
}

@end
