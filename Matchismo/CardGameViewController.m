//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Mario Grimaldi on 02/05/14.
//  Copyright (c) 2014 Mario. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *actionsLabel;
@property (nonatomic, strong) NSMutableArray *chosenCards;
@end

@implementation CardGameViewController

- (NSMutableArray *)chosenCards {
    if (!_chosenCards) _chosenCards = [[NSMutableArray alloc] init];
    return _chosenCards;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    int choosenButtonIndex = [self.cardButtons indexOfObject:sender];
    self.actionsLabel.text = [[self.game cardAtIndex:choosenButtonIndex] contents];
    [self.game chooseCardAtIndex:choosenButtonIndex];
    [self.chosenCards addObject:[NSNumber numberWithInt:choosenButtonIndex]];
    self.gameModeSegmentedControl.enabled = NO;
    [self updateUI];
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (CardMatchingGame *)createGame {
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                             usingDeck:[self createDeck]];
}

- (CardMatchingGame *)game {
    if (!_game) _game = [self createGame];
    return _game;
}

- (void)updateUI {
    
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Punteggio: %d", self.game.score];
    
    if (self.game) {
        NSString *description = @"";
        if ([self.game.lastChosenCards count]) {
            NSMutableArray *cardContents = [NSMutableArray array];
            for (Card *card in self.game.lastChosenCards) {
                [cardContents addObject:card.contents];
            }
            description = [cardContents componentsJoinedByString:@" "];
        }
        if (self.game.lastScore > 0) {
            description = [NSString stringWithFormat:@"Match tra %@ per %d punti.", description, self.game.lastScore];
        } else if (self.game.lastScore < 0) {
            
            description = [NSString stringWithFormat:@"%@ non matchano! %d punti di penalità!", description, -self.game.lastScore];
        }
        self.actionsLabel.text = description;
    }
}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)touchResetButton {
    // reset deck
    self.game = [self createGame];
    self.gameModeSegmentedControl.enabled = YES;
    
    // reset all UI
    [self updateUI];
}

- (IBAction)gameModeChanged:(UISegmentedControl *)sender {
    NSUInteger cardsToMatch = (sender.selectedSegmentIndex == 0) ? 2 : 3;
    
    self.game.cardsToMatch = cardsToMatch;
}

@end
