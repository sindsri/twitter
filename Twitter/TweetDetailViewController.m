//
//  TweetDetailViewController.m
//  Twitter
//
//  Created by Sindhuja Sridharan on 10/7/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "Tweet.h"


@interface TweetDetailViewController ()
@property (weak, nonatomic) Tweet* tweet;
@property (weak, nonatomic) IBOutlet UIImageView *tweetImageDetailView;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextDetailView;
@property (weak, nonatomic) IBOutlet UILabel *tweetNameDetailView;
@property (weak, nonatomic) IBOutlet UILabel *tweetHandleDetailView;
@property (weak, nonatomic) IBOutlet UIButton *tweetReplyDtlBtn;
@property (weak, nonatomic) IBOutlet UIButton *retweetDetailBtn;
@property (weak, nonatomic) IBOutlet UIButton *favoriteDetailBtn;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeDetailView;

@end

@implementation TweetDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withTweet:(Tweet *)tweet
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tweet = tweet;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //set the navigation bar
    self.navigationItem.title = @"Tweet";
    
    //set right nav
    UIBarButtonItem* replyTweetButton = [[UIBarButtonItem alloc] initWithTitle:@"Reply" style:UIBarButtonItemStylePlain target:self action:@selector(onClickReplyTweet:)];
    
    self.navigationItem.rightBarButtonItem = replyTweetButton;


    
    //tweet details info
    self.tweetNameDetailView.text = self.tweet.user.name;
    self.tweetTextDetailView.text = self.tweet.text;
    self.tweetHandleDetailView.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenname];
    [self.tweetImageDetailView setImageWithURL:[NSURL URLWithString:self.tweet.user.profileImageUrl]];
    
    //datetime
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"M/d/y HH:mm:ss a";
    self.dateTimeDetailView.text = [formatter stringFromDate:self.tweet.createdAt];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)onClickReplyTweet:(id)sender {
    
}

@end
