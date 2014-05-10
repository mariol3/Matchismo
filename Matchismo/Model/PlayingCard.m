//
//  PlayingCard.m
//  Matchismo
//
//  Created by Mario Grimaldi on 02/05/14.
//  Copyright (c) 2014 Mario. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
@synthesize suit = _suit;

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

// Returns the card as a NSString.
// For example the three of hearts -> 3♥
- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankString];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

// Check if the card match, in suit or rank, with an array
// of other cards.
// Currently only the match with one single other card is supported
- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = 4;
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        }
    } else if ([otherCards count] == 2) {
        for (PlayingCard *otherCard in otherCards) {
            if (otherCard.rank == self.rank) {
                score += 4;
            } else if ([otherCard.suit isEqualToString:self.suit]) {
                score += 1;
            }
        }
    }
    
    return score;
}

+ (NSArray *)validSuits {
    return @[@"♥", @"♦",@"♠",@"♣"];
}

+ (NSArray *)rankString {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank {
    return [[PlayingCard rankString] count] - 1;
}

@end
