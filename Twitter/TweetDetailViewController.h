//
//  TweetDetailViewController.h
//  Twitter
//
//  Created by Sindhuja Sridharan on 10/7/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@class TweetDetailViewController;

@protocol TweetDetailViewControllerDelegate <NSObject>

@end

@interface TweetDetailViewController : UIViewController

@property (nonatomic, weak) id <TweetDetailViewControllerDelegate> delegate;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withTweet:(Tweet*) tweet;
@end
