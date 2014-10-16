//
//  AppDelegate.m
//  Twitter
//
//  Created by Sindhuja Sridharan on 10/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TwitterClient.h"
#import "User.h"
#import "Tweet.h"
#import "TweetsViewController.h"
#import "TweetTimelineViewController.h"
#import "SwipeViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userDidLogout) name:UserDidLogoutNotification object:nil];
    
    User *user = [User currentUser];
    if( user != nil) {
        NSLog(@"Welcome  %@", user.name);

            //TweetTimelineViewController *tvc = [[TweetTimelineViewController alloc] initWithNibName:@"TweetTimelineViewController" bundle:nil];
            SwipeViewController *swvc = [[SwipeViewController alloc]initWithNibName:@"SwipeViewController" bundle:nil];
//            UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:swvc];
//            nvc.navigationBar.translucent = NO;
//            nvc.navigationBar.barTintColor = UIColorFromRGB(0x34AADC);
             self.window.rootViewController = swvc;
//        

         //self.window.rootViewController = [[TweetsViewController alloc] init];
    }else {
        NSLog(@"Not logged in");
        self.window.rootViewController = [[LoginViewController alloc] init];
    }
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)userDidLogout {
    self.window.rootViewController = [[LoginViewController alloc] init];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    [[TwitterClient sharedInstance] openURL:url];
//    
//    [[TwitterClient sharedInstance] fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuthToken tokenWithQueryString:url.query] success:^(BDBOAuthToken *accessToken) {
//        NSLog(@"got the access token");
//        [[TwitterClient sharedInstance].requestSerializer saveAccessToken:accessToken];
//        [[TwitterClient sharedInstance] GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            //NSLog(@"current user: %@", responseObject);
//            User *user = [[User alloc] initWithDictionary:responseObject];
//            NSLog(@"current user name : %@", user.name);
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"failed getting current user");
//        }];
//        
//        [[TwitterClient sharedInstance] GET:
//                                 @"1.1/statuses/home_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                                     //NSLog(@"tweets: %@", responseObject);
//                                     NSArray *tweets = [Tweet tweetsWithArray:responseObject];
//                                     for(Tweet *tweet in tweets) {
//                                         NSLog(@"tweet : %@, created: %@", tweet.text, tweet.createdAt);
//                                     }
//                                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                     NSLog(@"error getting tweets");
//                                 }];
//    }failure:^(NSError *error) {
//        NSLog(@"failed to get the access token");
//    }];
    return YES;
}
@end
