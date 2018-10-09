//
//  HTTPService.m
//  VideoLoadApp
//
//  Created by Armin Spahic on 26/09/2018.
//  Copyright © 2018 Armin Spahic. All rights reserved.
//

#import "HTTPService.h"

@implementation HTTPService
// SINGLETON
+(id) instance {
    static HTTPService *sharedInstance = nil;
    
    @synchronized (self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    return self;
}

-(void)test {
    NSLog(@"This is a test");
}

@end
