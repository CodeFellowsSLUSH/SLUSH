//
//  AWSDatabaseManager.h
//  SLUSH
//
//  Created by Chris Budro on 9/21/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AWSDynamoDB/AWSDynamoDB.h>

@interface AWSDatabaseManager : NSObject

+ (void)saveItem:(AWSDynamoDBObjectModel *)object withCompletionBlock:(void (^)(BOOL, NSError *))handler;

@end
