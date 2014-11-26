//
//  ViewController.m
//  NavigationDemo
//
//  Created by Todd Grooms on 11/26/14.
//  Copyright (c) 2014 Groomsy Dev. All rights reserved.
//

#import "ColorViewController.h"
#import "ColorsViewController.h"

@interface ColorsViewController ()

@property (nonatomic, strong) NSArray *colors;

@end

@implementation ColorsViewController

#pragma mark - View Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colors = @[
                    @{
                        @"name"     : @"Red",
                        @"value"    : [UIColor redColor]
                        },
                    @{
                        @"name"     : @"Blue",
                        @"value"    : [UIColor blueColor]
                        },
                    @{
                        @"name"     : @"Green",
                        @"value"    : [UIColor greenColor]
                        }
                    ];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ( [@"ViewColor" isEqualToString:segue.identifier] ) {
        NSDictionary *color = self.colors[self.tableView.indexPathForSelectedRow.row];
        
        ColorViewController *colorVC = (ColorViewController *)segue.destinationViewController;
        colorVC.backgroundColor = color[@"value"];
        colorVC.title = color[@"name"];
    }
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.colors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ColorCell"];
    cell.textLabel.text = self.colors[indexPath.row][@"name"];
    return cell;
}

@end
