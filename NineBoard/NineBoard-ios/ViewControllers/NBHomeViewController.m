//
//  NBHomeViewController.m
//  NineBoard-ios
//
//  Created by Daniel Ernst on 11/21/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//

#import "NBHomeViewController.h"

#import "NBGameSelectCell.h"
#import "NBMainGameViewController.h"

@interface NBHomeViewController ()

@property (strong, nonatomic) UITableView *tableView;

@end


#define kStatsCellIdentifier @"StatsCell"
#define kNewGameCellIdentifier @"NewGameCell"
#define kGameSelectCellIdentifier @"GameSelectCell"

const CGFloat GAME_SELECT_CELL_HEIGHT = 80.0;
const CGFloat DEFAULT_SELECT_CELL_HEIGHT = 44.0;


@implementation NBHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"9Board"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newGame)];
    [self.navigationItem setRightBarButtonItem:addButton];
    
}

-(void)updateViewConstraints {
    [self.view removeConstraints:[self.view constraints]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[tv]|" options:0 metrics:nil views:@{@"tv": self.tableView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tv]|" options:0 metrics:nil views:@{@"tv": self.tableView}]];
    
    [super updateViewConstraints];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 2;
    }
    if (section == 3) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4) {
        return GAME_SELECT_CELL_HEIGHT;
    }
    return DEFAULT_SELECT_CELL_HEIGHT;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return @"";
        case 1:
            return @"";
        case 2:
            return @"Your Move";
        case 3:
            return @"Their Move";
        case 4:
            return @"Recent Games";
            
        default:
            break;
    }
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        // stats/info cell
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStatsCellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kStatsCellIdentifier];
            [cell.textLabel setText:@"Record: 5-2"];
        }
        return cell;
    }
    else if (indexPath.section == 1) {
        // new game cell
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNewGameCellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kNewGameCellIdentifier];
            [cell.textLabel setText:@"New Game"];
        }
        return cell;
    }
    else if (indexPath.section == 2) {
        NBGameSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"a"];
        if (!cell) {
            cell = [[NBGameSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"a" cellPosition:NBCellPositionMiddle];
        }
        [cell setNeedsUpdateConstraints];
        return cell;
    }
    else if (indexPath.section == 3) {
        NBGameSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"b"];
        if (!cell) {
            cell = [[NBGameSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"b" cellPosition:NBCellPositionTop];
        }
        [cell setNeedsUpdateConstraints];
        return cell;
    }
    else if (indexPath.section == 4) {
        NBGameSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"c"];
        if (!cell) {
            cell = [[NBGameSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"c" cellPosition:NBCellPositionTop];
        }
        [cell setNeedsUpdateConstraints];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        [self newGame];
    }
    else {
        NBMainGameViewController *gameViewController = [[NBMainGameViewController alloc] init];
        [self.navigationController pushViewController:gameViewController animated:YES];
    }
}

#pragma mark -

- (void)newGame {
    NSLog(@"creating new game");
    // present friend pick dialogue /or/ choose type of game dialogue
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"New Game" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"With Facebook Friend", @"Pass and Play", nil];
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheet

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // facebook
        
    }
    else if (buttonIndex == 1) {
        // pass and play
        
    }
}

#pragma mark - getters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        //[_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
        [_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _tableView;
}







@end
