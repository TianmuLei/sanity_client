//
//  CategoryPageController.h
//  Sanity
//
//  Created by Tianmu on 10/15/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "MainController.h"

@protocol  CategoryPageControllerDelegate<NSObject>
//add call back function here
@required
@end

@interface CategoryPageController : MainController{
    id <CategoryPageControllerDelegate> _delegate;
}
@property (nonatomic,strong) id delegate;
-(void) requestBudget:(NSString*) name;
-(void) requestCategory:(NSString*) budget category:(NSString*) category;

-(void) deleteTransaction: (NSNumber*) amount describe:(NSString*) describe category:(NSString*) category budget:(NSString*)budget date:(NSDateComponents*) date;

@end
