//
//  EditBudgetController.h
//  Sanity
//
//  Created by Tianmu on 10/16/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "MainController.h"

@protocol  EditBudgetControllerDelegate<NSObject>
- (void) editEntireBudgetSuccess;
- (void) editEntireBudgetFail;
@required
@end

@interface EditBudgetController : MainController{
    id <EditBudgetControllerDelegate> _delegate;
}
@property (nonatomic,strong) id delegate;
- (void) editBudget :(NSString*) oldBudgetName withnewBudget:(NSString *)newBudgetName withPeriod:(NSString*) period withThreshold:(NSString*)threshold withFrequency:(NSString*)frequency;
-(void) success;
-(void) fail;
-(Budget*) requestBudget:(NSString*) name;
-(void) deleteBudget:(NSString*) name;
-(void) deleteCategory:(NSString*) budgetName :(NSString*)categoryName;
-(void) editCategory:(NSString*) budgetName :(NSString*)categoryOldName :(NSString*)categoryNewName :(NSNumber*)categoryNewLimit;
@end
