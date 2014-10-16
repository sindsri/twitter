//
//  User.m
//  Twitter
//
//  Created by Sindhuja Sridharan on 10/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "User.h"
#import "TwitterClient.h"

NSString * const UserDidLoginNotification = @"UserDidLoginNotification";
NSString * const UserDidLogoutNotification = @"UserDidLogoutNotification";


@interface User()

@property (nonatomic, strong) NSDictionary * dictionary;

@end

@implementation User

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if(self) {
        self.dictionary = dictionary;
        self.name = dictionary[@"name"];
        self.screenname = dictionary[@"screen_name"];

        self.profileImageUrl = dictionary[@"profile_image_url"];
        self.tagline = dictionary[@"description"];
        self.user_id = dictionary[@"id"];
        self.profileBackgroundImgUrl = dictionary[@"profile_background_image_url"];
        self.tweetsCount = [NSNumber numberWithInteger: [dictionary[@"statuses_count"] integerValue]];
        self.followersCount = [NSNumber numberWithInteger:[dictionary[@"followers_count"] integerValue]];
        self.followingCount = [NSNumber numberWithInteger:[dictionary[@"friends_count"] integerValue]];

    }
    
    return self;
}


static User *_currentUser = nil;

NSString * const kCurrentUserKey = @"kCurrentUserKey";

+ (User *)currentUser {
    
    if(_currentUser == nil) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentUserKey];
        if(data != nil) {
          NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            _currentUser =  [[User alloc] initWithDictionary:dictionary];
        }
    }
    
    return _currentUser;
}

+ (void)setCurrentUser:(User *)currentUser {
    _currentUser = currentUser;
    
    if(_currentUser != nil) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:currentUser.dictionary options:0 error:NULL];
        
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:kCurrentUserKey];
        
    } else {
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:kCurrentUserKey];

    }
    [[NSUserDefaults standardUserDefaults] synchronize];

}

+ (void)logout {
    [User setCurrentUser:nil];
    [[TwitterClient sharedInstance].requestSerializer removeAccessToken];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLogoutNotification object:nil];
}

@end
