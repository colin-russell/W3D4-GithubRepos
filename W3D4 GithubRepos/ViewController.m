//
//  ViewController.m
//  W3D4 GithubRepos
//
//  Created by Colin on 2018-04-26.
//  Copyright © 2018 Colin Russell. All rights reserved.
//

#import "ViewController.h"
#import "Repo.h"

@interface ViewController () <UITableViewDataSource>
@property UITableView *tableView;
@property NSMutableArray *repoNames;
@property NSMutableArray *repoObjects;// hold all of my repo objects that have NSDictionaries of each repo
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.repoNames = [NSMutableArray new];
    self.repoObjects = [NSMutableArray new];
    [self setupTableView];
    
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/colin-russell/repos"]; // 1
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url]; // 2
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 3
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 4
    
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) { //step 1
            //Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError]; // step 2
        
        if (jsonError) { // step 3
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        // If we reach this point, we have successfully retrieved the JSON from the API
        for (NSDictionary *repo in repos) { // step 4
            NSString *repoName = repo[@"name"];
            NSLog(@"repo: %@", repoName);
            [self.repoNames addObject:repoName];
            Repo *repoObject = [[Repo alloc] initWithRepo:repo];
            [self.repoObjects addObject:repoObject];
        }
       
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
    }]; // 5
    
    [dataTask resume]; // 6

}
- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self; // DON'T forget
}

#pragma mark - DataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [self.repoNames objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.repoNames.count;
}


@end
