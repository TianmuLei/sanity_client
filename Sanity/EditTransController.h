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
-(void) deleteTransaction: (NSNumber*) amount describe:(NSString*) describe category:(NSString*) category budget:(NSString*)budget date:(NSDateComponents*) date;
-(void) editTransaction: (NSNumber*) oldamount olddescribe:(NSString*) olddescribe category:(NSString*) category budget:(NSString*)budget olddate:(NSDateComponents*) olddate newamount:(NSNumber*) newamount newdescribe:(NSString*) newdescribe newdate:(NSDateComponents*) newdate ;
-(Budget*) requestBudget:(NSString*) name;


@end
