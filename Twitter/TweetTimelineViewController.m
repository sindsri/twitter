//
//  TweetTimelineViewController.m
//  Twitter
//
//  Created by Sindhuja Sridharan on 10/7/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "UIImageView+AFNetworking.h"
#import "TweetTimelineViewController.h"
#import "TweetViewCell.h"
#import "TwitterClient.h"
#import "User.h"
#import "Tweet.h"
#import "TweetDetailViewController.h"
#import "TweetComposeViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface TweetTimelineViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *tweets;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic, strong) UITableViewCell *prototypeCell;
@end

@implementation TweetTimelineViewController

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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 125;
    
    //Add Navigation controls
    
    self.navigationItem.title = @"Home";
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];

    
    //set left and right nav

    UIBarButtonItem* logOutButton = [[UIBarButtonItem alloc] initWithTitle:@"LogOut" style:UIBarButtonItemStylePlain target:self action:@selector(onClickLogout:)];
    
    self.navigationItem.leftBarButtonItem = logOutButton;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem* composeTweetButton = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(onClickComposeTweet:)];
    
    self.navigationItem.rightBarButtonItem = composeTweetButton;
    
    //register the cell
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetViewCell" bundle:nil] forCellReuseIdentifier:@"TweetViewCell"];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:self.refreshControl];
    
    [self.refreshControl addTarget:self action:@selector(getTweets) forControlEvents:UIControlEventValueChanged];
    [self setRefreshControl:self.refreshControl];
    
    [self getTweets];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getTweets {
           [[TwitterClient sharedInstance] GET:
             @"1.1/statuses/home_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 self.tweets = [Tweet tweetsWithArray:responseObject];
                 if(self.tweets.count > 0) {
                     self.tableView.hidden = false;
                 }
                 [self.refreshControl endRefreshing];
                 [self.tableView reloadData];

             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"error getting tweets");
             }];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetViewCell" forIndexPath:indexPath];
    
    Tweet *tweet = self.tweets[indexPath.row];
    cell.tweetText.text = tweet.text;
    cell.tweetName.text = tweet.user.name;
    cell.tweetHandle.text = [NSString stringWithFormat:@"@%@", tweet.user.screenname];
    [cell.tweetProfileImage setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrl]];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"row  %d selected", indexPath.row);
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    Tweet *tweet = self.tweets[indexPath.row];
    TweetDetailViewController *tdvc = [[TweetDetailViewController alloc] initWithNibName:@"TweetDetailViewController" bundle:nil withTweet:tweet];
    [self.navigationController pushViewController:tdvc animated:YES];
    
}

- (IBAction)onClickLogout:(id)sender {
    [User logout];
}

- (IBAction)onClickComposeTweet:(id)sender {

    TweetComposeViewController *tcvc = [[TweetComposeViewController alloc] initWithNibName:@"TweetComposeViewController" bundle:nil];
    tcvc.delegate = self;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:tcvc];
    [self presentViewController:nvc animated:YES completion:nil];
}



@end
