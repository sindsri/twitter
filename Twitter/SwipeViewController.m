//
//  SwipeViewController.m
//  Twitter
//
//  Created by Sindhuja Sridharan on 10/14/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "SwipeViewController.h"
#import "TweetTimelineViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"
#import "MentionsViewController.h"
#import "ProfileViewController.h"
#import "MenuViewCell.h"
#import "User.h"


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface SwipeViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerXConstraint;
- (IBAction)didSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)swipeLeft:(UISwipeGestureRecognizer *)sender;

@property (strong, nonatomic) IBOutlet UIView *sideBarView;

@property (weak, nonatomic) IBOutlet UIView *contentView;


@property (strong, nonatomic) UIViewController* tweetsTVC;
@property (strong, nonatomic) UIViewController* mentionsVC;
@property (strong, nonatomic) UIViewController* profileVC;

@property (strong, nonatomic) UINavigationController *mainNVC;

@property (strong, nonatomic) UIViewController *presentVC;

@end

@implementation SwipeViewController

-(id) init {
    self = [super init];
    if(self ) {
        self.tweetsTVC = [[TweetTimelineViewController alloc]init];
        self.mentionsVC = [[MentionsViewController alloc]init];
        self.profileVC = [[ProfileViewController alloc] init];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.centerXConstraint.constant = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 130;
    
    
    TweetTimelineViewController *tvc = [[TweetTimelineViewController alloc] init];
    UINavigationController *tnvc = [[UINavigationController alloc]initWithRootViewController:tvc];
    tnvc.navigationBar.translucent = NO;
    tnvc.navigationBar.barTintColor = UIColorFromRGB(0x34AADC);
    
    self.presentVC = tnvc;
    
    self.presentVC.view.frame = self.contentView.bounds;
    [self addChildViewController:self.presentVC];
    [self.contentView addSubview:self.presentVC.view];

    
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuViewCell" bundle:nil] forCellReuseIdentifier:@"MenuViewCell"];

    
    
    [self.tableView reloadData];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    User *currentUser = [User currentUser];
    
    MenuViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MenuViewCell" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0 :
            cell.VClabel.text = currentUser.screenname;
            [cell.profileImage setImageWithURL:[NSURL URLWithString:currentUser.profileImageUrl]];
            cell.VClabel.textColor = [UIColor blackColor];
            break;
        case 1:
            cell.VClabel.text = @"Profile";
            break;
        case 2:
            cell.VClabel.text = @"Timeline";
            break;
        case 3:
            cell.VClabel.text = @"Mentions";
            break;
        default:
            break;
    }
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 1:
            self.profileVC = [[ProfileViewController alloc]init];
            self.profileVC = [[UINavigationController alloc]initWithRootViewController:self.profileVC];
            [self loadContentView:self.profileVC];
            break;
        case 2:
            self.tweetsTVC = [[TweetTimelineViewController alloc]init];
            self.tweetsTVC = [[UINavigationController alloc]initWithRootViewController:self.tweetsTVC];
            [self loadContentView:self.tweetsTVC];
            break;
        case 3:
            self.mentionsVC = [[MentionsViewController alloc]init];
            self.mentionsVC = [[UINavigationController alloc]initWithRootViewController:self.mentionsVC];
            [self loadContentView:self.mentionsVC];
            break;
            
    }
}

-(void)loadContentView:(UIViewController*)vc {
    if(self.presentVC != nil) {
        [self.presentVC willMoveToParentViewController:nil];
        [self.presentVC didMoveToParentViewController:nil];
    }

    vc.view.frame = self.contentView.bounds;
    [self addChildViewController:vc];
    [self.contentView addSubview:vc.view];
    [vc didMoveToParentViewController:self];

    self.presentVC = vc;

}

- (IBAction)didSwipe:(UISwipeGestureRecognizer *)sender {
    
    if(sender.state == UIGestureRecognizerStateEnded)
    {
        self.centerXConstraint.constant = -180;
        [self.view layoutIfNeeded];
    }
    
}


- (IBAction)swipeLeft:(UISwipeGestureRecognizer *)sender {
    if(sender.state == UIGestureRecognizerStateEnded)
    {
        self.centerXConstraint.constant = 0;
    }

}



@end
