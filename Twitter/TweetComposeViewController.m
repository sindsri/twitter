//
//  TweetComposeViewController.m
//  Twitter
//
//  Created by Sindhuja Sridharan on 10/7/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "TweetComposeViewController.h"
#import "Tweet.h"
#import "User.h"
#import "TwitterClient.h"
#import "UIImageView+AFNetworking.h"


@interface TweetComposeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *tweetImageView;
@property (weak, nonatomic) IBOutlet UILabel *tweetHandle;
@property (weak, nonatomic) Tweet* tweet;
@property (weak, nonatomic) IBOutlet UILabel *tweetName;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextInput;

@end

@implementation TweetComposeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //set left and right nav
    
    UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onClickCancel)];
    
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem* tweetButton = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onClickTweet:)];
    
    self.navigationItem.rightBarButtonItem = tweetButton;
    [self loadUser];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadUser {
    
    User *currentUser = [User currentUser];
    self.tweetName.text = currentUser.screenname;
    
    self.tweetHandle.text = [NSString stringWithFormat:@"@%@", currentUser.screenname];
    [self.tweetImageView setImageWithURL:[NSURL URLWithString:currentUser.profileImageUrl]];

    
}

- (IBAction)onClickTweet:(id)sender {
    
     NSLog(@"in clicktweet");
    
    [[TwitterClient sharedInstance] pushNewTweetToTimeline:self.tweetTextInput.text];
    [self.delegate postTweet:self];

    [self.navigationController popViewControllerAnimated:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];

    
}

-(void)onClickCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
