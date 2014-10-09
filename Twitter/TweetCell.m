//
//  TweetCell.m
//  Twitter
//
//  Created by Sindhuja Sridharan on 10/7/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "TweetCell.h"

@interface TweetCell()

@property (weak, nonatomic) IBOutlet UIImageView *tweetImageView;
@property (weak, nonatomic) IBOutlet UILabel *tweetName;
@property (weak, nonatomic) IBOutlet UILabel *tweetHandle;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;

@end

@implementation TweetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
