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
#import "NBAPIClient.h"
#import "NBAppHelper.h"
#import "NBFacebookHelper.h"

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
    
    [[NBAPIClient sharedAPIClient] getUserStatsWithSuccess:^(int wins, int losses, int cumulativeScore) {
        [NBAppHelper sharedHelper].userWins = wins;
        [NBAppHelper sharedHelper].userLosses = losses;
        [NBAppHelper sharedHelper].userScore = cumulativeScore;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"error: %@", error.userInfo);
    }];
    
    [[NBAPIClient sharedAPIClient] getAllUserGamesWithSuccess:^(NSArray *myTurnGames, NSArray *opponentTurnGames, NSArray *recentOverGames) {
        [NBAppHelper sharedHelper].myTurnGames = myTurnGames;
        [NBAppHelper sharedHelper].opponentTurnGames = opponentTurnGames;
        [NBAppHelper sharedHelper].recentOverGames = recentOverGames;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"error: %@", error.userInfo);
    }];
    
    
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
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return [[[NBAppHelper sharedHelper] myTurnGames] count];
    }
    if (section == 3) {
        return [[[NBAppHelper sharedHelper] opponentTurnGames] count];
    }
    if (section == 4) {
        return [[[NBAppHelper sharedHelper] recentOverGames] count];
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
            return @"My Stats";
        case 1:
            return @"";
        case 2:
            return @"Your Move";
        case 3:
            return @"Their Move";
        case 4:
            return @"Recent Games";
        case 5:
            return @"";
            
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
            [cell.textLabel setText:[NSString stringWithFormat:@"%d wins, %d losses. Total score: %d", [NBAppHelper sharedHelper].userWins, [NBAppHelper sharedHelper].userLosses, [NBAppHelper sharedHelper].userScore]];
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
    else if (indexPath.section == 5) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"logout"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"logout"];
            [cell setBackgroundColor:[UIColor redColor]];
            [cell.textLabel setText:@"Log Out"];
            [cell.textLabel setTextColor:[UIColor whiteColor]];
        }
        return cell;
    }
    else {
        NSArray *model;
        if (indexPath.section == 2) {
            model = [NBAppHelper sharedHelper].myTurnGames;
        }
        else if (indexPath.section == 3) {
            model = [NBAppHelper sharedHelper].opponentTurnGames;
        }
        else {
            model = [NBAppHelper sharedHelper].recentOverGames;
        }
        
        
        NBGameSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:kGameSelectCellIdentifier];
        if (!cell) {
            cell = [[NBGameSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kGameSelectCellIdentifier cellPosition:NBCellPositionMiddle];
        }
        [cell setNeedsUpdateConstraints];
        [cell configureWithGame:model[indexPath.row]];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        [[NBAPIClient sharedAPIClient] userLoggedInWithFacebookId:@"id" name:@"danernst" success:nil failure:nil];
    }
    else if (indexPath.section == 1) {
        [self newGame];
    }
    else if (indexPath.section == 5) {
        [self logout];
    }
    else {
        NSArray *model;
        if (indexPath.section == 2) {
            model = [NBAppHelper sharedHelper].myTurnGames;
        }
        else if (indexPath.section == 3) {
            model = [NBAppHelper sharedHelper].opponentTurnGames;
        }
        else {
            model = [NBAppHelper sharedHelper].recentOverGames;
        }
        
        NBMainGameViewController *gameViewController = [[NBMainGameViewController alloc] init];
        [gameViewController setGameObject:model[indexPath.row]];
        [self.navigationController pushViewController:gameViewController animated:YES];
    }
}

#pragma mark -

- (void)newGame {
    NSLog(@"creating new game");
    // present friend pick dialogue /or/ choose type of game dialogue
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"New Game" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"With Facebook Friend", nil];
    [actionSheet showInView:self.view];
}

- (void)logout {
    [NBFacebookHelper logout];
}

- (void)refreshData:(UIRefreshControl *)refreshControl {
    [refreshControl endRefreshing];
}

#pragma mark - UIActionSheet

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // facebook
        FBFriendPickerViewController *pvc = [[FBFriendPickerViewController alloc] init];
        [pvc loadData];
        [pvc setTitle:@"Challenge Whom?"];
        [pvc setDelegate:self];
        [pvc setAllowsMultipleSelection:NO];
        [pvc presentModallyFromViewController:self animated:YES handler:nil];
    }
    else if (buttonIndex == 1) {
        // pass and play
        
    }
}
#pragma mark - FBFriendPickerViewControllerDelegate
/*
 * Event: Error during data fetch
 */
- (void)friendPickerViewController:(FBFriendPickerViewController *)friendPicker
                       handleError:(NSError *)error
{
    NSLog(@"Error during data fetch: %@", error.userInfo);
}

/*
 * Event: Done button clicked
 */
- (void)facebookViewControllerDoneWasPressed:(id)sender {
    FBFriendPickerViewController *friendPickerController = (FBFriendPickerViewController*)sender;
    id<FBGraphUser> friend = (id<FBGraphUser>)friendPickerController.selection;

    
    [[sender presentingViewController] dismissViewControllerAnimated:YES completion:^{
        [[NBAPIClient sharedAPIClient] addNewGameWithOpponentFacebookId:[friend objectID] success:^(NBGameObject *gameObject) {
            NBMainGameViewController *gameController = [[NBMainGameViewController alloc] init];
            [gameController setGameObject:gameObject];
        } failure:^(NSError *error) {
            NSLog(@"error: %@", error.userInfo);
        }];
    }];
}

/*
 * Event: Cancel button clicked
 */
- (void)facebookViewControllerCancelWasPressed:(id)sender {
    NSLog(@"Canceled");
    // Dismiss the friend picker
    [[sender presentingViewController] dismissViewControllerAnimated:YES completion:nil
     ];
}


#pragma mark - getters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
        [refresh addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
        [_tableView addSubview:refresh];
    }
    return _tableView;
}







@end
