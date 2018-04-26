//
//  Repo.h
//  W3D4 GithubRepos
//
//  Created by Colin on 2018-04-26.
//  Copyright © 2018 Colin Russell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repo : NSObject
@property NSDictionary *repoDictionary;

- (instancetype)initWithRepo:(NSDictionary *)repo;
@end
