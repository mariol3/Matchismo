//
//  Deck.h
//  Matchismo
//
//  Created by Mario Grimaldi on 02/05/14.
//  Copyright (c) 2014 Mario. All rights reserved.
//
//  Generic deck of cards class

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
