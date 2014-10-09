//
//  TweetComposeViewController.h
//  Twitter
//
//  Created by Sindhuja Sridharan on 10/7/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@class TweetComposeViewController;

@protocol TweetComposeViewControllerDelegate <NSObject>

@end

@interface TweetComposeViewController : UIViewController

@property (nonatomic, weak) id <TweetComposeViewControllerDelegate> delegate;
@end
