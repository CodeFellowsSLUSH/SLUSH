//
//  AWSDatabaseManager.m
//  SLUSH
//
//  Created by Chris Budro on 9/21/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "AWSDatabaseManager.h"
#import <AWSDynamoDB/AWSDynamoDB.h>

@interface AWSDatabaseManager ()

@property (strong, nonatomic) AWSDynamoDBObjectMapper *objectMapper;

@end

@implementation AWSDatabaseManager

- (void)saveItem:(AWSDynamoDBObjectModel *)object withCompletionBlock:(void (^)(BOOL, NSError *))handler {
  [[self.objectMapper save:object] continueWithBlock:^id(AWSTask *task) {
    if (task.error) {
      handler(false, task.error);
    } else {
      handler(true, nil);
    }
    return nil;
  }];
}

@end
