//
//  EditTransController.h
//  Sanity
//
//  Created by Tianmu on 11/19/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "MainController.h"
@protocol  EditTransControllerDelegate<NSObject>

@required
@end
@interface EditTransController : MainController{
    id <EditTransControllerDelegate> _delegate;
}
@property (nonatomic,strong) id delegate;


@end
