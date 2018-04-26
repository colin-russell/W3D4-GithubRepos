//
//  Repo.m
//  W3D4 GithubRepos
//
//  Created by Colin on 2018-04-26.
//  Copyright © 2018 Colin Russell. All rights reserved.
//

#import "Repo.h"

@implementation Repo

- (instancetype)initWithRepo:(NSDictionary *)repo
{
    self = [super init];
    if (self) {
        _repoDictionary = repo;
    }
    return self;
}
@end
