//
//  TweetViewCell.h
//  Twitter
//
//  Created by Sindhuja Sridharan on 10/7/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *tweetProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *tweetName;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UILabel *tweetHandle;

@end
