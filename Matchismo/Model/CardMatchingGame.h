//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Mario Grimaldi on 03/05/14.
//  Copyright (c) 2014 Mario. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                 withCardsToMatch:(NSUInteger)cardsToMatch;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSUInteger score;
@property (nonatomic) NSUInteger cardsToMatch;
@property (nonatomic, readonly) NSArray *lastChosenCards;
@property (nonatomic, readonly) NSInteger lastScore;

@end
