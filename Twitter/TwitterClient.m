//
//  TwitterClient.m
//  Twitter
//
//  Created by Sindhuja Sridharan on 10/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "TwitterClient.h"
#import "Tweet.h"

NSString * const kTwitterConsumerKey = @"XrYcIkorU32FMSQLMvj2NUYG6";
NSString * const kTwitterConsumerSecret = @"ZxlRicIL7Qg1piKPtGDC4RGQypCHOyg4zByJssYXzvjhPjW831";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";


@interface TwitterClient()

@property(nonatomic, strong)void (^loginCompletion)(User *user , NSError *error);

@end
@implementation TwitterClient

+ (TwitterClient *)sharedInstance {
    static TwitterClient *instance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if(instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
        }
        
    });

    return instance;
}
- (void)loginWithCompletion:(void (^)(User *user , NSError *error))completion  {
    
    self.loginCompletion = completion;
    
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"cptwitterdemo://oauth"] scope:nil success:^(BDBOAuthToken *requestToken) {
        NSLog(@"got the request token");
        NSURL *authURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        [[UIApplication sharedApplication] openURL:authURL];
    } failure:^(NSError *error) {
        NSLog(@"Failed to get the request token !");
        self.loginCompletion(nil, error);
    }];
}

-(void)openURL:(NSURL *)url {
    
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuthToken tokenWithQueryString:url.query] success:^(BDBOAuthToken *accessToken) {
        NSLog(@"got the access token");
        [self.requestSerializer saveAccessToken:accessToken];
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //NSLog(@"current user: %@", responseObject);
            User *user = [[User alloc] initWithDictionary:responseObject];
            
            //for persisting the current user credentials
            
            [User setCurrentUser:user];
            NSLog(@"current user name : %@", responseObject);
            self.loginCompletion(user, nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed getting current user");
            self.loginCompletion(nil, error);

        }];
        
        
//        [[TwitterClient sharedInstance] GET:
//         @"1.1/statuses/home_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//             //NSLog(@"tweets: %@", responseObject);
//             NSArray *tweets = [Tweet tweetsWithArray:responseObject];
//             for(Tweet *tweet in tweets) {
//                 NSLog(@"tweet : %@, created: %@", tweet.text, tweet.createdAt);
//             }
//         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//             NSLog(@"error getting tweets");
//         }];
        
    }failure:^(NSError *error) {
        NSLog(@"failed to get the access token");
    }];
}

- (void)homeTimelineWithParams: (NSDictionary *)params completion:(void (^) (NSArray *tweets, NSError *error))completion {
    
    [self GET:@"1.1/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *tweets = [Tweet tweetsWithArray:responseObject];
        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

- (void)pushNewTweetToTimeline:(NSString *)updateTimeline {
    [self POST:@"1.1/statuses/update.json" parameters:@{@"status" : updateTimeline} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"update timeline");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error");
    }];
}


@end
