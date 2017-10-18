//
//  ChangeUsernameController.h
//  Sanity
//
//  Created by Tianmu on 10/17/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "MainController.h"


@protocol  ChangeUsernameDelegate<NSObject>
//add call back function here
//- (void) displayProfile:(NSString*)username :(NSString*)email;
@required
@end

@interface ChangeUsernameController : MainController{
    id <ChangeUsernameDelegate> _delegate;
}
@property (nonatomic,strong) id delegate;
-(void) changeUsername:(NSString*)newUserName;
- (id) initWithClass:(client *)myClient;
//@property (strong, atomic)  client *client;

@end
