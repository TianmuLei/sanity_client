//
//  AddCategoryController.h
//  Sanity
//
//  Created by Tianmu on 10/28/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "MainController.h"

@protocol  AddCategoryControllerDelegate<NSObject>
- (void) addSuccessful;
- (void) addFailed: (NSString *)reasonTitle withReason:(NSString *)reason;
@required
@end

@interface AddCategoryController : MainController{
    id <AddCategoryControllerDelegate> _delegate;
}
@property (nonatomic,strong) id delegate;
-(void) addCategory:(NSString*) budgetName :(NSString*)categoryName :(NSNumber*)limit;
-(void) success;
-(void) fail;


@end
