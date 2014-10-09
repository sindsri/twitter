//
//  LoginViewController.m
//  Twitter
//
//  Created by Sindhuja Sridharan on 10/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "TweetsViewController.h"
#import "TweetTimelineViewController.h"

@interface LoginViewController ()


@end

@implementation LoginViewController

- (IBAction)onLogin:(id)sender {
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        
        if(user !=nil) {
            //Modally present the tweets views
            NSLog(@"Welcome to %@", user.name);
            TweetTimelineViewController *tvc = [[TweetTimelineViewController alloc] initWithNibName:@"TweetTimelineViewController" bundle:nil];
            UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:tvc];
            //[self presentViewController:[[TweetsViewController alloc] init] animated:YES completion:nil];
            [self presentViewController:nvc animated:YES completion:nil];
            
        } else {
            //Present error view to the user
        }
    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
