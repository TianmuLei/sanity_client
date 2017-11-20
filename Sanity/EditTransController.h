//
//  EditTransController.h
//  Sanity
//
//  Created by Tianmu on 11/19/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "MainController.h"
@protocol  EditTransControllerDelegate<NSObject>
- (void) receiveBudgetInfo: (NSMutableArray *) budgetsFromServer;
@required
@end
@interface EditTransController : MainController{
    id <EditTransControllerDelegate> _delegate;
}
@property (nonatomic,strong) id delegate;
-(void) deleteTransaction: (NSNumber*) amount describe:(NSString*) describe category:(NSString*) category budget:(NSString*)budget date:(NSString*) date;
-(void) editTransaction: (NSNumber*) oldamount olddescribe:(NSString*) olddescribe oldcategory:(NSString*) oldcategory oldbudget:(NSString*)oldbudget newcategory:(NSString*) newcategory newbudget:(NSString*)newbudget olddate:(NSString*) olddate newamount:(NSNumber*) newamount newdescribe:(NSString*) newdescribe newdate:(NSString*) newdate ;
-(Budget*) requestBudget:(NSString*) name;
-(void) requestBudgetAndCate;


@end
