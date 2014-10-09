//
//  TwitterClient.h
//  Twitter
//
//  Created by Sindhuja Sridharan on 10/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *)sharedInstance;

- (void)loginWithCompletion:(void (^)(User *user , NSError *error))completion;

- (void)openURL:(NSURL *)url;

- (void)homeTimelineWithParams: (NSDictionary *)params completion:(void (^) (NSArray *tweets, NSError *error))completion;
- (void)pushNewTweetToTimeline: (NSString *)updateTimeline;


@end
