//
//  SideBarViewController.h
//  Twitter
//
//  Created by Sindhuja Sridharan on 10/14/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@class SideBarViewController;

@protocol SideBarViewControllerDelegate <NSObject>
@end

@interface SideBarViewController : UIViewController

@property (nonatomic, weak) id <SideBarViewControllerDelegate> delegate;
@end
