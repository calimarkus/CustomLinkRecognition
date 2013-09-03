//
//  SWTAppDelegate.m
//  testing
//
//  Created by Markus on 11.06.13.
//  Copyright (c) 2013 nxtbgthng. All rights reserved.
//

#import "SWTAppDelegate.h"
#import "SWTViewController.h"

#import <DCIntrospect/DCIntrospect.h>

@implementation SWTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = [[SWTViewController alloc] init];
    
    [[DCIntrospect sharedIntrospector] start];
    
    // Override point for customization after application launch.
    return YES;
}
						

@end
