//
//  TweetsViewController.m
//  Twitter
//
//  Created by Sindhuja Sridharan on 10/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "TweetsViewController.h"
#import "User.h"
#import "Tweet.h"
#import "TwitterClient.h"

@interface TweetsViewController ()

@end

@implementation TweetsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)onLogout:(id)sender {
    [User logout];
};

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[TwitterClient sharedInstance]homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        for(Tweet *tweet in tweets) {
            NSLog(@"text: %@", tweet.text);
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
