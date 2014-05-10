//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Mario Grimaldi on 03/05/14.
//  Copyright (c) 2014 Mario. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSUInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, strong) NSArray *lastChosenCards;
@property (nonatomic, readwrite) NSInteger lastScore;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (NSUInteger)cardsToMatch {
    if (_cardsToMatch < 2) _cardsToMatch = 2;
    return _cardsToMatch;
}

static const int DEFAULT_CARDS_TO_MATCH = 2;

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck {
    return [self initWithCardCount:count
                         usingDeck:deck
                  withCardsToMatch:DEFAULT_CARDS_TO_MATCH];
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                 withCardsToMatch:(NSUInteger)cardsToMatch {
    self = [super init];
    
    if (self) {
        for (int i=0; i < count; i++) {
            Card *randomCard = [deck drawRandomCard];
            if (randomCard) {
                [self.cards addObject:randomCard];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    if (cardsToMatch > 0 && cardsToMatch <= [self.cards count]) {
        self.cardsToMatch = cardsToMatch;
    }
    else {
        self = nil;
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}


static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            NSMutableArray *otherCards = [NSMutableArray array];
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [otherCards addObject:otherCard];
                }
            }
            
            self.lastScore = 0;
            self.lastChosenCards = [otherCards arrayByAddingObject:card];
            if ([otherCards count]+1 == self.cardsToMatch) {
                int matchScore = [card match:otherCards];
                
                if (matchScore) {
                    self.lastScore = matchScore * MATCH_BONUS;
                    card.matched = YES;
                    for (Card *otherCard in otherCards) {
                        otherCard.matched = YES;
                    }
                }
                else {
                    self.lastScore = - MISMATCH_PENALTY;
                    for (Card *otherCard in otherCards) {
                        otherCard.chosen = NO;
                    }
                }
            }
            
            self.score += self.lastScore - COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

@end
