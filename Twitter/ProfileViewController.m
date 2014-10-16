//
//  ProfileViewController.m
//  Twitter
//
//  Created by Sindhuja Sridharan on 10/15/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "ProfileViewController.h"
#import "TwitterClient.h"
#import "UIImageView+AFNetworking.h"
#import "TweetViewCell.h"
#import "User.h"
#import "Tweet.h"



#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImage;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UILabel *profileHandle;

@property (weak, nonatomic) IBOutlet UILabel *tweetCount;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *followersCount;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (nonatomic, strong) NSDictionary * dictionary;
@property (nonatomic, strong) NSString * userId;
@property (nonatomic, strong) NSArray *tweets;




@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Add Navigation controls
    
    self.navigationItem.title = @"Home";
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x34AADC);
    
    
    UIBarButtonItem* logOutButton = [[UIBarButtonItem alloc] initWithTitle:@"LogOut" style:UIBarButtonItemStylePlain target:self action:@selector(onClickLogout:)];
    
    self.navigationItem.leftBarButtonItem = logOutButton;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem* composeTweetButton = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(onClickComposeTweet:)];
    
    self.navigationItem.rightBarButtonItem = composeTweetButton;
    
    
    //Register TweetViewCell
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetViewCell" bundle:nil] forCellReuseIdentifier:@"TweetViewCell"];
    
    //set the tableview
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 125;
    
    [self loadUser];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) loadUser {
    
    User *currentUser = [User currentUser];
    self.profileName.text = currentUser.screenname;
    [self.coverImage setImageWithURL:[NSURL URLWithString:currentUser.profileBackgroundImgUrl]];

    self.profileHandle.text = [NSString stringWithFormat:@"@%@", currentUser.screenname];
    [self.profileImage setImageWithURL:[NSURL URLWithString:currentUser.profileImageUrl]];
    self.followingCount.text = [NSString stringWithFormat:@"%ld",(long)[currentUser.followingCount integerValue]];
    self.followersCount.text = [NSString stringWithFormat:@"%ld",(long) [currentUser.followersCount integerValue]];
    self.tweetCount.text = [NSString stringWithFormat:@"%ld",(long) [currentUser.tweetsCount integerValue]];
    [self loadUserTimeline];
  
}

- (void) loadUserTimeline {
    User *currentUser = [User currentUser];
    self.userId = currentUser.user_id;
    [[TwitterClient sharedInstance] GET:
     @"1.1/statuses/user_timeline.json" parameters:@{@"count": @"20", @"user_id": self.userId} success:^(AFHTTPRequestOperation *operation, id responseObject) {
         self.tweets = [Tweet tweetsWithArray:responseObject];
         [self.tableView reloadData];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"error getting tweets");
     }];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
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

- (IBAction)onClickLogout:(id)sender {
    [User logout];
}


- (IBAction)onClickComposeTweet:(id)sender {
}


@end
