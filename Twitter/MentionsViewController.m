//
//  MentionsViewController.m
//  Twitter
//
//  Created by Sindhuja Sridharan on 10/15/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MentionsViewController.h"
#import "TweetViewCell.h"
#import "TweetComposeViewController.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MentionsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *tweetsmentions;


@end

@implementation MentionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 125;
    
    self.navigationItem.title = @"Mentions";
    [self.navigationController.navigationBar
    setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x34AADC);
    
    UIBarButtonItem* logOutButton = [[UIBarButtonItem alloc] initWithTitle:@"LogOut" style:UIBarButtonItemStylePlain target:self action:@selector(onClickLogout:)];
    
    self.navigationItem.leftBarButtonItem = logOutButton;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem* composeTweetButton = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(onClickComposeTweet:)];
    
    self.navigationItem.rightBarButtonItem = composeTweetButton;
    
    //register the cell
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetViewCell" bundle:nil] forCellReuseIdentifier:@"TweetViewCell"];
    
    [self getMentions];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickLogout:(id)sender {
    [User logout];
}

- (IBAction)onClickComposeTweet:(id)sender {
    
}



- (void) getMentions {
    [[TwitterClient sharedInstance] GET:
     @"1.1/statuses/mentions_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"tweets: %@", responseObject);;

         self.tweetsmentions =[Tweet tweetsWithArray:responseObject];
         
         [self.tableView reloadData];

         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"error getting tweets");
     }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetsmentions.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetViewCell" forIndexPath:indexPath];
    
    Tweet *tweet = self.tweetsmentions[indexPath.row];
    cell.tweetText.text = tweet.text;
    cell.tweetName.text = tweet.user.name;
    cell.tweetHandle.text = [NSString stringWithFormat:@"@%@", tweet.user.screenname];
    [cell.tweetProfileImage setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrl]];

    return cell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
