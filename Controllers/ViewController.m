//
//  ViewController.m
//  VideoLoadApp
//
//  Created by Armin Spahic on 26/09/2018.
//  Copyright © 2018 Armin Spahic. All rights reserved.
//

#import "ViewController.h"
#import "Service.h"
#import "Video.h"
#import "VideoCell.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSArray *videoList;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    UINib *cellNib = [UINib nibWithNibName:@"VideoCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"videoCell"];
    self.videoList = [[NSArray alloc] init];
    [[Service instance] getTutorials:^(NSArray * _Nullable dataArray, NSString * _Nullable errMessage) {
        NSMutableArray *videoArray = [[NSMutableArray alloc] init];
        if (dataArray){
            for (NSDictionary *jsonDict in dataArray) {
                Video *video = [[Video alloc] init];
                video.videoTitle = [jsonDict objectForKey:@"title"];
                video.videoDescription = [jsonDict objectForKey:@"description"];
                video.thumbnailURL = [jsonDict objectForKey:@"thumbnail"];
                video.videoIframe = [jsonDict objectForKey:@"iframe"];
                
                [videoArray addObject:video];
                [self updateTableData];
            }
            self.videoList = videoArray;
        } else if (errMessage) {
            // Display alert to the user.
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Could not fetch data" preferredStyle:alert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:action];
        }
    }];
}

-(void)updateTableData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videoList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoCell *cell = (VideoCell*)[tableView dequeueReusableCellWithIdentifier:@"videoCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[VideoCell alloc] init];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
   Video *video = [self.videoList objectAtIndex:indexPath.row];
    VideoCell *vidCell = (VideoCell*)cell;
    [vidCell updateUI:video];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}




@end
